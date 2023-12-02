# Examples

[2, 3, 1, 0, 5, 6].sort

people = [["Bob", 24],["Dave", 26],["Zayn", 22]]
people.sort_by { |person| person.last }

array = [1,2,3,4,5]

# instead of
result = []
array.each do |num|
  result << num if num.odd?
end
result

# use `select` or `find_all`
array.select { |num| num.odd? }

# or even better
array.select(&:odd?)

# similar with `map` or `collect`
# so instead of what we did in lines 7-13 with `each`, we can
array.map { |n| n * 2 }

# or
array.map(&2.method(:*))

# `find` and `detect` do the same
# returns the first item for which the block returns a non-false value
[1,2,3,4,5].find do |num|
  num.even?
end

[2, 3, 1, 0, 5, 6].max

people = [["Bob", 24],["Dave", 26],["Zayn", 22]]
people.max_by { |person| person.last }

[2, 3, 1, 0, 5, 6].min

["selena", "carly", "justin"].min

people.min_by { |person| person.last }

[1,1,1,1].all? { |num| num == 1 }
[1,1,1,1].all? { |num| num.eql? 1 }

words = ["dog","cat","pig","hippopotamus"]
words.all?
words.any? { |word| word.length == 3 }
words.none? { |word| word.length == 2 }
words.none? { |word| word.length == 3 }
words.one? { |word| word.length == 3 }


array = [1,2,3,4,5]
array.reduce(0) { |sum, n| sum += n }

# Shorthand version does exactly the same
array.reduce(:+)

# In case of summation, then Array has the `.sum` method
array.sum

# number of items in the array. Same as `.length`
array.count

array = ["cat", "fish", "corgi"]
array.group_by { |string| string.length }

a = %w(1 2 3)
b = %w(a b c)
a.zip(b)


# Activities
# 1. What do you think the output of the following will be? And why?

[1,2,3,4,5].map do |n|
  n * 2
  puts "Hi!"
end

# 2. Given two associated arrays.

people = [
  "Hannah",
  "Penelope",
  "Rabastan",
  "Neville",
  "Tonks",
  "Seamus",
]

houses = [
  "Hufflepuff",
  "Ravenclaw",
  "Slytherin",
  "Gryffindor",
  "Hufflepuff",
  "Gryffindor",
]

# Write a script with the following output:
#
# "Hannah is in Hufflepuff."
# "Penelope is in Ravenclaw."
# ...and so on and so forth.

# 3. Check out
# [Enumerable's docs](http://ruby-doc.org/core-2.4.1/Enumerable.html)
#
# What methods haven't we covered yet? Any of interest?
