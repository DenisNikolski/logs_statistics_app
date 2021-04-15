# frozen_string_literal: true

require 'English'
require 'ipaddress'
require_relative '../validation_exception'

class FileDataValidator
  class << self
    def valid?(page, ip)
      validate_data(page, ip)
    rescue ValidationException => e
      puts e
      false
    end

    private

    def validate_data(page, ip)
      msg = check_data_presence(page, ip) || check_ip(ip) || check_page(page)
      raise ValidationException, msg unless msg.nil?

      true
    end

    def check_data_presence(page, ip)
      "warning: Record does not have all needed info(line# #{$INPUT_LINE_NUMBER})" if page.nil? || ip.nil?
    end

    def check_ip(ip)
      "warning: IP address #{ip} on line #{$INPUT_LINE_NUMBER} is wrong" unless IPAddress.valid?(ip)
    end

    def check_page(page)
      "warning: page #{page} on line #{$INPUT_LINE_NUMBER} is wrong" unless !!(page =~ %r{^/})
    end
  end
end
