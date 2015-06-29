module Telegram
  module Bot
    class Api
      include HTTParty

      ENDPOINTS = %w(
        getMe sendMessage forwardMessage sendPhoto sendAudio sendDocument
        sendSticker sendVideo sendLocation sendChatAction getUserProfilePhotos
        getUpdates setWebhook
      ).freeze
      REPLY_MARKUP_TYPES = [
        Telegram::Bot::Types::ReplyKeyboardMarkup,
        Telegram::Bot::Types::ReplyKeyboardHide,
        Telegram::Bot::Types::ForceReply
      ].freeze

      attr_reader :token

      base_uri 'https://api.telegram.org'
      persistent_connection_adapter

      def initialize(token)
        @token = token
      end

      def method_missing(method_name, *args, &block)
        ENDPOINTS.include?(method_name.to_s) ? call(method_name, *args) : super
      end

      def call(endpoint, raw_params = {})
        params = build_params(raw_params)
        response = self.class.get("/bot#{token}/#{endpoint}", query: params)
        response.code == 200 ? response.to_h : {}
      end

      private

      def build_params(h)
        h.each_with_object({}) do |(key, value), params|
          params[key] = sanitize_value(value)
        end
      end

      def sanitize_value(value)
        jsonify_reply_markup(value)
      end

      def jsonify_reply_markup(value)
        return value unless REPLY_MARKUP_TYPES.include?(value.class)
        value.to_h.to_json
      end
    end
  end
end
