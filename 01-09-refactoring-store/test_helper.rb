require "minitest/autorun"
require "minitest/pride"

require "byebug"

require "minitest/reporters"
Minitest::Reporters.use! #Minitest::Reporters::SpecReporter.new

class Minitest::Spec
  class << self
    alias context describe
  end
end
