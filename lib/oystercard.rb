class Oystercard

  attr_reader :balance, :state

  MAX_AMOUNT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @state = false
  end 

  def top_up(add)
    raise "Exceeds the limit #{MAX_AMOUNT}" if (@balance + add ) > MAX_AMOUNT
    
    @balance += add
  end

  def in_journey?
    @state = false
  end

  def touch_in
    raise "Balance of #{@balance} does not meet minimum fare of #{MINIMUM_FARE}" if @balance < MINIMUM_FARE
    
    @state = true
  end

  def touch_out
    @state = false
    self.deduct(MINIMUM_FARE)
  end
  
  private
  
  def deduct(subtract)
    @balance -= subtract
  end

end