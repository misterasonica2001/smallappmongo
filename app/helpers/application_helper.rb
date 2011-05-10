module ApplicationHelper

def logo
	image_tag("logo.png", :alt => "Twister", :class => "round")
end

#Return a title on a per-page basis
def title
	base_title = "Twister - spune ce gândești"
	if @title.nil?
		base_title
	else
		"#{base_title} | #{@title}"
	end
end	


end