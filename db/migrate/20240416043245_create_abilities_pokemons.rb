class CreateAbilitiesPokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :abilities_pokemons do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :ability, null: false, foreign_key: true

      t.timestamps
    end
  end
end
