require "./test_helper"
require "./store"

def customer
  @customer ||= Customer.new("Bruce")
end

def movie
  @movie ||= Movie.new("Lion King", Movie::REGULAR)
end

def rental
  @rental ||= Rental.new(movie, 1)
end

describe Movie do
  it "has a title" do
    assert_equal "Lion King", movie.title
  end

  it "has a price_code" do
    assert_equal Movie::REGULAR, movie.price_code
  end
end

describe Rental do
  it "has a movie" do
    assert_equal movie, rental.movie
  end

  it "has a days_rented" do
    assert_equal 1, rental.days_rented
  end
end

describe Customer do
  it "has a name" do
    assert_equal "Bruce", customer.name
  end

  it "defaults to empty rentals" do
    assert_equal [], customer.rentals
  end

  it "#add_rental" do
    customer.add_rental rental

    assert_equal [rental], customer.rentals
  end

  context "#statement" do
    context "1 rental day" do
      before do
        @rental = Rental.new(movie, 1)
      end

      it "displays statement for Movie::REGULAR" do
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t2\nAmount owed is 2\nYou earned 1 frequent renter points"

        assert_equal statement, customer.statement
      end

      it "displays statement for Movie::NEW_RELEASE" do
        movie.price_code = Movie::NEW_RELEASE
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t3\nAmount owed is 3\nYou earned 1 frequent renter points"

        assert_equal statement, customer.statement
      end

      it "displays statement for Movie::CHILDRENS" do
        movie.price_code = Movie::CHILDRENS
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t1.5\nAmount owed is 1.5\nYou earned 1 frequent renter points"

        assert_equal statement, customer.statement
      end
    end

    context "2 rental days" do
      before do
        @rental = Rental.new(movie, 2)
      end

      it "displays statement for Movie::NEW_RELEASE" do
        movie.price_code = Movie::NEW_RELEASE
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t6\nAmount owed is 6\nYou earned 2 frequent renter points"

        assert_equal statement, customer.statement
      end
    end

    context "3 rental days" do
      before do
        @rental = Rental.new(movie, 3)
      end

      it "displays statement for Movie::REGULAR" do
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t3.5\nAmount owed is 3.5\nYou earned 1 frequent renter points"

        assert_equal statement, customer.statement
      end

      it "displays statement for Movie::NEW_RELEASE" do
        movie.price_code = Movie::NEW_RELEASE
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t9\nAmount owed is 9\nYou earned 2 frequent renter points"

        assert_equal statement, customer.statement
      end
    end

    context "4 rental days" do
      before do
        @rental = Rental.new(movie, 4)
      end

      it "displays statement for Movie::REGULAR" do
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t5.0\nAmount owed is 5.0\nYou earned 1 frequent renter points"

        assert_equal statement, customer.statement
      end

      it "displays statement for Movie::NEW_RELEASE" do
        movie.price_code = Movie::NEW_RELEASE
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t12\nAmount owed is 12\nYou earned 2 frequent renter points"

        assert_equal statement, customer.statement
      end

      it "displays statement for Movie::CHILDRENS" do
        movie.price_code = Movie::CHILDRENS
        customer.add_rental @rental

        statement = "Rental Record for Bruce\n\tLion King\t3.0\nAmount owed is 3.0\nYou earned 1 frequent renter points"

        assert_equal statement, customer.statement
      end
    end


    context "Renting multiple movies" do
      it "includes all movies in the statement" do
        regular_rental =  Rental.new(Movie.new("The Warriors", Movie::REGULAR), 2)
        new_release_rental = Rental.new(Movie.new("Spectre", Movie::NEW_RELEASE), 3)
        childrens_rental = Rental.new(Movie.new("Despicable me 2", Movie::CHILDRENS), 4)

        customer = Customer.new("Sally")
        [regular_rental, new_release_rental, childrens_rental].each do |rental|
          customer.add_rental rental
        end

        statement = "Rental Record for Sally\n\tThe Warriors\t2\n\tSpectre\t9\n\tDespicable me 2\t3.0\nAmount owed is 14.0\nYou earned 4 frequent renter points"

        assert_equal statement, customer.statement
      end
    end
  end
end
