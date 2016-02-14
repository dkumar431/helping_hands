class DashboardsController < ApplicationController
before_filter :logged_in?, :only => [:index]

  def index
    if current_user.is?(:manager)
      render :manager_dashboard
    elsif current_user.is?(:agent)
      render :agent_dashboard
    else
      render :index
    end

  end

  private
  def logged_in?
    unless user_signed_in?
      redirect_to new_user_session_path, notice: "Please signin to access this page."
    end
  end

end