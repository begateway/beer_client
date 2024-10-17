# frozen_string_literal: true

module Beer
  class Response
    SUCCESSFUL_BEER_RESPONSE_CODE = 'S.0000'.freeze

    attr_reader :http_code, :data

    def initialize(http_code, body)
      @http_code = http_code
      @data = begin
                JSON.parse(body)
              rescue JSON::ParserError
                {}
              end
    end

    # for /sources endpoint without :index
    def id
      if data['data'].is_a?(Hash)
        data.dig('data', 'id')
      end
    end

    def success?
      code = data['code']
      return code == SUCCESSFUL_BEER_RESPONSE_CODE if code.present?

      (200..299).include?(http_code.to_i)
    end

    def message
      data['message'].presence ||
        data['friendly_message'].presence ||
        (success? ? 'Successful executed' : 'Executed with error')
    end

    def error_message
      data['error_message'].presence
    end
  end
end
