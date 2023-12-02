# Example 1
def print_name(name)
  puts name
end
print_name("elle") { puts "hello" }


# So how do we use (or not ignore) a block?
# - `yield` and `block_given?`
# - Explicitly "capture" the block param

# Example 2
def print_name(name)
  yield if block_given?
  puts name
end
print_name("elle") { puts "hello" }
print_name("elle")

# Procedures AKA Procs
# `Proc` is Ruby's class for
# representing stored collections of Ruby instructions

# Example 3
# We can also explicitly "capture" the block parameter:
def print_name(name, &block)
  puts block.class
  puts name
end

print_name("elle") { puts "hello" }


# Example 4
def print_name(name, &block)
  block.call
  puts name
end
print_name("elle") { puts "hello" }


# Invoking a Proc
# If a proc represents the idea of a stored "procedure",
# we need some way to "un-store" it, i.e. to evaluate it.
# There are three ways:
#
# 1. `Proc#call`
# 2. `Proc.()`
# 3. `Proc[]`

# Example 5
greet = proc do |name|
  puts "Hello, #{name}"
end

greet.call("Bob")
greet.("Jill")
greet["Hannah"]


# Lexical scope, local variables, and closures
# Procs bind a chunk of code (anonymous method)
# to a collection of local variables.
# We call this collection of variables a "lexical context".
#
# A block share (and update) the local variables
# that were defined in the context _in which it was created_.
# This behaviour is what we describe as a _closure_.
#
# We say the block "closes over" the local variables,
# allowing it to take them with it.
#
# Closures are portable just like `procs`.

# Example 6
x = 5

def method_cant_see_surrounding_local_vars
  puts x
end
# method_cant_see_surrounding_local_vars
# => NameError: undefined local variable or method `x' for main:Object

3.times do
  puts "but procs can #{x}"
end


# Within a method `#yield` provides a separate means of invoking a block,
# with the ability to pass arguments to a block
# (which then become block arguments).

# Example 7
class Calculator
  def self.run(start:)
    yield Operations.new(start)
  end

  class Operations
    attr_reader :start
    def initialize(start)
      @start = start
    end

    def add(other)
      start + other
    end

    def multiply_by(other)
      start * other
    end

    def subtract(other)
      start - other
    end
  end
end

result = Calculator.run(start: 5) do |c|
  c.add 5
  c.multiply_by 2
  c.subtract 15
end

puts result


# Procs vs Lambdas
# lambdas basically a subtype of proc with only two differences:

# 1. Lambdas are strict about their number of arguments (arity).
#   `Proc.new` object is very forgiving of
#   the number of arguments passed to its `call` method.
# 2. Lambdas use the `return` keyword,
#   which will return only from the local context i.e the block itself.
#   In a proc this will return from the surrounding method context.

# Example 8

def method_l
 lambda { return "we just returned from the block" }.call
 return "we just returned from the calling method"
end

puts method_l
# => we just returned from the calling method

def method_p
 Proc.new { return "we just returned from the block" }.call
 return "we just returned from the calling method"
end

puts method_p
# => we just returned from the block


# Invoking lambdas

# Example 9

short = ->(a, b) { a + b }
puts short.call(2, 3)

long = lambda { |a, b| a + b }
puts long.call(2, 3)

lambda = ->() {}
lambda.class

lambda = -> (name) { puts "Hello #{name}" } 
proc = Proc.new { |name| puts "Hello #{name}" }

lambda.call("John")

proc.call("John")

lambda.call()
# => ArgumentError: wrong number of arguments (given 0, expected 1)

proc.call()
# => Hello
