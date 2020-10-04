class Review < ApplicationRecord
    validates :title, :comment, :rating, presence: true

    belongs_to :user
    belongs_to :dealership
end
