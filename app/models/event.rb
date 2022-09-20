class Event < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, source: :user
  has_many :pictures, dependent: :destroy
  
  validates :title, 
    presence: true,
    length: { maximum: 100 }

  validates :address, presence: true

  validates :datetime, presence: true

  validate :not_many_photos

  private

  def not_many_photos
    if pictures.count > 5
      errors.add(:photos, message: I18n.t("validations.events.many_photos"))
    end
  end
end
