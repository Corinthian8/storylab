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
    # @location = Location.new(location_params)
    # @location.script_id = params[:script_id]
    # # @script.user = current_user
    # @location.content = ''
    # if @location.content.save
    #   redirect_to location_path(params[:script_id], @location)
    # else
    #   render 'locations/show'
    # end
  end

  # PATCH/PUT /scripts/:script_id/locations/:id
  def update

  end

  private

  def location_params
    params.require(:location).permit(:content)
  end


  def set_location
    @location = Location.find(params[:id])
  end

end
