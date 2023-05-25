class UserLeague < ApplicationRecord
  belongs_to :owner, class_name: 'User'

  validates :name, presence: true
  validates :name, uniqueness: { scope: :owner }
end
