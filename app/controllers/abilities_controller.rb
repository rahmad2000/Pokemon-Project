class AbilitiesController < ApplicationController
  def index
    @abilities = Ability.all.page(params[:page])
  end

  def show
    @ability = Ability.find(params[:id])
  end
end
