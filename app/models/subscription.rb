class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  validates :user_name, presence: true
  validates :user_email, presence: true
  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }
  validates :user_email, uniqueness: {scope: :event_id},  unless: -> { user.present? } 
  validate :not_event_creator
  validate :user_not_registered, unless: -> { user.present? }

  def user_name 
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email 
    if user.present?
      user.email
    else
      super
    end
  end

  private

  def user_not_registered
    if User.find_by(email: user_email).present?
      errors.add(:user_email, message: I18n.t("validations.subscriptions.email_already_used"))
    end
  end

  def not_event_creator
    if user == event.user
      errors.add(:user_id, message: I18n.t("validations.subscriptions.self_subscription"))
    end
  end
end
