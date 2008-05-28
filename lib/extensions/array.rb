class Array
  
  def first_half
    center = self.size / 2
    center = (center - 1) unless (center == 1)
    self[0..center]
  end
  
end