module ApplicationHelper
  def get_link_image(controller_names, action_names = nil)
    if action_names.blank?
      controller_names == (controller.controller_name) ? 'active' : ''
    else
      (controller_names == (controller.controller_name) and  action_names == (controller.action_name)) ? 'active' : ''
    end
  end
end
