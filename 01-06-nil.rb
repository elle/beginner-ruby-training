class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def self.find(id)
    people = { 1 => new("Jil"), 2 => new("Bob") }
    people[id]
  end
end

class Subscription
  def self.create_for_person(person)
    create!(person: person, person_name: person.name)
  end

  def self.create!(*args)
    "Yay!"
  end
end

class SubscriptionController
  def create(person_id)
    person = Person.find(person_id)
    Subscription.create_for_person(person)
  end
end

puts SubscriptionController.new.create(1)


# Example 2
# class Person
#   attr_reader :subscription

#   def subscribe!
#     @subscription = Subscription.new
#   end
# end

# class Subscription
# end

# person = Person.new
# person.subscribe!
# puts person.subscription


# Example 3
# class Person
# end

# class Subscription
#   attr_reader :person
# end

# Example 4
# class Person
#   def subscribe!
#     @subscription = Subscription.new
#   end

#   def subscription
#     @subscription or raise NoSubscriptionError
#   end
# end

# class NoSubscriptionError < Exception; end

# class Subscription
# end

# person = Person.new
# if false
#   person.subscribe!
# end
# puts person.subscription


# Example 5
# class Person
#   def subscribe
#     Subscriber.new(Subscription.new)
#   end
# end

# class Subscriber
#   attr_reader :subscription

#   def initialize(subscription)
#     @subscription = subscription
#   end
# end

# class Subscription
# end

# person = Person.new
# if true
#   subscriber = person.subscribe
# end
# puts subscriber.subscription

# use your language & libraries intelligently
# invert the object relationship
# guard against nils in a manual attribute reader
# Introduce new domain concepts
