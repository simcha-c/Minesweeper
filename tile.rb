class Tile

  attr_accessor :value, :revealed, :flagged

  def initialize(value = nil, revealed = false, flagged = false)
    @value = value
    @revealed = revealed
    @flagged = flagged
  end

  def to_s
    if @value.to_s == "0" && @revealed
      " "
    elsif @revealed
      @value.to_s
    else
      @flagged ? 'F' : '*'
    end
  end

  def toggle_flagged
    if self.flagged
      self.flagged = false
    else
      self.flagged = true
    end
  end

end
