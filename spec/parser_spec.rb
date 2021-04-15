# frozen_string_literal: true

require 'parser'
require 'page_views'
require 'validators/file_data_validator'

describe Parser do
  describe '#call' do
    subject { Parser.new(FileDataValidator, file).call }

    context 'when file contains all data' do
      let(:file) { 'spec/fixtures/files/webserver_small.log' }
      let(:pages_ips) do
        { '/about' => %w[1.1.1.1 1.1.1.1 1.1.1.5 1.1.1.5],
          '/help_page/1' => %w[1.1.1.4 1.1.1.4],
          '/home' => %w[1.1.1.2 1.1.1.3 1.1.1.7] }
      end

      it { is_expected.to eq(pages_ips) }
    end

    context 'when file with missing IP' do
      let(:file) { 'spec/fixtures/files/webserver_with_missing_ip.log' }
      let(:pages_ips) do
        { '/about' => %w[1.1.1.1 1.1.1.1 1.1.1.5],
          '/help_page/1' => %w[1.1.1.3 1.1.1.3],
          '/home' => %w[1.1.1.2 1.1.1.6] }
      end
      it { is_expected.to eq(pages_ips) }
    end

    context 'when file with missing page' do
      let(:file) { 'spec/fixtures/files/webserver_with_missing_page.log' }
      let(:pages_ips) do
        { '/about' => %w[1.1.1.1 1.1.1.1 1.1.1.5],
          '/help_page/1' => %w[1.1.1.4 1.1.1.4],
          '/home' => %w[1.1.1.3 1.1.1.6] }
      end

      it { is_expected.to eq(pages_ips) }
    end
  end
end
