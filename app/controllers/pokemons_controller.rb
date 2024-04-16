class PokemonsController < ApplicationController
  before_action :authenticate_user!, only: [:index, :show]

  def index
    @search_performed = params[:search].present?
    base_query = Pokemon.joins(:types, :abilities)
                        .where.not(types: { id: nil }, abilities: { id: nil })
                        .where.not(url: [nil, ''])
                        .distinct

    # Apply name search if provided
    if @search_performed
      base_query = base_query.where('pokemons.name LIKE ?', "%#{params[:search]}%")
    end

    # Apply type filter if provided
    if params[:type_id].present?
      base_query = base_query.joins(:types).where(types: { id: params[:type_id] })
    end

    @pokemons = base_query.page(params[:page])

    # Check if the results are empty after applying search and/or filter
    @no_results = @pokemons.empty? && @search_performed
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :height, :weight, :evolves_from, :url, :generation, :type_id)
  end
end
