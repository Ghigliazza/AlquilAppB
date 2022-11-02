class Car < ApplicationRecord
    has_one :position
    has_many :rental
    has_many :report
    has_many :users, :through => :rental
end
