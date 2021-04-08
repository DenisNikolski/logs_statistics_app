# frozen_string_literal: true

class Displayer
  ALL_VIEWS_HEADING_MGS = 'list of webpages with most page views ordered from most pages views to less page views'
  ALL_VIEWS_LINE_MSG = 'visits'
  UNIQ_VIEWS_HEADING_MGS = 'list of webpages with most unique page views also ordered'
  UNIQ_VIEWS_LINE_MSG = 'unique views'

  def display(sorted_by_views, sorted_by_uniq_views)
    puts ALL_VIEWS_HEADING_MGS
    write_statistics_to_console(sorted_by_views, :views, ALL_VIEWS_LINE_MSG)
    puts UNIQ_VIEWS_HEADING_MGS
    write_statistics_to_console(sorted_by_uniq_views, :uniq_views, UNIQ_VIEWS_LINE_MSG)
  end

  private

  def write_statistics_to_console(page_views, counter_key, line_message)
    page_views.each { |page_view| puts "#{page_view.page} #{page_view[counter_key]} #{line_message}" }
    puts
  end
end
