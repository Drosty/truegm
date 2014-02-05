module ApplicationHelper
  def is_admin_page?
    controller.class.name.split("::").first=="Admin"
  end
end
