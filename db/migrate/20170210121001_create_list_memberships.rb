class CreateListMemberships < ActiveRecord::Migration
  def change
    create_table :list_memberships do |t|
      t.integer :user_id
      t.integer :list_id

      t.timestamps
    end
  end
end
