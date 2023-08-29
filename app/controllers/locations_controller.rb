class LocationsController < ApplicationController
  before_action :set_location, only: %i[show create update]

  def show
    @pexels_videos = pexels(@location.script.topic)
    @plan = @location.script.plan
    if @location.content.blank?
      response = ChatgptService.call("Give me a list of 5 non-specific locations (for example: 'Park' instead 'Central Park, New York')  to film a video that is based on following script:
      #{@location.script.script_body}
      Just give an enumerated list of locations, without a prefacing paragraph, specify what should be the content to record.
      Write it as HTML, using only h4, h5, and p tags in HTML code but don't include the head tag.")
      @location.update(content: response)
      fill_plan(@plan)
      render :show
    else
      respond_to do |format|
        fill_plan(@plan)
        format.html
        format.text { render :show, locals: { location: @location, plan: @plan }, formats: [:html] }
      end
    end
  end

  def create; end

  # PATCH/PUT /scripts/:script_id/locations/:id
  def update; end

  private

  def location_params
    params.require(:location).permit(:content)
  end

  def set_location
    @location = Location.find(params[:id])
  end

  def pexels(topic)
    Pexels::Client.new.videos.search(topic,
                                    page: 1, per_page: 6, size: :medium, orientation: :landscape)
  end

  def fill_plan(plan)
    if plan.content.blank?
      response = ChatgptService.call("Give me a step by step work plan to record and edit the youtube video based on following script:
        '#{@plan.script.script_body}'
        The plan's goal is to make the video easier to record and edit.
        I want to record all of the scenes that take place in sequence, rather than recording in the order of the script.
        Just give the working plan without a prefacing paragraph. Write it as HTML, using only h4, h5, and p tags in HTML code but don't include the head tag.")
      plan.update(content: response)
      render :show
    # else
    #   respond_to do |format|
    #     format.html
    #     format.text { render :show, locals: { plan: plan }, formats: [:html] }
    #   end
    end
  end
end
