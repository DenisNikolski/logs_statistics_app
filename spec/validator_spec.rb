# frozen_string_literal: true

require 'validator'

describe Validator do
  describe '#valid?' do
    subject { Validator.new(file_path).valid? }

    context 'proper file exists' do
      let(:file_path) { 'spec/fixtures/files/webserver.log' }

      it { is_expected.to eq(true) }
    end

    context 'no file path is passed' do
      let(:file_path) {}

      it { is_expected.to eq(false) }
    end

    context 'wrong file extension' do
      let(:file_path) { 'webserver.jpg' }

      it { is_expected.to eq(false) }
    end

    context 'file extension without extension' do
      let(:file_path) { 'webserver' }

      it { is_expected.to eq(false) }
    end

    context 'file path is empty' do
      let(:file_path) { '' }

      it { is_expected.to eq(false) }
    end

    context 'file does not exists' do
      let(:file_path) { 'spec/fixtures/files/file_that_does_not_exists.log' }

      it { is_expected.to eq(false) }
    end
  end
end
