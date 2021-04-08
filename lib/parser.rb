# frozen_string_literal: true

require_relative 'page_views'
require 'English'

class Parser
  def initialize
    @pages_visitors_ips = Hash.new([])
  end

  def parse(path)
    populate_page_visitors_ip(path)
    construct_page_views
  end

  private

  def populate_page_visitors_ip(path)
    File.foreach(path) do |line|
      page, ip = line.split
      if ip.nil?
        puts "warning: Record does not have all needed info(line# #{$INPUT_LINE_NUMBER})"
        next
      end

      @pages_visitors_ips[page] += [ip]
    end
  end

  def construct_page_views
    [].tap do |page_views|
      @pages_visitors_ips.each_pair do |page, ip_addresses|
        page_views << PageViews.new(page, ip_addresses.count, ip_addresses.uniq.count)
      end
    end
  end
end
