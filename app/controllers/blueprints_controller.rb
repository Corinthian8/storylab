# app/controllers/blueprints_controller.rb
class BlueprintsController < ApplicationController
  before_action :set_blueprint, only: [:show]

  def index
    @blueprints = Blueprint.all
  end

  def show
    @script = Script.new
  end

  private

  # def blueprint_params
  #   params.require(:blueprint).permit(:name, :description)
  # end

  def set_blueprint
    @blueprint = Blueprint.find(params[:id])
  end
end
