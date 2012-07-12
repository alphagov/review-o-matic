module BrowserHelper
  def button_attributes_for(review, result)
    atts = { :name => result }
    if review.present? and review.result == result
      atts.merge!({ :class => "selected" })
    end
    atts
  end

  def format_title(title)
    title.sub(/ : Directgov.*/, '')
  end
end
