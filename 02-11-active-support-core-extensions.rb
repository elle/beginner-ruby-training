# Active Support Core Extensions
# http://guides.rubyonrails.org/active_support_core_extensions.html

# You can refer to the email column as "login".
# This can be meaningful for authentication code.
alias_attribute :login, :email

1.in?([1,2])        # => true
"lo".in?("hello")   # => true
25.in?(30..50)      # => false
1.in?(1)            # => ArgumentError

"Hello World".remove(/Hello /) #=> "World"

" \n  foo\n\r \t bar \n".squish # => "foo bar"

"production".inquiry.production? # => true
"active".inquiry.inactive?       # => false

"foo".starts_with?("f") # => true
"foo".ends_with?("o")   # => true

5551234.to_s(:phone) #  => 555-1234
12345678.to_s(:delimited) # => 12,345,678
111.2345.to_s(:rounded, precision: 2) # => 111.23
1234.to_s(:human_size) # => 1.21 KB
1234.to_s(:human) # => "1.23 Thousand"

2.multiple_of?(1) # => true
1.multiple_of?(2) # => false

[1, 2, 3].sum # => 6
(1..100).sum  # => 5050
[].sum    # => 0
[].sum(1) # => 1
(1..5).sum {|n| n * 2 } # => 30
[2, 4, 6, 8, 10].sum    # => 30

if pages.many? # shorthand for collection.size > 1
end

%w(a b c d).prepend('e')  # => %w(e a b c d)
[].prepend(10)            # => [10]
%w(a b c d).append('e')  # => %w(a b c d e)
[].append([1,2])         # => [[1,2]]

User.exists?(email: params[:email])

%w(Earth Wind Fire).to_sentence

{a: 1, b: 1}.merge(a: 0, c: 2) # => {:a=>0, :b=>1, :c=>2}

# reverse_merge: In case of collision the key in the hash of the argument wins in merge.
# You can support option hashes with default values in a compact way.

{a: {b: 1}}.deep_merge(a: {c: 2}) # => {:a=>{:b=>1, :c=>2}}

{a: 1, b: 2}.except(:a) # => {:b=>2}

{a: 1, b: 2, c: 3}.slice(:a, :c) # => {:c=>3, :a=>1}
{a: 1, b: 2, c: 3}.slice(:b, :X) # => {:b=>2} # non-existing keys are ignored

{a: 1, b: 2, c: nil}.compact # => {a: 1, b: 2}

(1..10).include?(3..7)  # => true
(1..10).include?(0..7)  # => false
(1..10).include?(3..11) # => false
(1...9).include?(3..9)  # => false
 
(1..10) === (3..7)  # => true
(1..10) === (0..7)  # => false
(1..10) === (3..11) # => false
(1...9) === (3..9)  # => false

(1..10).overlaps?(7..11)  # => true
(1..10).overlaps?(0..7)   # => true
(1..10).overlaps?(11..27) # => false

d = Date.new(2010, 5, 8) # => Sat, 08 May 2010
d.prev_year              # => Fri, 08 May 2009
d.next_year              # => Sun, 08 May 2011

d = Date.new(2010, 5, 8) # => Sat, 08 May 2010
d.prev_month             # => Thu, 08 Apr 2010
d.next_month             # => Tue, 08 Jun 2010
# prev_month is aliased to last_month

Time.local(2000, 7, 31).prev_quarter  # => Sun, 30 Apr 2000
Time.local(2000, 5, 31).prev_quarter  # => Tue, 29 Feb 2000
Time.local(2000, 10, 31).prev_quarter # => Mon, 30 Oct 2000
Time.local(2000, 11, 31).next_quarter # => Wed, 28 Feb 2001

d = Date.new(2010, 5, 9) # => Sun, 09 May 2010
d.next_week              # => Mon, 10 May 2010
d.next_week(:saturday)   # => Sat, 15 May 2010

d.prev_week              # => Mon, 26 Apr 2010
d.prev_week(:saturday)   # => Sat, 01 May 2010
d.prev_week(:friday)     # => Fri, 30 Apr 2010
# prev_week is aliased to last_week

d = Date.new(2010, 5, 9) # => Sun, 09 May 2010
d.beginning_of_year      # => Fri, 01 Jan 2010
d.end_of_year            # => Fri, 31 Dec 2010

date = Date.new(2010, 6, 6)
date.advance(years: 1, weeks: 2)  # => Mon, 20 Jun 2011
date.advance(months: 2, days: -2) # => Wed, 04 Aug 2010

Date.new(2010, 12, 23).change(year: 2011, month: 11)

date = Date.new(2010, 6, 7)
date.beginning_of_day # => Mon Jun 07 00:00:00 +0200 2010

date = Date.new(2010, 6, 7)
date.end_of_day # => Mon Jun 07 23:59:59 +0200 2010

now = DateTime.current
# => Tue, 08 Jun 2010 01:56:22 +0000
now.change(year: 2011, offset: Rational(-6, 24))
# => Wed, 08 Jun 2011 01:56:22 -0600

# Time calculations: http://guides.rubyonrails.org/active_support_core_extensions.html#calculations
logger = Logger.new("log/development.log")
logger.around_info("before", "after") { |logger| logger.info("during") }
