class ScriptsController < ApplicationController

  def index
    @scripts = Script.where(user: current_user)
  end

  def show
    @script = Script.find(params[:id])
  end

end
