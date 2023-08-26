class LocationsController < ApplicationController
  before_action :set_location, only: %i[show create update]

  def show
    if @location.content.blank?
      response = ChatgptService.call("Give me only the list of 5 best locations to film the video based on following script:
        #{@location.script.script_body}
        Just give an enumerated list of locations, without a prefacing paragraph.")
      @location.update(content: response)
      render :show
    else
      respond_to do |format|
        format.html
        format.text { render :show, locals: { location: @location }, formats: [:html] }
      end
    end
  end

  def create
  end

  def update
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

end
