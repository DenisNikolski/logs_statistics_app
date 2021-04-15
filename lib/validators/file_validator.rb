# frozen_string_literal: true

require_relative '../validation_exception'

class FileValidator
  MSG_EMPTY_PATH = 'Please specify file path'
  MSG_NO_FILE = 'File does not exists'
  MSG_WRONG_EXTENSION = 'File have wrong extension'
  MSG_EMPTY_FILE = 'File is empty'

  def initialize(path)
    @path = path
  end

  def valid?
    validate_file
  rescue ValidationException => e
    puts e
    false
  end

  private

  def validate_file
    msg = check_presence || check_extension || check_existence || check_not_empty
    raise ValidationException, msg unless msg.nil?

    true
  end

  def check_presence
    MSG_EMPTY_PATH if @path.nil? || @path.empty?
  end

  def check_extension
    MSG_WRONG_EXTENSION unless @path.split('.').last == 'log'
  end

  def check_existence
    MSG_NO_FILE unless File.file?(@path)
  end

  def check_not_empty
    MSG_EMPTY_FILE if File.zero?(@path)
  end
end
