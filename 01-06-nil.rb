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
