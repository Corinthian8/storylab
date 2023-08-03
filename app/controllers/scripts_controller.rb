class ScriptsController < ApplicationController
  before_action :set_script, only: [:show]

  def index
    @scripts = Script.all.where(user: current_user)
  end

  def show; end

  private

  def set_script
    @script = Script.find(params[:id])
  end
end
