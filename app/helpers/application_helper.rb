module ApplicationHelper

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type)} alert-dismissable fade in") do
              concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
              concat message
            end)
    end
    nil
  end

  def bootstrap_class_for(flash_type)
    case flash_type
    when "success"
      "alert-success"   # Green
    when "error"
      "alert-danger"    # Red
    when "alert"
      "alert-warning"   # Yellow
    when "notice"
      "alert-info"      # Blue
    else
      flash_type.to_s
    end
  end

  def link_to_suspend_or_reactivate_button(home)
    if !home.suspended?
      link_to "Suspend", admin_suspend_home_path(home), method: :patch
    else
      link_to "Reactivate", admin_reactivate_home_path(home), method: :patch
    end
  end

  def determine_active_photo(photo, photos)
    if photo == photos.first
      "active"
    else
      "inactive"
    end
  end

end
