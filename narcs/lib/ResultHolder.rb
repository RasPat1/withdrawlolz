# require 'gruff'
require 'fileutils'

class ResultHolder
  attr_accessor :name, :results
  FILE_OUTPUT_TYPE = 'png'
  PATH_PREFIX = './outputs'

  def initialize(name)
    @name = name
    @results = []
  end

  def add_result(result)
    results << result
  end

  def print_results
    results.each do |result|
      puts "#{result.name}: #{result.data.size}\n\n#{result}\n\n\n"
    end
  end

  # Create a file with some visual representation of this set of results
  def print_chart
    g = Gruff::Line.new

    g.title = name
    g.y_axis_label = "Time (s)"
    g.x_axis_label = "Solutions Length"
    g.hide_dots = true

    labels = {}
    1.upto(60) do |val|
      if val % 3 == 1
        labels[val] = val.to_s
      end
    end
    g.labels = labels
    count = 0

    results.each do |result|
      xy_coords = result.data.map.with_index(1) do |solution, index|
        [
          solution.to_s.size,
          solution.elapsed_time
        ]
      end

      g.dataxy(result.name, xy_coords)
    end

    g.write(output_file_name)
  end

  def output_file_name
    # file_name = sanitize_filename(name) + '-' + Time.now.to_i.to_s
    file_name = sanitize_filename(name)
    FileUtils.mkdir_p(PATH_PREFIX)

    "#{PATH_PREFIX}/#{file_name}.#{FILE_OUTPUT_TYPE}"
  end

  # https://stackoverflow.com/questions/1939333/how-to-make-a-ruby-string-safe-for-a-filesystem
  def sanitize_filename(file_name)
   # NOTE: File.basename doesn't work right with Windows paths on Unix
   # get only the file_name, not the whole path
   file_name = file_name.gsub(/^.*(\\|\/)/, '')

   # Strip out the non-ascii character
   file_name = file_name.gsub(/[^0-9A-Za-z.\-]/, '_')

   file_name = file_name.downcase
   file_name = file_name.gsub(' ', '_')

   file_name
  end
end


