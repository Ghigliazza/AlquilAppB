class Report < ApplicationRecord
    belongs_to :user
    belongs_to :car
    has_one_attached :image
end
