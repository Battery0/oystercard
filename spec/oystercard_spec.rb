require 'oystercard'

describe Oystercard do
  before do
    @station = double
  end
  
  let(:journey){ { Start: @station, End: @station } }
  let(:journey_double) { double("i am a double", start_station: @station, finish_station: @station )}
  let(:journey_double_in_only) { double("i am a double", start_station: nil, finish_station: @station )}
  let(:journey_double_out_only) { double("i am a double", start_station: @station, finish_station: nil )}
  let(:partial_journey_in_only) { { Start: @station, End: nil } }
  let(:partial_journey_out_only) { { Start: nil, End: @station } }

  it 'responds to balance' do
    expect(subject).to respond_to(:balance)
  end

  it 'has a balance' do
    expect(subject.balance).to eq(0)
  end

  it 'checks it has no history of journeys' do
    expect(subject.journeys).to be_empty
  end

  it "responds to top_up" do
    expect(subject).to respond_to(:top_up).with(1).argument
  end

  it "adds money to the oystercard" do
    # expect(subject.top_up(5)).to eq(5)
    expect{subject.top_up(5)}.to change{subject.balance}.by 5
  end

  it "raises error when money exceeds £90 " do
    max_balance = Oystercard::MAX_AMOUNT
    subject.top_up(max_balance)
    expect {subject.top_up(1)}.to raise_error("Exceeds the limit #{max_balance}")
  end

 # it 'responds to deduct' do
 #   expect(subject).to respond_to(:deduct).with(1).argument
 # end

 # it "subtracts money from the oystercard" do
 #   expect{subject.deduct(5)}.to change{subject.balance}.by -5
 # end

  it 'responds to in_journey?' do
    expect(subject).to respond_to(:in_journey?)
  end

  it 'in_journey is false when not on a journey' do
    expect(subject.in_journey?).to eq(false)
  end

  it 'touch_in changes in_journey? to true' do
    subject.top_up(10)
    subject.touch_in(@station)
    expect(subject.in_journey?).to eq(true)
  end

  it "checks the state of the journey" do
    subject.top_up(10)
    subject.touch_in(@station)
    subject.touch_out(@station)
    expect(subject).not_to be_in_journey
  end

  it 'error raised with insufficient balance' do
    min_balance = Oystercard::MINIMUM_FARE
    expect {subject.touch_in(@station)}.to raise_error("Balance of 0 does not meet minimum fare of #{min_balance}")
  end
  
  it 'expects touch_out to update deducted balance' do
    expect{subject.touch_out(@station)}.to change{subject.balance}.by -6
  end
  
  it "checks that touch_out saves the journey" do
    subject.top_up(10)
    subject.touch_in(@station)
    subject.touch_out(@station)
    expect(subject.journeys).to include journey
  end

  it 'we expect to save a partial journey when failing to touch out' do
    subject.top_up(10)
    subject.touch_in(@station)
    subject.touch_in(@station)
    expect(subject.journeys).to include(partial_journey_in_only)
  end

  it 'we expect to save a partial journey when failling to touch in' do
    subject.top_up(10)
    subject.touch_out(@station)
    expect(subject.journeys).to include(partial_journey_out_only)
  end


  it 'fare method returns minimum fare for completed journey' do
    expect(subject.fare(journey_double)).to eq Oystercard::MINIMUM_FARE
  end

  it 'fare method returns minimum fare for completed journey' do
    expect(subject.fare(journey_double_in_only)).to eq Oystercard::PENAULTY_FARE
    expect(subject.fare(journey_double_out_only)).to eq Oystercard::PENAULTY_FARE
  end

end