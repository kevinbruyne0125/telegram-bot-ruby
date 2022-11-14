# frozen_string_literal: true

module Telegram
  module Bot
    module Types
      class InputMediaVideo < Base
        attribute :type, Types::String.default('video')
        attribute :media, Types::String
        attribute? :thumb, Types::String
        attribute? :caption, Types::String
        attribute? :parse_mode, Types::String
        attribute? :caption_entities, Types::Array.of(MessageEntity)
        attribute? :width, Types::Integer
        attribute? :height, Types::Integer
        attribute? :duration, Types::Integer
        attribute? :supports_streaming, Types::Bool
      end
    end
  end
end
