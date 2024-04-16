class PokemonsController < ApplicationController
  def index
    base_query = Pokemon.joins(:types, :abilities)
                        .where.not(types: { id: nil }, abilities: { id: nil })  # Ensure Pokemon has types and abilities
                        .where.not(url: [nil, ''])  # Ensure image url is present
                        .distinct

    if params[:search].present?
      @pokemons = base_query.where('name LIKE ?', "%#{params[:search]}%")
    else
      @pokemons = base_query
    end

    @pokemons = @pokemons.page(params[:page])  # Apply pagination if necessary
    @pokemons = @pokemons.presence || []  # Ensures @pokemons is always an array
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :height, :weight, :evolves_from, :url, :generation)
  end
end
