require 'spec_helper'

describe Robots::PathCommands do
  subject { described_class.call(robot, x, y) }

  let(:robot) { Robot.new(Point.new(1, 1), :north) }
  let(:x) { 2 }
  let(:y) { 2 }

  shared_context 'with obstacles' do |obstacle_coord_list, path|
    before do
      obstacle_coord_list.each { |coord| Obstacles::Place.call(*coord) }
    end

    after { @@obstacle_list = [] }

    it 'returns list of commands' do
      expect(subject).to eq(path)
    end
  end

  it_behaves_like 'with obstacles', [[1, 0]], %i[right move left move]
  it_behaves_like 'with obstacles', [[2, 1]], %i[move right move]
  it_behaves_like 'with obstacles', [[2, 1], [1, 2]], %i[left move right move move right move move right move]
  it_behaves_like 'with obstacles', [[2, 1], [1, 2], [0, 1], [1, 0]], []
end
