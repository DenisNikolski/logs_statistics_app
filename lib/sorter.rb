# frozen_string_literal: true

class Sorter
  def initialize(pages_views)
    @page_views = pages_views
  end

  def call(criteria)
    sort(criteria)
  end

  private

  def sort(criteria)
    @page_views.sort_by { |page_view| -page_view[criteria] }
  end
end
