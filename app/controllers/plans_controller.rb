class PlansController < ApplicationController
  before_action :set_plan, only: %i[show create update]

  def show
    if @plan.content.blank?
      response = ChatgptService.call("Give me only step by step itinerary to film the youtube video based on following script:
        #{@plan.script.script_body}
        Just give an itinerary without a prefacing paragraph and postscript and Note: ")
      @plan.update(content: response)
      render :show
    else
      respond_to do |format|
        format.html
        format.text { render :show, locals: { plan: @plan }, formats: [:html] }
      end
    end
  end

  def create
  end

  def update
  end

  private

  def plan_params
    params.require(:plan).permit(:content)
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end

end
