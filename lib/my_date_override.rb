module ActionView  
	module Helpers  
		module DateHelper  
  
			def distance_of_time_in_words(from_time, to_time = 0, include_seconds = false)  
				from_time = from_time.to_time if from_time.respond_to?(:to_time)  
				to_time = to_time.to_time if to_time.respond_to?(:to_time)  
				distance_in_minutes = (((to_time - from_time).abs)/60).round  
				distance_in_seconds = ((to_time - from_time).abs).round  
  
				case distance_in_minutes  
					when 0..1  
						return (distance_in_minutes == 0) ? 'mai puțin de un minut' : '1 minut' unless include_seconds  
					case distance_in_seconds  
						when 0..4   then 'mai puțin de 5 secunde'  
						when 5..9   then 'mai puțin de 10 secunde'  
						when 10..19 then 'mai puțin de 20 secunde'  
						when 20..59 then 'mai puțin de un minut'  
						else             '1 minut'  
					end  
  
					when 2..44           then "#{distance_in_minutes} minute"  
					when 45..89          then 'aproximativ o oră'  
					when 90..1439        then "aproximativ #{(distance_in_minutes.to_f / 60.0).round} ore"  
					when 1440..2879      then 'o zi'  
					when 2880..43199     then "#{(distance_in_minutes / 1440).round} zile"  
					when 43200..86399    then 'aproximativ o lună'  
					when 86400..525959   then "#{(distance_in_minutes / 43200).round} luni"  
					when 525960..1051919 then 'aproximativ un an'  
					else                      "mai mult de #{(distance_in_minutes / 525960).round} ani"  
				end  
			end  
		end	
	
end  