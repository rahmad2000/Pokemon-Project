class PokemonsController < ApplicationController
  def index
    @search_performed = params[:search].present?
    base_query = Pokemon.joins(:types, :abilities)
                        .where.not(types: { id: nil }, abilities: { id: nil })
                        .where.not(url: [nil, ''])
                        .distinct

    if @search_performed
      base_query = base_query.where('pokemons.name LIKE ?', "%#{params[:search]}%")
    end

    @pokemons = base_query.page(params[:page])

    # Using @pokemons.empty? will check if the query returned results
    @no_results = @pokemons.empty? && @search_performed
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :height, :weight, :evolves_from, :url, :generation)
  end
end
