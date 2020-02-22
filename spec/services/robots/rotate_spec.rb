require 'spec_helper'

describe Robots::Rotate do
  subject { described_class.call(robot, direction) }

  let(:robot) { Robot.new(Point.new(0, 0), facing) }

  shared_context 'when successful cases' do |from_facing, direction, to_facing|
    let(:direction) { direction }
    let(:facing) { from_facing }

    context "with direction = #{direction}" do
      it "changes facing from #{from_facing} to #{to_facing}" do
        expect { subject }.to change(robot, :facing).from(facing).to(to_facing)
      end
    end
  end

  shared_context 'when failed cases' do |direction|
    let(:direction) { direction }
    let(:facing) { :north }

    context "with direction = #{direction}" do
      it 'does not change facing' do
        expect { subject }.not_to change(robot, :facing)
      end
    end
  end

  it_behaves_like 'when successful cases', :north, :left, :west
  it_behaves_like 'when successful cases', :north, :right, :east
  it_behaves_like 'when successful cases', :east, :left, :north
  it_behaves_like 'when successful cases', :east, :right, :south
  it_behaves_like 'when successful cases', :south, :left, :east
  it_behaves_like 'when successful cases', :south, :right, :west
  it_behaves_like 'when successful cases', :west, :left, :south
  it_behaves_like 'when successful cases', :west, :right, :north
  it_behaves_like 'when failed cases', nil
  it_behaves_like 'when failed cases', :foobar
end
