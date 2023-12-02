# Example 1
class Point
  attr_accessor :x
  attr_accessor :y

  def initialize(x=nil,y=nil)
    @x = x
    @y = y
  end
end

point = Struct.new(:x, :y)

point
point.class
point.name

# Example 2: Alternative to the above
point = Struct.new(:x, :y)

point
point.class
point.name

# Typically when we create Structs in Ruby
# we immediately assign the resulting class to a constant

Point = point
Point
point
point.class
point.name

# Ruby has a very special rule for
# when an anonymous class or module is assigned to a constant for the first time.
# When that happens, Ruby sets the name of the class or module
# to the name of the constant. This only happens once.

Location = Point
Location

# Example 3: Let's instantiate Point objects

Point.new
Point.new(45)
Point.new(6, 7)

# Example 4: And get and set attribute values
p = Point.new(2,3)
p.x
p.y
p.x = 7
p.x

# one line struct is equal to the 9-line class at the start

# Example 5: get and set values using hash-like syntax
p[:x]
p["y"]
p[:x] = 18


# Example 6: check for equality
Point.new(5,3) == Point.new(5,3) # => true
Point.new(5,3) == Point.new(3,5) # => false

# Example 7: access attributes
p = Point.new(3,5)
p.members

p.each do |value|
  puts value
end

p.each_pair do |name, value|
  puts "#{name}: #{value}"
end

# Example 8: structs include `Enumerable`
p.max
p.reduce(&:+)

# Example 9: define additional methods
Point = Struct.new(:x, :y) do
  def to_s
    "(#{x}x#{y})"
  end
end

Point.new(3,5).to_s

# Example 10: OpenStruct

require "ostruct"
location_hash = {
  "name": "Bondi Beach",
  "region": "Sydney",
  "state": "NSW",
  "postcode": "2026",
  "timezone": "Australia/Sydney",
  "lat": -33.89054,
  "lng": 151.27486,
}
loc = OpenStruct.new(location_hash)
loc.name

# Example 11
# OpenStruct is more bare-bones version, with some features missing
# For example, no iterating through keys or values

require 'ostruct'
s  = Struct.new(:foo, :bar).new(42, 32)
os = OpenStruct.new(foo: 42, bar: 23)
s.members                       # => [:foo, :bar]
os.members                      # => nil
s.map {|value| value * 2}       # => [84, 64]
os.map {|value| value * 2}      # => nil


# Struct is instantiated with positional arguments
# OpenStruct is instantiated with a hash of keys and values

# Example 12: instantiating a Struct with an added `.from_hash` method
Location = Struct.new(:name, :region, :state, :postcode, :timezone, :lat, :lng) do
  def self.from_hash(attributes)
    instance = self.new
    attributes.each do |key, value|
      instance[key] = value
    end
    instance
  end
end

loc = Location.from_hash(location_hash)
loc.members
loc.to_h
