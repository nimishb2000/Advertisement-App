class Ad < ApplicationRecord
  belongs_to :user
  has_many :comment
  validates_associated :comment

  validates :title, presence: true
  validates :desc, presence: true
end
