require 'gruff'

class ResultHolder
  attr_accessor :name, :results
  FILE_OUTPUT_TYPE = 'png'
  PATH_PREFIX = './'

  def initialize(name)
    @name = name
    @results = []
  end

  def add_result(result)
    results << result
  end

  def print_results
    results.each do |result|
      puts "#{result.name}\n\n#{result}\n\n\n"
    end
  end

  # figure out how chart the results here
  def print_chart
    g = Gruff::Line.new
    g.title = name
    results.each do |result|
      g.dataxy(result.name, result.data.map { |solution| [solution.value, solution.elapsed_time] })
    end

    g.write(output_file_name)
  end

  def output_file_name
    "#{PATH_PREFIX}/#{name}.#{FILE_OUTPUT_TYPE}"
  end
end