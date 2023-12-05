# Test collaborators

- Stubs
- Mocks
- Doubles
- Spies
- Null object doubles

---
# Stubs

![stubs](http://www.throwbacks.com/content/images/2017/04/pTRUCA1-19864383_alternate3_enh-z6.jpg)

Especially helpful to fake state of secondary objects that are auxiliary to our test.
They allow us to imitate _state_.

- Stubs define context
- Too many stubs are a code smell
- Avoid stubbing in the object under test
- Don't make assertions about stubs!


```ruby
# for example
allow(die).to receive(:roll) { 3 }

# BUT DO NOT DO THIS
describe "#sum" do
  it "adds two numbers" do
    allow(Calculator).to receive(:sum).with(2,3).and_return(5)
    
    result = Calculator.sum(2,3)
    
    expect(result).to eq 5
  end
end
```

---
# Mocks

![Star wards](http://vignette4.wikia.nocookie.net/starwars-exodus/images/d/d0/Death_Star.jpg/revision/latest?cb=20080831214616)

Mocks allow us to define what calls a method we are testing should make. Mocks verify what you expect to happens happens (i.e. a message have been sent). They allow us to imitate and verify _behaviour_.

- Test behaviour
- Set expectations on mocks to test outgoing command messages
- One expectation per test
- Do not stub using a mock! => don't assert the result
- **Never mock what you don't own!**


```ruby
RSpec.describe ApplicationHelper do
  describe "#markdown" do
    it "delegates to MarkdownRenderer" do
      text = "hello"
      allow(MarkdownRenderer).to receive(:render).with(text)

      helper.markdown(text)

      expect(MarkdownRenderer).to have_received(:render).with(text)
    end
  end
end
```

---

# Doubles

![Spiderverse](./images/spiderverse.jpg)

From [RSpec documentation](https://relishapp.com/rspec/rspec-mocks/v/3-7/docs/basics/test-doubles):

> Test double is a generic term for any object that stands in for a real object during a test (think "stunt double"). You create one using the double method. Doubles are "strict" by default -- any message you have not allowed or expected will trigger an error -- but you can switch a double to being "loose". When creating a double, you can allow messages (and set their return values) by passing a hash.

Once you have a test double, you can `allow` or `expect` messages on it.

We recommend you use [verifying doubles](https://relishapp.com/rspec/rspec-mocks/v/3-7/docs/verifying-doubles) whenever possible.


Another definition:

> The precise term for a fake object that takes the place of a real object when a text is executed.

And...

- `instance_double` can fail a test if methods are not available in the specified class
- `double` doesn't care about anything.


```ruby
describe "A test double" do
  it "returns canned responses from the methods named in the provided hash" do
    d = double("Some Collaborator", foo: 3, bar: 4)

    expect(d.foo).to eq(3)
    expect(d.bar).to eq(4)
  end
end
```

*Ensure test doubles stay in sync with the API!*

---
# Spies

![inline](http://the52weeks.com/wp-content/uploads/2010/07/thumbnail.jpg)

From [RSpec documentation](https://relishapp.com/rspec/rspec-mocks/docs/basics/spies):

> Message expectations put an example's expectation at the start, before you've invoked the code-under-test. Many developers prefer using an act-arrange-assert (or given-when-then) pattern for structuring tests. Spies are an alternate type of test double that support this pattern by allowing you to expect that a message has been received after the fact, using `have_received`.

> You can use any test double (or partial double) as a spy, but the double must be setup to spy on the messages you care about. Spies automatically spy on all messages, or you can allow a message to spy on it.


```ruby
describe "have_received" do
  it "passes when the message has been received" do
    invitation = spy("invitation")

    invitation.deliver

    expect(invitation).to have_received(:deliver)
  end
end
```

---
# Null object doubles

Test doubles are strict by default, raising errors when they receive messages that have not been allowed or expected.


You can chain `as_null_object` off of double in order to make the double "loose".


For any message that has not explicitly allowed or expected, the double will return itself. It acts as a black hole null object, allowing arbitrarily deep method chains.


```ruby
describe "as_null_object" do
  it "returns itself" do
    d = double("Some Collaborator").as_null_object

    expect(d.foo.bar.bazz).to be(d)
  end
end
```

---
# Testing collaborators summary

Test doubles that we have are:

- **Fake**: an alternative implementation to stand in for something you depend on
  (think fake server when testing APIs)
- **Stub**: replies to certain messages with responses that help us write tests
- **Mock**: ensures certain messages are received
  (and explodes upon receiving any unexpected messages)
- **Spy**: stealthily records all interactions,
  allowing us to make assertions about them later