module ContactsHelper
  def view_errors(errors)
    html = ''
    if errors.is_a? ActiveModel::Errors
      errors.each do |field, msg|
        html << content_tag(:p, "#{field}: #{msg}")
      end
    else
      Array.wrap(errors).each do |error|
        html << content_tag(:p, error)
      end
    end
    html.html_safe
  end
end
