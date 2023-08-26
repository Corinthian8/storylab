# frozen_string_literal: true

require_relative '../jobs/get_ai_response_job'
# app/controllers/scripts_controller.rb
class ScriptsController < ApplicationController
  before_action :set_script, only: %i[show update]
  skip_before_action :verify_authenticity_token

  def index
    @scripts = Script.where(user: current_user)
  end

  def show
    @pexels_videos = pexels(@script.topic)
    @script.update(location: Location.create) if @script.location.nil?
    if @script.script_body.blank?
      GetAiResponseJob.perform_later(@script)
      flash[:notice] = 'Script is being generated'
      render :show
    else
      respond_to do |format|
        format.html
        format.text { render :show, locals: { script: @script }, formats: [:html] }
      end
    end
  end

  def create
    @script = Script.new(script_params)
    @script.user = current_user
    @script.script_body = ''
    if @script.save
      # Location.create(script_id: @script.id)
      redirect_to script_path(@script)
    else
      render 'blueprints/show'
    end
  end

  def update
    # raise
    @pexels_videos = pexels(@script.topic)

    # Check for script regeneration
    if script_params[:script_body].blank?
      GetAiResponseJob.perform_later(@script)
      flash[:notice] = 'Script is being regenerated'
      render :show
      return
    end

    # Update script details
    if @script.update(script_params)
      respond_to do |format|
        format.html { redirect_to scripts_path }
        format.text { render :show, locals: { script: @script }, formats: [:html] }
      end
    else
      flash[:alert] = 'Script was not successfully updated'
      render :show
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
