class ManagersController < ApplicationController

  def my_agents
      @agents = current_user.agents
      render 'managers/my_agents'
  end

  def filter_agent

    @agents = current_user.agents.where(status: params[:agent_status])
    respond_to do |format|
      format.js
    end
  end

  def approve_reject_agent

    agent = User.where(:id => params[:id]).first
    if agent.status
      agent.update_attribute(:status,  false)
      flash[:success] = "#{agent.name} approved successfully."
    else
      agent.update_attribute(:status,  true)
      flash[:success] = "#{agent.name} rejected."
    end
    redirect_to my_agents_managers_path
  end

end