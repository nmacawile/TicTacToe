module Enumerable	
    def has_exactly?(count)
    	if block_given?
    		matches=0
    		self.each do |item|
    			if yield(item)
    				matches += 1
    			end
    		end
    		return true if matches == count
    	else
    		return true
    	end
    	false
    end
end
