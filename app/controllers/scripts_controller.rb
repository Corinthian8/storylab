# app/controllers/scripts_controller.rb
class ScriptsController < ApplicationController
  before_action :set_script, only: [:show]

  def index
    @scripts = Script.where(user: current_user)
  end

  def show; end

  def create
    @script = Script.new(script_params)
    @script.user = current_user
    @script.script_body = ChatgptService.call("Create a short script for a YouTube video about #{@script.topic}")
    # raise
    if @script.save
      redirect_to script_path(@script)
    else
      render 'blueprints/show'
    end
  end

  private

  def script_params
    params.require(:script).permit(:name, :topic, :tone, :duration, :blueprint_id)
  end

  def set_script
    @script = Script.find(params[:id])
  end
end
