require 'spec_helper'

describe Robots::FindPath do
  subject { described_class.call(robot, x, y) }

  let(:robot) { Robot.new(Point.new(1, 1), :north) }
  let(:x) { 2 }
  let(:y) { 2 }

  it 'returns list of coordinates' do
    expect(subject).to eq([[2, 1], [2, 2]])
  end

  shared_context 'with obstacles' do |obstacle_coord_list, path|
    before do
      obstacle_coord_list.each { |coord| Obstacles::Place.call(*coord) }
    end

    after { @@obstacle_list = [] }

    it 'returns list of coordinates' do
      expect(subject).to eq(path)
    end
  end

  it_behaves_like 'with obstacles', [[1, 0]], [[2, 1], [2, 2]]
  it_behaves_like 'with obstacles', [[2, 1]], [[1, 2], [2, 2]]
  it_behaves_like 'with obstacles', [[2, 1], [1, 2]], [[0, 1], [0, 2], [0, 3], [1, 3], [2, 3], [2, 2]]
  it_behaves_like 'with obstacles', [[2, 1], [1, 2], [0, 1]], [[1, 0], [2, 0], [3, 0], [4, 0], [5, 0], [5, 1], [4, 1], [3, 1], [3, 2], [2, 2]]
  it_behaves_like 'with obstacles', [[2, 1], [1, 2], [0, 1], [1, 0]], []
end
