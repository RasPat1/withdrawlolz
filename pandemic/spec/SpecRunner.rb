Dir["./*.rb"].each { |file| require file}

class SpecRunner
end

PandemicSpec.new.test
BoardSpec.new.test
CitySpec.new.test
PlayerSpec.new.test