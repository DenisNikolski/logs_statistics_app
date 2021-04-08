# frozen_string_literal: true

require_relative 'validation_exception'

class Validator
  MSG_EMPTY_PATH = 'Please specify file path'
  MSG_NO_FILE = 'File does not exists'
  MSG_WRONG_EXTENSION = 'File have wrong extension'
  MSG_EMPTY_FILE = 'File is empty'

  def initialize(path)
    @path = path
  end

  def valid?
    path_present? && correct_extension? && file_exists? && file_not_empty?
  rescue ValidationException => e
    puts e
    false
  end

  private

  def path_present?
    raise ValidationException, MSG_EMPTY_PATH if @path.nil? || @path.empty?

    true
  end

  def correct_extension?
    raise ValidationException, MSG_WRONG_EXTENSION unless @path.split('.').last == 'log'

    true
  end

  def file_exists?
    raise ValidationException, MSG_NO_FILE unless File.file?(@path)

    true
  end

  def file_not_empty?
    raise ValidationException, MSG_EMPTY_FILE if File.zero?(@path)

    true
  end
end
