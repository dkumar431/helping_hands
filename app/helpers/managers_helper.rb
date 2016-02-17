module ManagersHelper

  def show_status(status)
    status ? :Active : :Inactive
  end
end
