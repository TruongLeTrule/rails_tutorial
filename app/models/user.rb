class User < ApplicationRecord
  SIGN_UP_REQUIRE_ATTRIBUTES = %i(name email password
password_confirmation).freeze

  attr_accessor :remember_token

  # Validations
  validates :name,
            presence: true,
            length: {maximum: Rails.application.config.max_name_length}
  validates :email,
            presence: true,
            length: {maximum: Rails.application.config.max_email_length},
            format: {with: Rails.application.config.email_regex},
            uniqueness: {case_sensitive: false}
  validates :password,
            presence: true,
            length: {minimum: Rails.application.config.min_password_length},
            allow_nil: true

  has_secure_password

  # Callbacks
  before_save{email.downcase!}

  class << self
    def digest string
      cost = if ActiveModel::SecurePassword.min_cost
               BCrypt::Engine::MIN_COST
             else
               BCrypt::Engine.cost
             end
      BCrypt::Password.create string, cost:
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    self.remember_token = User.new_token
    update_attribute :remember_digest, User.digest(remember_token)
  end

  def forget
    update_attribute :remember_digest, nil
  end

  def authenticated? remember_token
    BCrypt::Password.new(remember_digest).is_password? remember_token
  end
end
