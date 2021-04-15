# frozen_string_literal: true

require 'bundler/setup'
require_relative '../lib/validators/file_validator'
require_relative '../lib/validators/file_data_validator'
require_relative '../lib/parser'
require_relative '../lib/sorter'
require_relative '../lib/displayer'
require_relative '../lib/page_views_constructor'
require_relative '../lib/constants/messages'

class LogsStatistics
  include Messages

  def initialize(path)
    @path = path
  end

  def call
    return unless FileValidator.new(@path).valid?

    pages_ips = Parser.new(FileDataValidator, @path).call
    pages_views = PageViewsConstructor.new(pages_ips).call

    sorter = Sorter.new(pages_views)
    pages_sorted_by_views = sorter.call(:views)
    pages_sorted_by_uniq_views = sorter.call(:uniq_views)

    Displayer.call(pages_sorted_by_views, :views, header_msg: ALL_VIEWS_HEADING_MSG,
                   item_msg: ALL_VIEWS_LINE_MSG)
    Displayer.call(pages_sorted_by_uniq_views, :uniq_views, header_msg: UNIQ_VIEWS_HEADING_MSG,
                   item_msg: UNIQ_VIEWS_LINE_MSG)
  end
end

LogsStatistics.new(ARGV.first).call if $PROGRAM_NAME == __FILE__
