module ApplicationHelper
  def header(text)
    content_for(:header) { text.to_s }
  end

  def show_errors(object,field_name)

    if object.errors.any?
      if !object.errors.messages[field_name].blank?
        object.errors.messages[field_name].join(", ")
      end
    end

  end

  def header_link
    user_signed_in? ? root_path : new_user_session_path
  end

end
