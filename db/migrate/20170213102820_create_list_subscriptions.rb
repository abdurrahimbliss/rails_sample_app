class CreateListSubscriptions < ActiveRecord::Migration
  def change
    create_table :list_subscriptions do |t|
      t.integer :user_id
      t.integer :list_id

      t.timestamps
    end
  end
end
