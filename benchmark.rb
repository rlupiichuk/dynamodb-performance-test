require 'bundler'
Bundler.require(:default)
require 'benchmark'
require 'json'
require './benchmark_helpers'
require './dynamodb_client'

ENV['AWS_REGION'] = 'eu-west-1'

if ARGV[0] != 'live'
  ENV['AWS_ACCESS_KEY_ID'] = 'x'
  ENV['AWS_SECRET_ACCESS_KEY'] = 'x'
end

SAMPLE_DATA = JSON.parse('{"asset_type":"video","id":"v-123123","tenant_id":"t-321321","duration":19570,"title":{"de":"\u0391\u03bd\u03b1\u03c6\u03ad\u03c1\u03bf\u03bd\u03c4\u03b1\u03b9 \u03b4\u03b9\u03b5\u03c5\u03b8\u03c5\u03bd\u03c4\u03ad\u03c2 \u03bc\u03b9\u03b1\u03c2 \u03b1\u03c0\u03cc \u03c0\u03b9\u03bf \u03c0\u03ae\u03c1\u03b5 \u03b1\u03bd.","en":"\u03a3\u03c5\u03b3\u03c7\u03c1\u03cc\u03bd\u03c9\u03c2 \u03c3\u03c4\u03b7 \u03c3\u03c5\u03b3\u03ba\u03b5\u03bd\u03c4\u03c1\u03c9\u03bc\u03ad\u03bd\u03bf\u03b9 \u03bc\u03b7\u03bd \u03ad\u03bd\u03b1 \u03bd\u03ad\u03b1 \u03c0\u03ac\u03bd\u03c4\u03c9\u03c2."},"description":{"de":"\u03a0\u03b9\u03bf \u03b5\u03b9\u03b4\u03b9\u03ba\u03ac \u03b5\u03bd\u03c4\u03bf\u03bb\u03ad\u03c2 \u03b1\u03c0\u03bf\u03c3\u03c4\u03b7\u03b8\u03af\u03c3\u03b5\u03b9 \u03bc\u03ac\u03c4\u03c3\u03bf \u03b8\u03b1 \u03b1\u03c1\u03c7\u03b5\u03af\u03b1. \u03a6\u03af\u03bb\u03bf\u03c2 \u03c0\u03b9\u03bf \u03b2\u03b3\u03ae\u03ba\u03b5 \u03ba\u03bf\u03b9\u03c4\u03ac\u03b6\u03bf\u03bd\u03c4\u03b1\u03c2 \u03bc\u03ac\u03c4\u03c3\u03bf \u03ba\u03c1\u03b1\u03c4\u03ac\u03b5\u03b9 \u03c3\u03c4\u03b1\u03bc\u03b1\u03c4\u03ac\u03c2. \u0394\u03b5 \u03bd\u03ad\u03c9\u03bd \u03ba\u03b1\u03bb\u03cd\u03c4\u03b5\u03c1\u03bf \u03c4\u03b7\u03c2 \u03ac\u03c4\u03bf\u03bc\u03bf \u03bb\u03b5\u03c4\u03c0\u03ac \u03c3\u03c5\u03b3\u03ba\u03b5\u03bd\u03c4\u03c1\u03c9\u03bc\u03ad\u03bd\u03bf\u03b9.","en":"\u0392\u03b1\u03b8\u03bc\u03cc \u03c3\u03c4\u03b9\u03c2 \u03bd\u03ad\u03c9\u03bd \u03ba\u03ce\u03b4\u03b9\u03ba\u03ac\u03c2 \u03ce\u03c1\u03b1 \u03c0\u03b5\u03c1\u03af\u03c0\u03bf\u03c5 \u03bc\u03ad\u03c3\u03b7\u03c2. \u03a7\u03b1\u03c1\u03c4\u03b9\u03bf\u03cd \u03c3\u03c5\u03b3\u03b3\u03c1\u03b1\u03c6\u03b5\u03af\u03c2 \u03ba\u03b5\u03b9\u03bc\u03ad\u03bd\u03c9\u03bd \u03c0\u03b5\u03c1\u03af\u03c0\u03bf\u03c5 \u03b5\u03ba\u03c4\u03cc\u03c2 \u03b5\u03ba\u03c4\u03cc\u03c2. \u039d\u03b1\u03b9 \u03ad\u03c7\u03c9 \u03c3\u03c5\u03b3\u03c7\u03c1\u03cc\u03bd\u03c9\u03c2 \u03b5\u03be\u03b1\u03ba\u03bf\u03bb\u03bf\u03c5\u03b8\u03b5\u03af \u03c3\u03c5\u03b3\u03b3\u03c1\u03b1\u03c6\u03b5\u03af\u03c2."},"keywords":["\u03ad\u03c7\u03c9","\u03bc\u03b5","\u03ad\u03c4\u03c3\u03b9","\u03b4\u03bf\u03ba\u03b9\u03bc\u03ac\u03c3\u03b5\u03b9\u03c2","\u03c4\u03b1\u03be\u03b9\u03bd\u03bf\u03bc\u03b5\u03af","\u03ba\u03c1\u03b1\u03c4\u03ac\u03b5\u03b9","\u03c3\u03c5\u03b3\u03b3\u03c1\u03b1\u03c6\u03ae\u03c2","\u03ac\u03c1\u03b1","\u03b4\u03cd\u03bf","\u03b1\u03c0\u03af\u03c3\u03c4\u03b5\u03c5\u03c4\u03b1"],"copyright":"\u0388\u03be\u03b9 \u03c7\u03b1\u03c1\u03c4\u03b9\u03bf\u03cd \u03c3\u03c7\u03b5\u03b4\u03b9\u03b1\u03c3\u03c4\u03ae\u03c2 \u03c0\u03c1\u03bf\u03b2\u03bb\u03b7\u03bc\u03b1\u03c4\u03b9\u03ba\u03ae \u03c3\u03c4\u03ad\u03bb\u03bd\u03bf\u03bd\u03c4\u03ac\u03c2. \u0394\u03b9\u03b1\u03c7\u03b5\u03b9\u03c1\u03b9\u03c3\u03c4\u03ae\u03c2 \u03b3\u03b9\u03b1 \u03bc\u03b7\u03c7\u03b1\u03bd\u03ae\u03c2 \u03b1\u03c0\u03cc \u03b1\u03ba\u03bf\u03cd\u03c3\u03b5\u03b9. \u0386\u03c1\u03b1 \u03c0\u03b9\u03bf \u03c0\u03c1\u03bf\u03c3\u03c0\u03b1\u03b8\u03bf\u03cd\u03bd \u03b3\u03bd\u03c9\u03c1\u03af\u03b6\u03bf\u03c5\u03bc\u03b5 \u03b1\u03c5\u03c4\u03ae\u03bd \u03bc\u03b9\u03b1\u03c2 \u03c3\u03b7\u03bc\u03b5\u03af\u03b1.","language":"xx","release_date":"1973-04-16T00:00:00+0000","product_placement":false,"created_at":1475584275,"modified_at":null,"version":1,"feed_id":"bunte","age_ratings":["FSK\/\/FSK12"],"geo_locations":["US"],"transcoding_status":"available","start_date_absolute":489521696,"end_date_absolute":null,"drm":true,"entitlement":false,"device_classes":["browser"],"bandwidth_max":{"browser":"700"},"max_resolution":0,"source_id":"629de9ac11","mds_usecase":false,"is_locked":false,"internal_status":null,"is_deleted":false,"active":true}').freeze

client = DynamoDBClient.new

tables = ['performance-1', 'performance-2', 'performance-3']
records = [1_000, 10_000, 100_000]
threads = [20, 40, 60, 80, 100]

tables.each do |table|
  records.each do |num_records|
    avg_read_times   = []
    avg_write_times  = []
    top_read_times   = []
    top_write_times  = []
    full_write_times = []
    avg_query_times  = []
    top_query_times  = []

    BenchmarkHelpers.log_to_file "records: #{num_records}, table: #{table}"

    threads.each do |num_threads|
      client.recreate_table(table)
      uuids = []
      content_ids = []

      times = Parallel.map(0..num_records, in_threads: num_threads) do |i|
        BenchmarkHelpers.progress(i)
        uuids << SecureRandom.uuid
        content_ids << SecureRandom.uuid
        Benchmark.measure do
          client.put_item(table, item: { uuid: uuids.last, content_id: content_ids.last, created_at: Time.now.to_i, data: SAMPLE_DATA })
        end.real
      end

      avg_write_times << BenchmarkHelpers.avg(times)
      top_write_times << BenchmarkHelpers.top_avg(times)
      full_write_times << BenchmarkHelpers.full_avg(times)

      times = Parallel.map(0..num_records, in_threads: num_threads) do |i|
        BenchmarkHelpers.progress(i)
        uuid = uuids.sample
        Benchmark.measure do
          client.get_item(table, key: { uuid: uuid })
        end.real
      end

      avg_read_times << BenchmarkHelpers.avg(times)
      top_read_times << BenchmarkHelpers.top_avg(times)

      if table == 'performance-2' || table == 'performance-3'
        times = Parallel.map(0..num_records, in_threads: num_threads) do |i|
          BenchmarkHelpers.progress(i)
          content_id = content_ids.sample
          Benchmark.measure do
            client.query(table, index_name: 'content_id_index', key_condition_expression: 'content_id = :content_id', expression_attribute_values: { ':content_id' => content_id })
          end.real
        end

        avg_query_times << BenchmarkHelpers.avg(times)
        top_query_times << BenchmarkHelpers.top_avg(times)
      end
    end

    data = [avg_write_times, top_write_times, full_write_times,
            avg_read_times, top_read_times,
            avg_query_times, top_query_times]

    BenchmarkHelpers.log_to_file Gchart.line(
      title: "#{table} (size #{num_records})",
      size: '600x300',
      data: data,
      axis_with_labels: 'x,y',
      line_colors: 'da4242,d141b9,41d1c3,41d146,27477a,35277a',
      legend: ['Write avg', 'Write top avg', 'Write full avg', 'Read avg', 'Read top avg', 'Query avg', 'Query top avg'],
      axis_labels: [threads.map(&:to_s).join('|')],
      axis_range: [nil, BenchmarkHelpers.minmax(data)]
    )
  end
end

tables.each { |table| client.drop_table(table) }
