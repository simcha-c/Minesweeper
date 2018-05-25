class Tile

  attr_accessor :value, :revealed, :flagged

  def initialize(value = nil, revealed = false, flagged = false)
    @value = value
    @revealed = revealed
    @flagged = flagged
  end

  def to_s
    if @revealed
      @value.to_s
    elsif @value == "B"
      "B"
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
