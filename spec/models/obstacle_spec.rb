require 'spec_helper'

describe Obstacle do
  subject { described_class.new(point) }

  let(:point) { Point.new(1, 1) }

  it 'sets point' do
    expect(subject.point).to eq(point)
  end
end
