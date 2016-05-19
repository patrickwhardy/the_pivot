module FlashHelper
  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(
        :div,
        message,
        class: "alert #{bootstrap_class_for(msg_type)} alert-dismissable fade in") do
          concat content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
          concat message
        end
      )
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
end
