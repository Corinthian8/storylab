class BlueprintsController < ApplicationController
  before_action :set_blueprint, only: [:show]

  def index
    @blueprints = Blueprint.all
  end

  def show; end

  private

  # def blueprint_params
  #   params.require(:blueprint).permit(:name, :description)
  # end

  def set_blueprint
    @blueprint = Blueprint.find(params[:id])
  end
end
