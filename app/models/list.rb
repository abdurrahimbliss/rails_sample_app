class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_memberships, dependent: :destroy
  has_many :members, through: :list_memberships, source: :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, length: { maximum: 100 }
end
