# frozen_string_literal: true

require 'validators/file_data_validator'

describe FileDataValidator do
  describe '#valid?' do
    subject { FileDataValidator.valid?(page, ip) }

    context 'when page and ip present' do
      let(:page) { '/about' }
      let(:ip) { '1.1.1.1' }

      it { is_expected.to eq(true) }
    end

    context 'when no page' do
      let(:page) {}
      let(:ip) { '1.1.1.1' }

      it { is_expected.to eq(false) }
    end

    context 'when no ip' do
      let(:page) { '/about' }
      let(:ip) {}

      it { is_expected.to eq(false) }
    end

    context 'when ip is wrong' do
      let(:page) { '/about' }
      let(:ip) { '/about' }

      it { is_expected.to eq(false) }
    end

    context 'when page is wrong' do
      let(:page) { '1.1.1.1' }
      let(:ip) { '1.1.1.1' }

      it { is_expected.to eq(false) }
    end
  end
end
