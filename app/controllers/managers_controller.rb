class ManagersController < ApplicationController

  def my_agents
      @agents = current_user.agents
      render 'managers/my_agents'
  end

  def filter_agent
    @agents = current_user.agents.where(status: params[:status])
    respond_to do |format|
      format.js
    end
  end

end