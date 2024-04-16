class CreatePokemonsTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons_types do |t|
      t.references :pokemon, null: false, foreign_key: true
      t.references :type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
