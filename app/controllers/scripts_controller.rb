class ScriptsController < ApplicationController


  def show
    @script = Script.find(params[:id])
  end

end
