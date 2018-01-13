module ApplicationHelper
  def current_user
    session[:current_user]
  end

  def signed_in?
    current_user.present?
  end
  
  def display_flash_errors(errors)
    'The following errors occurred:'.html_safe +
      content_tag(:ul) do
        errors.full_messages.map do |message|
          content_tag(:li, message.html_safe)
        end.join("\n").html_safe
      end
  end
end
