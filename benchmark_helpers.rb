module BenchmarkHelpers
  def self.log_to_file(message)
    open(log_filename, 'a') { |f| f.puts message }
    puts message
  end

  def self.log_filename
    @log_filename ||= "benchmark-#{Time.now.strftime('%Y%m%d%H%M%S')}.out"
  end

  def self.progress(index)
    print index % 100 == 0 ? index : '.'
    sleep 1
  end

  def self.minmax(values)
    flat_values = values.flatten
    [flat_values.min, flat_values.max]
  end

  def self.avg(times)
    1.0 * times.inject(&:+) / times.size
  end

  def self.top_avg(times)
    top = times.sort[-(times.size / 10)..-1]
    avg(top)
  end

  def self.full_avg(times)
    top = times[-(times.size / 10)..-1]
    avg(top)
  end
end
