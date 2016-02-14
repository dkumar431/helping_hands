class Users::SessionsController < Devise::SessionsController
  #respond_to :html, :json

  def new
    super
  end

  def create
    self.resource = verify_user? #warden.authenticate(auth_options)
    # self.resource = authenticate_login?

    sign_in(resource_name, resource) if resource.present?
    yield resource if block_given?

    # respond_to do |format|
    #   format.js
    # end

  end

  private
   def authenticate_login?
     user = User.new(email: params[:user][:email], password: params[:user][:password], sign_in: true)
     user.valid?
     user

     # return User.authenticate(params[:user][:email], params[:user][:password])
   end

  def verify_user?

    user = User.find_by_email(params[:user][:email])
    if user.nil?
      @error_message = 'User not found' and return nil
    elsif !user.valid_password?(params[:user][:password])
      @error_message = 'Invalid Password entered.' and return nil
    else
      user
    end
  end
end