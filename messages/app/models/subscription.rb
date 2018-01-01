class Subscription < ActiveRecord::Base

  has_one :user, dependent: :destroy

  def can_send_message?
    subscription_limit_reached? ? false : true
  end

  def subscription_limit_reached?
    messages_sent_this_month >= subscription_limit
  end

  protected

  #
  # This should remain in the subscription model, as it is more related to subscription 
  # (business) rules than anything else; placing this in the messages model wouldn't 
  # make much sense, as the business rules for subscription limits could change, or, 
  # be unrelated to the amount of messages send in a given month.
  def messages_sent_this_month
    date = DateTime.now
    time = Date.new(date.year, date.month).to_time.utc
    user.sent_messages.where(created_at: time..time.end_of_month).count
  end
end
