# frozen_string_literal: true

require 'validators/file_validator'

describe FileValidator do
  describe '#valid?' do
    subject { FileValidator.new(file_path).valid? }

    context 'when proper file exists' do
      let(:file_path) { 'spec/fixtures/files/webserver.log' }

      it { is_expected.to eq(true) }
    end

    context 'when no file path is passed' do
      let(:file_path) {}

      it { is_expected.to eq(false) }
    end

    context 'when wrong file extension' do
      let(:file_path) { 'webserver.jpg' }

      it { is_expected.to eq(false) }
    end

    context 'when file without extension' do
      let(:file_path) { 'webserver' }

      it { is_expected.to eq(false) }
    end

    context 'when file path is empty' do
      let(:file_path) { '' }

      it { is_expected.to eq(false) }
    end

    context 'when file does not exists' do
      let(:file_path) { 'spec/fixtures/files/file_that_does_not_exists.log' }

      it { is_expected.to eq(false) }
    end
  end
end
