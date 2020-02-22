require 'spec_helper'

describe Robots::Move do
  subject { described_class.call(robot) }

  let(:robot) { Robot.new(point, facing) }

  shared_context 'when successful cases' do |facing, from_coord, to_coord|
    let(:point) { Point.new(*from_coord) }

    context "with facing = #{facing}" do
      let(:facing) { facing }

      it 'returns point' do
        subject
        expect([robot.point.x, robot.point.y]).to eq(to_coord)
      end
    end
  end

  it_behaves_like 'when successful cases', :north, [1, 1], [1, 2]
  it_behaves_like 'when successful cases', :east, [1, 1], [2, 1]
  it_behaves_like 'when successful cases', :south, [1, 1], [1, 0]
  it_behaves_like 'when successful cases', :west, [1, 1], [0, 1]

  it_behaves_like 'when successful cases', :south, [0, 0], [0, 0]
  it_behaves_like 'when successful cases', :west, [0, 0], [0, 0]

  it_behaves_like 'when successful cases', :north, [5, 5], [5, 5]
  it_behaves_like 'when successful cases', :east, [5, 5], [5, 5]
end
