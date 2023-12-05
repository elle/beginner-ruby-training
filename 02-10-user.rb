class User < ActiveRecord
  include SubscriptionPolicy

  belongs_to :company_members
  belongs_to :company
  belongs_to :role
  has_many :surveys, through: :company
  has_many :posts
  has_many :answers, polymorphic: true

  # Include default devise modules.

  validates :email, presence: true, uniqueness: true

  # callbacks

  def self.active
    where(active: true)
  end

  def self.billable
    # ...
  end

  def update_login_details(new_email, new_password)
    update_attributes(email: new_email, password: new_password)
  end

  def full_name
    [first_name, last_name].join(" ")
  end

  before_create :create_stripe_subscription
  before_save :update_braintree_email

  def create_stripe_subscription
    customer = Stripe::Customer.create!(email: email)
    self.stripe_customer_id = customer.id
  end

  def update_stripe_email
    if persisted? and changed.include?("email")
      Stripe::Customer update!(
        stripe_customer_id,
        email: email,
      )
    end
  end

  def add_one_month_of_credit!
    # some logic
  end

  def confirm!
    token = nil
    confirmd_at = Time.zone.now
  end

  def recent_surveys
    surveys.limit(5).pluck(&:name).to_sentence
  end
end
