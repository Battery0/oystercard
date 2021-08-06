require 'journeylog'

describe Journeylog do
  let(:journey){ { Start: @station, End: @station } }
  let(:card) { double('oystercard') } 

  it 'can store journeys' do
    expect(subject.journeys).to eq []
  end

  it 'can store completed journeys' do
    subject.journeys << journey
    expect(subject.journeys).to include journey
  end
end
