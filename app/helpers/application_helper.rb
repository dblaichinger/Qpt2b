module ApplicationHelper

def title
    base_title = "TrashCanny"
	
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end


def controller?(*controller)
    controller.include?(params[:controller])
end

def action?(*action)
   action.include?(params[:action])
end