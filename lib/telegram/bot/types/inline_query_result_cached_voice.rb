module Telegram
  module Bot
    module Types
      class InlineQueryResultCachedVoice < Base
        attribute :type, String, default: 'video'
        attribute :id, String
        attribute :voice_file_id, String
        attribute :title, String
        attribute :reply_markup, InlineKeyboardMarkup
        attribute :input_message_content, InputMessageContent
      end
    end
  end
end
