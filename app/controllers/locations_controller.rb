class LocationsController < ApplicationController
  before_action :set_script, only: %i[show]

  def show
    @location = @script.location
    if @location.nil?
      flash[:alert] = 'Location not found'
      redirect_to script_path(@script)
    else
      GetAiResponseJob.perform_later(@script)
      flash[:notice] = 'Location is suggested'
      render :show
    end

  end

  privates

  def script_params
    params.require(:script).permit(:name, :topic, :tone, :duration, :blueprint_id, :pexels_videos, :script_body)
  end

  def set_script
    @script = Script.find(params[:id])
  end

end
