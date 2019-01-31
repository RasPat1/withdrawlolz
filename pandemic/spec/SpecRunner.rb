Dir["./spec/*.rb"].each do |file|
  next if file == './spec/SpecRunner.rb'
  require file
end

class SpecRunner
  def test
    # PandemicSpec.new.test
    # BoardSpec.new.test
    CitySpec.new.test
    # PlayerSpec.new.test
    EventSpec.new.test

    puts "All Tests Pass"
  end
end

SpecRunner.new.test