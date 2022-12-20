class Category < ApplicationRecord
  has_one_attached :icon
  has_and_belongs_to_many :deals
  belongs_to :author, class_name: 'User'
  validates :name, presence: true, length: { minimum: 3 }
  validates :icon, presence: true
end
