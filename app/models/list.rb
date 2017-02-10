class List < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, length: { maximum: 100 }
end
