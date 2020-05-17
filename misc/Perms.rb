# Find all permutations of a string with no duplicate letters

class Perms
  # Remove and store the last character from the string
  # Find all permutations of the resulting substring
  # Modify each of the resulting permutations by inserting the
  # => last character of the original string in each possible
  # => position of each permutation
  def call(str)
    return [str] if str.size <= 1
    results = []


    str, last_char = str[0..-2], str[-1]

    perms = Perms.new.call(str)
    perms.each do |perm|
      results << last_char + perm

      perm.size.times do |index|
        prefix = perm[0..index]
        suffix = perm[(index + 1)..-1]

        results << prefix + last_char + suffix
      end
    end

    # No dupe chars allowed!
    raise Exception.new("Woooah Nelly") unless results.size == results.uniq.size

    results
  end
end


str = 'abcd'
results = Perms.new.call(str)
puts results
puts results.size