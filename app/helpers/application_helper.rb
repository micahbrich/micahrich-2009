# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def newline_to_p(item)
      item.gsub(/\n/, '</p><p>')
  end
  
  def newline_and_textilize(item)
    textilize(newline_to_p(item))
  end
end
