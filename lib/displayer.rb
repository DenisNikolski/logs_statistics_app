# frozen_string_literal: true

class Displayer
  def self.call(page_views, counter_key, messages)
    puts messages[:header_msg]
    page_views.each { |page_view| puts "#{page_view.page} #{page_view[counter_key]} #{messages[:item_msg]}" }
    puts
  end
end
