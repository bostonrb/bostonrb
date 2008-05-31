class Array
  
  def halve
    center = self.size / 2 
    center = (center - 1) unless (center == 1)
    return self[0..center], self[center+1..self.size] 
  end
  
end