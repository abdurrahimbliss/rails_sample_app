class ListMembership < ActiveRecord::Base
  belongs_to :list, class_name: "List"
  belongs_to :user, class_name: "User"
  validates :list_id, presence: true
  validates :user_id, presence: true
end
