require './po.rb'

scores = [4,8,7,2,2,4,2,8,4]

lower_limit = [4,2,5]
upper_limit = [8,4,100]

# lower_limit = [2]
# upper_limit = [4]

puts "Final Answers: #{jobOffers(scores, lower_limit, upper_limit).inspect}"
