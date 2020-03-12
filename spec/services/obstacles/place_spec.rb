require 'spec_helper'

describe Obstacles::Place do
  subject { described_class.call(x, y) }

  let(:x) { 1 }
  let(:y) { 1 }

  it 'returns Obstacle' do
    expect(subject).to be_a(Obstacle)
  end

  it 'places Obstacle' do
    expect { subject }.to change { Obstacle.list.size }
  end
end
