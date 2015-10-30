module ContactsHelper
  def view_errors(errors)
    html = ''
    if errors.is_a? ActiveModel::Errors
      errors.each do |_, msg|
        html << content_tag(:p, "#{msg}")
      end
    else
      Array.wrap(errors).each do |error|
        html << content_tag(:p, error)
      end
    end
    html.html_safe
  end

  def messages(messages)
    html = ''
    messages.each do |name, msg|
      next if !msg.is_a?(String) && msg.blank? && name.blank?
      html << content_tag(:div, msg, id: "flash_#{name}")
    end
    html.html_safe
  end
end
