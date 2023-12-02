"".present?
"hello".present?
[].present?
[1, 2, 3].present?
{}.present?
{ a: 1, b: 2 }.present?


"".blank?
"hello".blank?
[].blank?
[1, 2, 3].blank?
{}.blank?
{ a: 1, b: 2 }.blank?

# Presence
def keywords(words)
  words.presence || Topic.pluck(:name).join(", ")
end

# Equivalent method without using presence
def keywords(words)
  if words.present?
    words
  else
    Topic.all.pluck(:name).join(", ")
  end
end

# Try
def status
  statuses_by_id[@trail.id].try(:first) || Unstarted.new
end

# Violates "ask, don't tell"
book.try(:name).try(:titleize)

# String methods
"snake_case_string".camelize
"camelCaseString".underscore
"a_long_variable_name".humanize
"a string for a url".parameterize
"a lower case string".titleize
"post".pluralize
"posts".singularize
" \n  weird\n\r \t whitespace \n".squish

# Array methods
fruits = ["apples", "oranges", "bananas"]
fruits.to_sentence.capitalize

# The `in?` method is the `include?` method
# with caller and receiver flipped
"apples".in? fruits
fruits.include? "apples"

# Forty two
Post.first
Post.second
Post.third
Post.forth
Post.fifth
Post.forty_two

# Dates and times methods
Date.today
Date.today.next_month
Date.today + 3.days
Date.today.beginning_of_week
Date.today.next_week(:friday)
Date.today.wednesday?
Date.today.all_week
3.days.ago

# Activity

# 1. Find the source code for `"string".pluralize`
#   Start with `bundle open activesupport`
#
# 2. What do the following methods do?
#   - `#deep_dup`
#   - `#with_options`
#   - `#squish`
#   - `#truncate`
#   - `#inquiry`
#   - `#pluck`
#   - `#multiple_of?`
#   - `#ordinalize`
#   - `#slice`
#   - `#advance`
#
# 3. What are the available options to pass in to `#truncate` and `#to_sentence`
#
# 4. When would be a good time to use `#except` or `#extract!`
#
# 5. What is `HashWithIndifferentAccess`?
