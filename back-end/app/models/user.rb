class User < ApplicationRecord
  has_many :ad
  has_many :comment
  has_many :token
  validates_associated :ad
  validates_associated :comment
  validates_associated :token

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/, message: 'invalid email format' }
  validates :password, presence: true
  validates :phone_number, presence: true, uniqueness: true, length: { is: 10 }
  validates :dob, presence: true
end
