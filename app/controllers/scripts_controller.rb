# frozen_string_literal: true

# app/controllers/scripts_controller.rb
class ScriptsController < ApplicationController
  before_action :set_script, only: %i[show update]
  skip_before_action :verify_authenticity_token

  def index
    @scripts = Script.where(user: current_user)
  end

  def show
    @pexels_videos = pexels(@script.topic)
  end

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
    @pexels_videos = pexels(@script.topic)
    if script_params['script_body']
      @script.update(script_body: script_params['script_body'])

      respond_to do |format|
        format.html { redirect_to scripts_path }
        format.text { render :show, locals: {script: @script}, formats: [:html] }
      end
    end
    if @script.update(script_params)
      # @script.regenerate_script unless script_params[:script_body].present?
      GetAiResponseJob.perform(@script) unless script_params[:script_body].present?
      render :show
      flash[:notice] = 'Script is being regenerated'
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

  def pexels(topic)
    Pexels::Client.new.videos.search(topic,
                                     page: 1, per_page: 6, size: :medium, orientation: :landscape)
  end
end
