class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user

  has_many_attached :photos
  
  validates :title, 
    presence: true,
    length: { maximum: 100 }

  validates :address, presence: true

  validates :datetime, presence: true
end
