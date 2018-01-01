class AddSubscriptionLimitToSubscription < ActiveRecord::Migration
  def change
    add_column :subscriptions, :subscription_limit, :integer, 
      null: false, default: 100
  end
end
