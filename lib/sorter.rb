# frozen_string_literal: true

class Sorter
  def sort(pages_views, criteria)
    pages_views.sort_by(&criteria).reverse
  end
end
