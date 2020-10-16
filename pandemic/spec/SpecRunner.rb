Dir["./spec/*.rb"].each do |file|
  next if file == './spec/SpecRunner.rb'
  require file
end

class SpecRunner
  def test
    PandemicSpec.new.test
    BoardSpec.new.test
    CitySpec.new.test
    PlayerSpec.new.test
  end
end

SpecRunner.new.test
