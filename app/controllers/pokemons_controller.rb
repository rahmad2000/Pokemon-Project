class PokemonsController < ApplicationController
  def index
    @pokemons = Pokemon.search(params[:search]).page(params[:page])
  end

  def show
    @pokemon = Pokemon.find(params[:id])
  end

  private

  def pokemon_params
    params.require(:pokemon).permit(:name, :height, :weight, :evolves_from, :url, :generation)
  end
end
