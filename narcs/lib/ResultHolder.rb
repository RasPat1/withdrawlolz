require 'gruff'
require 'fileutils'

class ResultHolder
  attr_accessor :name, :results
  FILE_OUTPUT_TYPE = 'png'
  PATH_PREFIX = './outputs1'

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
    file_name = sanitize_filename(name) + Time.now.to_i.to_s
    FileUtils.mkdir_p(PATH_PREFIX)

    "#{PATH_PREFIX}/#{file_name}.#{FILE_OUTPUT_TYPE}"
  end

  # https://stackoverflow.com/questions/1939333/how-to-make-a-ruby-string-safe-for-a-filesystem
  def sanitize_filename(filename)
    filename.strip do |name|
     # NOTE: File.basename doesn't work right with Windows paths on Unix
     # get only the filename, not the whole path
     name.gsub!(/^.*(\\|\/)/, '')

     # Strip out the non-ascii character
     name.gsub!(/[^0-9A-Za-z.\-]/, '_')
    end
  end
end


