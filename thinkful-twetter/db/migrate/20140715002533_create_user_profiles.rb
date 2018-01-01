class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.string :gravatar_hash, limit: 32
      t.integer :user_id

      t.timestamps
    end
  end
end
