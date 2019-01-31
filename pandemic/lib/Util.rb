class Util
  def self.show_list(arr)
    arr.map { |elem| elem.to_s }.join(',')
  end

  def self.show_hash(hash, key = true)
    vals = hash.map do |key, value|
      key == true ? key.to_s : value.to_long_s
    end
    vals.join("
      ")
  end
end