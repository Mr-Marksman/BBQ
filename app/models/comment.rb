class Comment < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :event, presence: true
  
  validates :user_name, presence: true, unless: -> { user.present? }
  
  validates :body, 
    presence: true,
    length: { maximum: 250 }

  def user_name 
    if user.present?
      user.name
    else
      super
    end
  end
end
