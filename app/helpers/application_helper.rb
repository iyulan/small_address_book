module ApplicationHelper
  def messages(messages)
    html = ''
    messages.each do |name, msg|
      next if !msg.is_a?(String) && msg.blank? && name.blank?
      html << content_tag(:div, msg, id: "flash_#{name}")
    end
    html.html_safe
  end
end
