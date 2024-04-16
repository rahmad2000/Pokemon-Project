class Ability < ApplicationRecord
  has_many :abilities_pokemons
  has_many :pokemons, through: :abilities_pokemons

  # Validations
  validates :name, presence: true
  validates :description, presence: true
end
