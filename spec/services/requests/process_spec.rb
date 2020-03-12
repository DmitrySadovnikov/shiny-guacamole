require 'spec_helper'

describe Requests::Process do
  subject { described_class.call(request) }

  let(:robot) { Robot.new(Point.new(1, 1), :north) }

  before { Robot.current = robot }

  context 'with PLACE request' do
    let(:request) { 'PLACE 0,0,NORTH' }

    it 'calls Robots::Place' do
      expect(Robots::Place).to receive(:call).with(0, 0, 'north')
      subject
    end
  end

  shared_context 'without current Robot' do
    let(:robot) { nil }

    it 'throws RobotNotPlacedError' do
      expect { subject }.to raise_error(RobotNotPlacedError)
    end
  end

  context 'with MOVE request' do
    let(:request) { 'MOVE' }

    it 'calls Robots::Move' do
      expect(Robots::Move).to receive(:call).with(robot)
      subject
    end

    it_behaves_like 'without current Robot'
  end

  context 'with LEFT request' do
    let(:request) { 'LEFT' }

    it 'calls Robots::Rotate' do
      expect(Robots::Rotate).to receive(:call).with(robot, :left)
      subject
    end

    it_behaves_like 'without current Robot'
  end

  context 'with RIGHT request' do
    let(:request) { 'RIGHT' }

    it 'calls Robots::Rotate' do
      expect(Robots::Rotate).to receive(:call).with(robot, :right)
      subject
    end

    it_behaves_like 'without current Robot'
  end

  context 'with REPORT request' do
    let(:request) { 'REPORT' }

    it 'calls Robots::Report' do
      expect(Robots::Report).to receive(:call).with(robot)
      subject
    end

    it_behaves_like 'without current Robot'
  end

  context 'with PLACE_OBSTACLE' do
    let(:request) { 'PLACE_OBSTACLE 1,1' }

    it 'calls Obstacles::Place' do
      expect(Obstacles::Place).to receive(:call).with(1, 1)
      subject
    end
  end
end
