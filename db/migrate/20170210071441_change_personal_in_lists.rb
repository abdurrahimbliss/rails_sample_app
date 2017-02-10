class ChangePersonalInLists < ActiveRecord::Migration
  def change
    change_column :lists, :personal, :boolean, default: false
  end
end
