require 'spec_helper'

describe Robots::Place do
  subject { described_class.call(x, y, facing) }

  shared_context 'when successful cases' do |x, y, facing|
    let(:x) { x }
    let(:y) { y }
    let(:facing) { facing }

    after { Robot.current = nil }

    it 'sets current Robot' do
      subject
      expect(Robot.current).to be_a(Robot)
    end
  end

  shared_context 'when failed cases' do |x, y, facing|
    let(:x) { x }
    let(:y) { y }
    let(:facing) { facing }

    it 'sets current Robot' do
      subject
      expect(Robot.current).to be_nil
    end
  end

  it_behaves_like 'when successful cases', 1, 1, :west
  it_behaves_like 'when failed cases', 1, 1, nil
  it_behaves_like 'when failed cases', nil, nil, :west
end
