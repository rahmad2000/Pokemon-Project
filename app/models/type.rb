class Type < ApplicationRecord
  has_many :pokemons_types
  has_many :pokemons, through: :pokemons_types

  # Validations
  validates :name, presence: true, uniqueness: { case_sensitive: false }
end
