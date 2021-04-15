# frozen_string_literal: true

require_relative 'page_views'

class Parser
  def initialize(data_validator, path)
    @path = path
    @data_validator = data_validator
    @pages_visitors_ips = Hash.new([])
  end

  def call
    parse_page_visitors_ip
  end

  private

  def parse_page_visitors_ip
    File.foreach(@path) do |line|
      page, ip = line.split
      next unless @data_validator.valid?(page, ip)

      @pages_visitors_ips[page] += [ip]
    end
    @pages_visitors_ips
  end
end
