class ScriptsController < ApplicationController
  before_action :set_script, only: [:show]

  # def index
  #   @scripts = Script.all
  # end

  def show
    @blueprint = Blueprint.new
    @blueprints = @script.blueprints
  end

  private

  def set_script
    @script = Script.find(params[:id])
  end

end
