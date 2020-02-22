require 'spec_helper'

describe Robots::Report do
  subject { described_class.call(robot) }

  let(:robot) { Robot.new(point, facing) }

  shared_context 'when successful cases' do |x, y, facing, result|
    let(:point) { Point.new(x, y) }
    let(:facing) { facing }

    it 'returns result' do
      expect(subject).to eq(result)
    end
  end

  it_behaves_like 'when successful cases', 0, 0, :north, '0,0,NORTH'
  it_behaves_like 'when successful cases', 0, 1, :east, '0,1,EAST'
  it_behaves_like 'when successful cases', 1, 0, :south, '1,0,SOUTH'
  it_behaves_like 'when successful cases', 1, 1, :west, '1,1,WEST'
end
