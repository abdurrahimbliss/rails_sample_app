class List < ActiveRecord::Base
  belongs_to :user
  has_many :list_memberships, dependent: :destroy
  has_many :members, through: :list_memberships, source: :user
  validates :user_id, presence: true
  validates :name, presence: true
  validates :description, length: { maximum: 100 }

  def feed
    Micropost.from_list(self)
  end

  def is_member?(user)
    list_memberships.find_by(user_id: user.id)
  end

  def add_member!(user)
    list_memberships.create!(user_id: user.id)
  end

  def remove_member!(user)
    list_memberships.find_by(user_id: user.id).destroy!
  end
end
