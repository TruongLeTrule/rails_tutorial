class User < ApplicationRecord
  SIGN_UP_REQUIRE_ATTRIBUTES = %i(name email password
password_confirmation).freeze

  has_secure_password

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
            length: {minimum: Rails.application.config.min_password_length}

  # Callbacks
  before_save{self.email = email.downcase}
end
