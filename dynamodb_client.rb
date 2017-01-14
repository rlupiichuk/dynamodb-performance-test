class DynamoDBClient
  READ_CAPACITY = 80
  WRITE_CAPACITY = 80

  def put_item(table_name, opts)
    with_retry { aws_client.put_item({ table_name: table_name }.merge(opts)) }
  end

  def get_item(table_name, opts)
    with_retry { aws_client.get_item({ table_name: table_name }.merge(opts)) }
  end

  def query(table_name, opts)
    with_retry { aws_client.query({ table_name: table_name }.merge(opts)) }
  end

  def recreate_table(table_name)
    with_retry { drop_table(table_name) }
    with_retry { create_table(table_name) }
    wait_for_table(table_name)
  end

  def drop_table(table_name)
    aws_client.delete_table(table_name: table_name)
  rescue Aws::DynamoDB::Errors::ResourceNotFoundException
    false
  end

  def create_table(table_name)
    table_settings = {
      table_name:             table_name,
      attribute_definitions:  [{ attribute_name: 'uuid', attribute_type: 'S' }],
      provisioned_throughput: { read_capacity_units: READ_CAPACITY, write_capacity_units: WRITE_CAPACITY },
      key_schema:             [{ attribute_name: 'uuid', key_type: 'HASH' }]
    }

    if table_name == 'performance-2' || table_name == 'performance-3'
      table_settings[:attribute_definitions] += [{ attribute_name: 'content_id', attribute_type: 'S' }]
      table_settings[:global_secondary_indexes] = [{
        index_name:             'content_id_index',
        projection:             { projection_type: 'ALL' },
        provisioned_throughput: { read_capacity_units: READ_CAPACITY, write_capacity_units: WRITE_CAPACITY },
        key_schema:             [{ attribute_name: 'content_id', key_type: 'HASH' }]
      }]
    end

    if table_name == 'performance-3'
      table_settings[:attribute_definitions] += [{ attribute_name: 'created_at', attribute_type: 'N' }]
      table_settings[:global_secondary_indexes] += [{
        index_name:             'content_id_created_at_index',
        projection:             { projection_type: 'ALL' },
        provisioned_throughput: { read_capacity_units: READ_CAPACITY, write_capacity_units: WRITE_CAPACITY },
        key_schema: [
          { attribute_name: 'content_id', key_type: 'HASH' },
          { attribute_name: 'created_at', key_type: 'RANGE' }
        ]
      }]
    end

    aws_client.create_table(table_settings)
  end

  def with_retry
    tries ||= 15
    yield
  rescue Aws::DynamoDB::Errors::ItemCollectionSizeLimitExceededException,
         Aws::DynamoDB::Errors::LimitExceededException,
         Aws::DynamoDB::Errors::ProvisionedThroughputExceededException,
         Aws::DynamoDB::Errors::ThrottlingException,
         Aws::DynamoDB::Errors::UnrecognizedClientException,
         Aws::DynamoDB::Errors::ResourceInUseException,
         Aws::DynamoDB::Errors::ResourceNotFoundException => e
    raise e if (tries -= 1) == 0
    sleep((14 - tries) * 0.2)
    retry
  end

  def wait_for_table(table_name)
    5.times do
      begin
        with_retry { put_item(table_name, item: { uuid: SecureRandom.uuid, content_id: SecureRandom.uuid, created_at: Time.now.to_i }) }
        break
      rescue Aws::DynamoDB::Errors::ResourceNotFoundException
        false
      end
    end
  end

  def aws_client
    @client ||= if ENV['AWS_ACCESS_KEY_ID'].nil?
                  Aws::DynamoDB::Client.new(region: ENV['AWS_REGION'])
                else
                  Aws::DynamoDB::Client.new(region: ENV['AWS_REGION'], endpoint: 'http://dynamodb:8000')
                end
  end
end
