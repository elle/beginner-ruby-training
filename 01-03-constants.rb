PUPPY = "Kelpie"

module Company
  PUPPY = "Border Collie"

  module Camp
    PUPPY = "Husky"

    class Team
      PUPPY = "Labrador"
    end

    class Member < Team
      PUPPY = "Jack Russell"

      def puppy
        PUPPY
      end
    end
  end
end
puts Company::Camp::Member.new.puppy

# Object.constants.grep(/PUPPY/)
# self
# self.class
# Object.superclass
#
# Member < BasicObject
# Object::PUPPY

# class Price < BasicObject
#   def calculate(rate)
#     case rate
#     when Float then (rate * 100).floor
#     when Integer then rate * 100
#     end
#   end
# end

# puts Price.new,calculate(98.7)
