class User < ApplicationRecord
  has_secure_password

  has_many :ad
  has_many :comment
  validates_associated :ad
  validates_associated :comment

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true, length: { is: 10 }, numericality: { only_integer: true }
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 18, less_than_or_equal_to: 99 }
end
