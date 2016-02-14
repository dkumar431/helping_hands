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

end
