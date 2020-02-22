require 'spec_helper'

describe Point do
  subject { described_class.new(x, y) }

  describe '#valid?' do
    shared_context 'when successful cases' do |x, y, is_valid, errors = []|
      let(:x) { x }
      let(:y) { y }

      it 'validates' do
        expect(subject.valid?).to eq(is_valid)
      end

      it 'returns errors' do
        subject.valid?
        expect(subject.errors).to eq(errors)
      end
    end

    it_behaves_like 'when successful cases', 0, 0, true
    it_behaves_like 'when successful cases', 5, 5, true
    it_behaves_like 'when successful cases', -1, 0, false, [:x_out_of_range]
    it_behaves_like 'when successful cases', 0, -1, false, [:y_out_of_range]
    it_behaves_like 'when successful cases', 6, 5, false, [:x_out_of_range]
    it_behaves_like 'when successful cases', 5, 6, false, [:y_out_of_range]
    it_behaves_like 'when successful cases', nil, 1, false, [:x_empty]
    it_behaves_like 'when successful cases', 1, nil, false, [:y_empty]
    it_behaves_like 'when successful cases', 3.3, 1, false, [:x_invalid]
    it_behaves_like 'when successful cases', 1, 'string', false, [:y_invalid]
  end
end
