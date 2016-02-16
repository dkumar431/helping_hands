class AgentsController < ApplicationController
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
      redirect_to  my_profile_agent_path
    else
      @title = "Edit User"
      render 'my_profile'
    end
  end

  def add_agent
    @user = User.new
  end

  def create_agent

    manager = User.where(:id => params[:id]).first.manager
    new_agent = User.new(agent_params)
    #new_agent[:status] = :I
    binding.pry

    if new_agent.valid?
      manager.agents << new_agent
      ExampleMailer.sample_email(manager,new_agent).deliver
      flash[:success] = "Agent added successfully , approval request sent to #{manager.name}"
      redirect_to add_agent_agent_path
    else
      @user = new_agent
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
    p = params.require(:user).permit(:name, :email, :password, :password_confirmation,:phone,:address)
    p[:status] = :I
    p
  end

end