# frozen_string_literal: true

# app/controllers/scripts_controller.rb
class ScriptsController < ApplicationController
  before_action :set_script, only: [:show, :update]

  def index
    @scripts = Script.where(user: current_user)
  end

  def show; end

  def create
    @script = Script.new(script_params)
    @script.user = current_user
    @script.script_body = ChatgptService.call("
      Create a 'technical script' for a YouTube video about #{@script.topic}.
      The video should have a duration of around #{@script.duration || '8'} minutes.
      Its tone should be #{@script.tone || 'neutral'}.
      Create it by following this prompt: '#{@script.blueprint.prompt_template}'")
    if @script.save
      redirect_to script_path(@script)
    else
      render 'blueprints/show'
    end
  end

  def update
    if @script.update(script_params)
      @script.regenerate_script unless script_params[:script_body].present?
      render :show
      flash[:notice] = 'Script is being regenerated'
      # start job that calls
    else
      render :show
      flash[:alert] = 'Script was not successfully updated'
    end
  end

  private

  def script_params
    params.require(:script).permit(:name, :topic, :tone, :duration, :blueprint_id, :pexels_videos, :script_body)
  end

  def set_script
    @script = Script.find(params[:id])
  end
end
