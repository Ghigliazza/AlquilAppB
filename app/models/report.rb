class Report < ApplicationRecord
  #ASSOCIATIONS
  belongs_to :user
  belongs_to :car
  has_one_attached :image

  #ENUMERATIVES
  #enum state: { dented: "El auto está abollado", scratched: "El auto está rayado", wontStart: "El auto no enciende" }

  enum state: [:visual, :illegal, :wontStart, :other]

  #METHODS
  def get_guilty
    return User.find(self.guilty)
  end
end