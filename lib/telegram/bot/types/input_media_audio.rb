# frozen_string_literal: true

module Telegram
  module Bot
    module Types
      class InputMediaAudio < Base
        attribute :type, Types::String.default('audio')
        attribute :media, Types::String
        attribute? :thumb, Types::String
        attribute? :caption, Types::String
        attribute? :parse_mode, Types::String
        attribute? :caption_entities, Types::Array.of(MessageEntity)
        attribute? :duration, Types::Integer
        attribute? :performer, Types::String
        attribute? :title, Types::String
      end
    end
  end
end
