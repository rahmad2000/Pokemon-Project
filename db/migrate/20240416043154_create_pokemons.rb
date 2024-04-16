class CreatePokemons < ActiveRecord::Migration[7.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.integer :height
      t.integer :weight
      t.string :color
      t.string :evolves_from
      t.string :generation
      t.string :url

      t.timestamps
    end
  end
end
