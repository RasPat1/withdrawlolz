class SpecBase
  def assert(arg, name = nil)
    if arg == false
      puts "Test failed! #{name}"
      raise Exception.new
    else
      # puts "Test Passed! #{name}"
    end
  end
end