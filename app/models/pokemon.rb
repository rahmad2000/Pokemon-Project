class Pokemon < ApplicationRecord
  has_many :pokemons_types
  has_many :types, through: :pokemons_types
  has_many :abilities_pokemons
  has_many :abilities, through: :abilities_pokemons

  # Validations
  validates :name, :height, :weight, :color, :generation, presence: true
  
end
