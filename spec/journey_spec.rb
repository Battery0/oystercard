require 'journey'

describe Journey do
  let(:station) { double('station', name: "Kings Cross", zone: 1)}
  #let(:card) { double('oystercard', current_journey: subject, touch_in: station, top_up: 10)} 

  it "saves the Start station at touch in" do
    subject.start_journey(station)
    expect(subject.start_station).to eq station
  end

  it "saves the End station at touch out" do
    subject.finish_journey(station)
    expect(subject.finish_station).to eq station
  end

end
