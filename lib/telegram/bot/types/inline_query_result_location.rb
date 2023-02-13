# frozen_string_literal: true

module Telegram
  module Bot
    module Types
      class InlineQueryResultLocation < Base
        attribute :type, Types::String.default('location')
        attribute :id, Types::String
        attribute :latitude, Types::Float
        attribute :longitude, Types::Float
        attribute :title, Types::String
        attribute? :horizontal_accuracy, Types::Float
        attribute? :live_period, Types::Integer
        attribute? :heading, Types::Integer
        attribute? :proximity_alert_radius, Types::Integer
        attribute? :reply_markup, InlineKeyboardMarkup
        attribute? :input_message_content, InputMessageContent
        attribute? :thumb_url, Types::String
        attribute? :thumb_width, Types::Integer
        attribute? :thumb_height, Types::Integer
      end
    end
  end
end
