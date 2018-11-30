class Micropost < ApplicationRecord
  belongs_to :user
  validates :context, presence: true, length: {maximum: 50}
end
