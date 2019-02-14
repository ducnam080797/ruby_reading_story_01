class User < ApplicationRecord
  has_many :stories
  has_many :liked, as: :likeable
  before_save :downcase_email, :downcase_account_name
  before_create :create_activation_digest
  attr_reader :remember_token, :activation_token
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  SIGNUP_PARAMS =
    %i(name account_name email password password_confirmation).freeze

  validates :name, presence: true, length: {maximum: Settings.max_length_name}
  validates :account_name, presence: true,
    length: {maximum: Settings.max_length_account_name},
    uniqueness: {case_sensitive: false}
  validates :email, presence: true,
    length: {maximum: Settings.max_length_email},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true,
    allow_nil: true,
    length: {minimum: Settings.min_length_password}
  has_secure_password

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost: cost
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    @remember_token = User.new_token
    update remember_digest: User.digest(@remember_token)
  end

  def authenticated? attribute, token
    digest = send "#{attribute}_digest"
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password? token
  end

  def activate
    update activated: true, activated_at: Time.zone.now
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  private

  def downcase_email
    email.downcase!
  end

  def downcase_account_name
    account_name.downcase!
  end

  def create_activation_digest
    @activation_token = User.new_token
    self.activation_digest = User.digest activation_token
  end
end
