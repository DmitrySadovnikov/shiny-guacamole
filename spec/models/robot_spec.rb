require 'spec_helper'

describe Robot do
  subject { described_class.new(point, facing) }

  describe '#valid?' do
    shared_context 'when successful cases' do |point, facing, is_valid, errors = []|
      let(:point) { point }
      let(:facing) { facing }

      it 'validates' do
        expect(subject.valid?).to eq(is_valid)
      end

      it 'returns errors' do
        subject.valid?
        expect(subject.errors).to eq(errors)
      end
    end

    it_behaves_like 'when successful cases', Point.new(0, 0), :north, true
    it_behaves_like 'when successful cases', nil, :north, false, [:point_empty]
    it_behaves_like 'when successful cases', Point.new(0, 0), nil, false, [:facing_empty]
    it_behaves_like 'when successful cases', Point.new(0, 0), :foobar, false, [:facing_invalid]
    it_behaves_like 'when successful cases', Point.new(-1, 0), :north, false, [:point_invalid]
  end
end
