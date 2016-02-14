class MembersController < ApplicationController
  before_filter :logged_in, :only => [:index]

  def index
  end

  def my_patients
    agent = User.where(id: params[:id]).first
    @patients = agent.get_patients
    @patient = Patient.new
  end

  def my_colleagues
    agent = User.where(id: params[:id]).first
    @colleagues = agent.manager.agents;

    @patients_by_agent = {}
    @colleagues.each do |colg|
      @patients_by_agent[colg.id] = colg.patients
    end

    @colleague_names = {}
    @colleagues.each do |colg|
      @colleague_names[colg.id] = colg.name
    end
  end

  def all_agents
     @agents = User.where(:role_id => 2)
  end

  def patients_by_agent
    agent = User.where(:id => params[:id]).first
    @patients = agent.patients
  end

  def my_profile
    @user = User.where(:id => params[:id]).first

  end

  def update_agent
    @user = User.find(params[:id])
    if @user.update_attributes(agent_params)
      flash[:success] = "Profile Updated."
      redirect_to  my_profile_member_path
    else
      #binding.pry
      @title = "Edit User"
      #redirect_to  my_profile_member_path
      render 'my_profile'
    end
  end

  def add_agent
    @user = User.new
  end

  def create_agent

    parent_agent = User.where(:id => params[:id]).first
    child_agent = User.new(agent_params)


    child_agent.status = :I
    manager = parent_agent.manager
    manager_name = manager.name

    if child_agent.valid?
      c_agent = child_agent.save
      relationship = Relationship.new(agent_id: child_agent.id,manager_id:current_user.manager.id)
      relationship.save
      ExampleMailer.sample_email(manager,child_agent).deliver
      flash[:success] = "Agent added successfully , approval request sent to #{manager_name}"
      redirect_to add_agent_member_path
    else
      @user = child_agent
      render 'add_agent'
    end

  end


  private
  def logged_in
    if !user_signed_in?
      redirect_to new_user_session_path, :notice => "Please signin to access this page123."
    end
  end

  def agent_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation,:phone,:address)
  end

end
