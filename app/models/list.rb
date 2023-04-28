class List < ApplicationRecord
  belongs_to :user

  scope :latest, -> {order(day: :desc)}
  scope :old, -> {order(day: :asc)}
  scope :point_count, -> {order(point: :desc)}

  validates :title, presence: true
  validates :body, presence: true
end
