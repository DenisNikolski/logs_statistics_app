# frozen_string_literal: true

require_relative '../lib/validator'
require_relative '../lib/parser'
require_relative '../lib/sorter'
require_relative '../lib/displayer'

def run(path)
  return unless Validator.new(path).valid?

  pages_views = Parser.new.parse(path)

  sorter = Sorter.new
  pages_sorted_by_views = sorter.sort(pages_views, :views)
  pages_sorted_by_uniq_views = sorter.sort(pages_views, :uniq_views)

  Displayer.new.display(pages_sorted_by_views, pages_sorted_by_uniq_views)
end

run(ARGV.first) if $PROGRAM_NAME == __FILE__
