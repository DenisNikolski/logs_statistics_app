# frozen_string_literal: true

class PageViewsConstructor
  def initialize(pages_visitors_ips)
    @pages_visitors_ips = pages_visitors_ips
  end

  def call
    construct_page_views
  end

  private

  def construct_page_views
    @pages_visitors_ips.each_with_object([]) do |(page, ip_addresses), page_views|
      page_views << PageViews.new(page, ip_addresses.count, ip_addresses.uniq.count)
    end
  end
end
