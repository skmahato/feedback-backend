class Review < ApplicationRecord
    validates :title, :comment, :rating, presence: true
end
