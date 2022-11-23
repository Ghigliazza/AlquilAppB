class Report < ApplicationRecord
    belongs_to :user
    belongs_to :car
    has_one_attached :image

    #enum state: { dented: "El auto está abollado", scratched: "El auto está rayado", wontStart: "El auto no enciende" }

    enum state: [:visual, :illegal, :wontStart, :other]
end