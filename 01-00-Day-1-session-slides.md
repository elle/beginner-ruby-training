autoscale: true
footer: Blackmill
slidenumbers: true
slide-transition: fade(0.4)

[.slidenumbers: false]
# Day 1 session plan

1. Intros
1. What would you like to learn
1. Stylish Ruby
1. Debugging in Ruby
1. Top level constants
1. Blocks, procs, and lambdas
1. Enumerable
1. Beware of Nil
1. Structs
1. SOLID principles
1. Refactoring

---
# Intros

- Name
- Anything you wish about your background
- What is your current role/team/camp
- Some interesting fact about you
- What is your favourite thing about Ruby

---
# What would you like to learn

---
# Stylish Ruby

Why should we care about Ruby conventions?

---
# File naming conventions

1. Snake-case file names (`my_file.rb` rather than `myFile.rb` or `my-file.rb`)
1. Match file names to the class name -- e.g. a file containing the class `CreditCheck` should be `credit_check.rb`

---
```ruby
# /credit_card/visa.rb
module CreditCard
  class Visa
  end
end
```

---
# Directory structure

1. `lib` for source code
1. `test` for test files (or `spec`)
1. `bin` for any "executable" files

```
/lib/credit_check/visa.rb
/test/credit_check/visa_test.rb
```

---
# Naming is hard
Aim to describe things well, as to not to confuse whomever is reading the code

---
# What about comments?

---
# Style guides to check out

- [thoughtbot's guides](https://github.com/thoughtbot/guides)
- [GitHub's style guide](https://github.com/github/rubocop-github/blob/main/STYLEGUIDE.md)
- [Ruby style at Ada Academy](https://github.com/Ada-Developers-Academy/jump-start-live/blob/master/lessons/day1/style.md)

---
# Suggestions

- Avoid conditional modifiers (lines that end with conditionals)
- Avoid multiple assignments per line (`one, two = 1, 2`)
- Avoid ternary operators (`boolean ? true : false`). Use multi-line `if` instead to emphasise code branches.
- Avoid bang (`!`) method names. Prefer descriptive names.
- Prefer `&:method_name` to `{ |item| item.method_name }` for simple method calls.
- Use `_` for unused block parameters.
- Prefer `each` to `for`

---
```ruby
# example 1
shopping_list = [
 :apple,
 :orange,
 :banana
]

# example 2
# and we want to .downcase the slug
def slugify(title)
  title.tr_s "^A-Za-z0-9", "-"
end

# example 3
def initialize(filter, user, topics)
  @filter, @user, @topics_input = filter, current_user, topics
end
```

---
# And for Rails:

- Use `def self.method`, not the `scope :method` DSL
- Avoid instantiating more than one object in controllers
- Don't reference a model class directly from a view
- Don't use instance variables in partials. Pass local variables to partials from view templates
- Don't use SQL or SQL fragments (`where('inviter_id IS NOT NULL')`) outside of models
- Use only one instance variable in each view
- Use `db/seeds.rb` for data that is required in all environments
- Use `dev:prime` rake task for development environment seed data

---
## Rails Migrations
- If there are default values, set them in migrations.

## Routes
  - Avoid `member` and `collection` routes.
  - Order resourceful routes alphabetically by name.
  - Use the `:only` option to explicitly state exposed routes.

---
# Sandi Metz's rules

1. Classes can be no longer than one hundred lines of code.
- Methods can be no longer than five lines of code.
- Pass no more than four parameters into a method. Hash options are parameters.
- Controllers can instantiate only one object. Therefore, views can only know about one instance variable and views should only send messages to that object (`@object.collaborator.value` is not allowed).

---
# Activity

Fix the code example in the `01-01-fix-my-style.rb` exercise so that it conforms to the Ruby style guide.

---
# Further resources

- [Rules by Sandi Metz](https://www.youtube.com/watch?v=npOGOmkxuio) at Baruco 2013 (video, 35 mins watch)
- [What’s in a Name? Anti-Patterns to a Hard Problem](http://www.sitepoint.com/whats-in-a-name-anti-patterns-to-a-hard-problem/) by Katrina Owen
  (article, 10 mins read)
- [A client project two years later](https://robots.thoughtbot.com/a-client-project-two-years-later)
  (article, 13 mins read)

---
# Debugging in Ruby

---
# Get feedback and verify assumptions

How do we verify our assumptions?

---
# How to use a stack trace

1. Look for the top or end of the trace.
1. Look for the lines that refer to the code that we've written.
1. Read the error message twice before doing anything.
1. Focus on two things, what did we try to do, and to what did we try to do it?

---
For example:

```
NoMethodError: undefined method `+' for nil:NilClass
```

A diligent reading of this error message will tell us two things off the bat:

1. We tried to add something to an object
1. That object was `nil`, which does not support adding to it

---
### [Better errors](https://github.com/charliesome/better_errors)

A wonderful replacement for the default rails error page in development.

---
# Temporary instructions

- `warn` - a Ruby `Kernel` method
- raising exceptions, for example `raise @product.inspect`
- `puts` or `print` statements (or Puts Driven Development)

---
# Ruby debugging checklist

1. Check the line number.
1. Read the error the message. Like all of it. Seriously.
1. Add a call to `debugger` before (and maybe after).
1. Confirm all variable values.
1. Re-read the code that generated the error.
1. Read the entire test, its description, and the `describe`, and `it` blocks.
1. Reconfirm what the purpose of the unit of code that the error is in.
1. Go for a walk!

---
# Checklist continued
1. Confirm the type of objects.
1. Confirm the level of nested data structures.
1. Tell a story (to your rubber duck, cat, fellow team member), out loud, about what you are trying to do.
1. Avoid the rabbit hole and try not to yak shave.
1. Work through one error at a time.
1. Run every change you are doing.
1. Copy the method to Pry or Debugger or Console and try to run it in isolation.
   For example, grab the params sent to the controller action,
   and use them in Console when trying to do the same action.
1. Confirm your return values.
1. Confirm the values of your arguments.
1. Ask someone.

---
# Ask someone

But how to?


---
# Interactive debuggers

### Pry or Byebug

In `Gemfile`, I actually use this:

`gem "pry-byebug"`

so that we can use either one we prefer.

---
# Activity

Clone [Erroneous Creatures](https://github.com/turingschool-examples/erroneous_creatures) repository.

It contains some implementations of the Mythical Creatures exercises that are riddled with small bugs.

---
# Top level constants

Check `01-03-constants.rb`

---
# Blocks, procs, and lambdas

---
# Warmup

Write a bit of Ruby code to do the following:

1. Take the names of the two people sitting next to you. Generate a new list (`Array`) of those names where all of the vowels are removed.
1. Write this once using an enumerable and once without (use a `for` or `while` loop for example)

---
# Question

- What is the differences between these two pieces of code?

---
# Blocks terminology

- A "block" of code
- Notation `{}` or using `do...end`
- Technically, when we pass a block, we pass a Procedure object
- This object is a `Proc`, which is the Ruby class, which represents the idea of "a chunk of code saved for later use"

---
## What actually happens when we pass a block to a method?

Rules:

1. Ruby allows a Block to be passed to any method as an optional final argument
1. It is up to the methods implementation to determine how (or even if) to use the provided block

---
Check `01-04-blocks-procs-lambdas.md`

```ruby
def print_name(name)
  puts name
end
=> :print_name

print_name("elle") { puts "hello" }
elle
=> nil
```

---
# So how do we use (or not ignore) a block?

- `yield` and `block_given?`
- Explicitly "capture" the block param

---
# Procedures AKA Procs

- `Proc` is Ruby's class for representing stored collections of Ruby instructions

---
# Invoking a Proc

If a proc represents the idea of a stored "procedure", we need some way to "un-store" it, i.e. to evaluate it.

There are three ways:

1. `Proc#call`
1. `Proc.()`
1. `Proc[]`

---
# Lexical scope, local variables, and closures

Procs bind a chunk of code (anonymous method) to a collection of local variables.

We call this collection of variables a "lexical context".

---
- A block share (and update) the local variables that were defined in the context _in which it was created_.
- This behaviour is what we describe as a _closure_. We say the block "closes over" the local variables, allowing it to take them with it.
- Closures are portable just like `procs`.

---
- Within a method `#yield` provides a separate means of invoking a block, with the ability to pass arguments to a block (which then become block arguments).

---
# Procs vs Lambdas

lambdas basically a subtype of proc with only two differences:

1. Lambdas are strict about their number of arguments (arity).
  `Proc.new` object is very forgiving of
  the number of arguments passed to its `call` method.
1. Lambdas use the `return` keyword,
  which will return only from the local context i.e the block itself.
  In a proc this will return from the surrounding method context.

---
# Activity

**1: Each with a proc:** write your own each method which takes two arguments: an array and a proc. Execute the proc for each element in the array using `call`.
For example:

```ruby
def my_each(array, &block)
  # stuff
end
```

Make sure your each method returns the original collection when it's done

---
**2: Map with a proc:** do the same as above but this time for map.

Make sure your map method returns the collection of new values when it's done

---
# Enumerable

---
`Enumerable`, in Ruby, is a set of methods for collections. They are used in all the common collection classes.

To use Enumerable, a class needs to define its own `each` method.
All Enumerables are abstractions on top of `each`.

Check `01-05-enumerable.md`

---
## Raw enumeration, no useful result

> I want to go through the collection and do some arbitrary operation,
> often throwing away the return value.

- `each`
- `each_with_index`

---
## Result is a collection

> I want to take the elements I have, maybe filter them, and create a new collection from them.

- `sort`
- `select`
- `map`
- `reject`

---
## Result is one element of the collection

> I want to find one special element within the collection

- `find` and `detect`
- `max` and `min`
- `first` and `last`

---
## Result is a Boolean

> Is this question about the collection true or false?

- `all?`
- `none?`
- `any?`
- `one?`

---
## Result is a new value

> Based on the elements in the collection, calculate a single new value

- `reduce` (`inject`)
- `sum`
- `length`

---
```ruby
collection.inject(starting_value) { |running_total, variable| block }
```

---
## Result is a new-shaped collection

- `group_by`
- `zip`

---
# Activity

Check out `01-05-enumerable.rb`

---
# Nil in Ruby

Check `01-06-nil.rb`

---
# Activity

Animal Farm exercise

---
# Structs

Check `01-07-structs.rb`

---
# SOLID principles

Check `01-08-solid.md`

---
# Refactoring

Refactor a store example.
Check dir `01-09-refactoring-store/`

---
# Daily reflection ritual

[https://tally.so/r/w8aEBY](https://tally.so/r/w8aEBY)

---
# Daily feedback

[https://tally.so/r/wd9v0N](https://tally.so/r/wd9v0N)