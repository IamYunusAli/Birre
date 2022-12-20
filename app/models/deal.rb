class Deal < ApplicationRecord
  belongs_to :author, class_name: 'User'
  has_and_belongs_to_many :categories
  validates :name, presence: true, length: { minimum: 3 }
  validates :amount, numericality: { greater_than: 0 }
  validates :categories, presence: true
end
