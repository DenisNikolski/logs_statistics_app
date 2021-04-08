# frozen_string_literal: true

require_relative '../bin/logs_statatistics'

describe 'logs statistics' do
  describe '#run' do
    subject { run(path) }

    let(:views_statistics_msg) do
      'list of webpages with most page views ordered from most pages views to less page views'
    end
    let(:uniq_views_statistics_msg) do
      'list of webpages with most unique page views also ordered'
    end

    context 'show log file statistics' do
      let(:path) { 'spec/fixtures/files/webserver.log' }

      it { expect { subject }.to output(a_string_including(views_statistics_msg)).to_stdout }
      it { expect { subject }.to output(a_string_including(uniq_views_statistics_msg)).to_stdout }
    end

    context 'when not all info in the file' do
      let(:warning_msg) { 'warning: Record does not have all needed info(line#' }

      context 'when file with missing ip' do
        let(:path) { 'spec/fixtures/files/webserver_with_missing_ip.log' }

        it { expect { subject }.to output(a_string_including(warning_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(views_statistics_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(uniq_views_statistics_msg)).to_stdout }
      end

      context 'when file with missing page' do
        let(:path) { 'spec/fixtures/files/webserver_with_missing_page.log' }

        it { expect { subject }.to output(a_string_including(warning_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(views_statistics_msg)).to_stdout }
        it { expect { subject }.to output(a_string_including(uniq_views_statistics_msg)).to_stdout }
      end
    end

    context 'when no file path is passed' do
      let(:path) {}

      it { expect { subject }.to output(a_string_including('Please specify file path')).to_stdout }
    end

    context 'when file path is empty' do
      let(:path) { '' }

      it { expect { subject }.to output(a_string_including('Please specify file path')).to_stdout }
    end

    context 'when file does not exists' do
      let(:path) { 'file_that_does_not_exists.log' }

      it { expect { subject }.to output(a_string_including('File does not exists')).to_stdout }
    end

    context 'when wrong file extension' do
      let(:path) { 'spec/fixtures/files/webserver.jpg' }

      it { expect { subject }.to output(a_string_including('File have wrong extension')).to_stdout }
    end

    context 'when file is empty' do
      let(:path) { 'spec/fixtures/files/empty_webserver.log' }

      it { expect { subject }.to output(a_string_including('File is empty')).to_stdout }
    end
  end
end
