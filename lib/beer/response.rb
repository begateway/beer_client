# frozen_string_literal: true

module Beer
  class Response
    SUCCESSFUL_BEER_RESPONSE_CODE = 'S.0000'.freeze

    attr_reader :http_code, :params

    def initialize(http_code, body)
      @http_code = http_code
      @params = begin
                  JSON.parse(body)
                rescue JSON::ParserError
                  {}
                end
    end

    # for /sources endpoint without :index
    def id
      if params['data'].is_a?(Hash)
        params.dig('data', 'id')
      end
    end

    def successful?
      code = params['code']
      return code == SUCCESSFUL_BEER_RESPONSE_CODE if code.present?

      (200..299).include?(http_code.to_i)
    end

    def message
      params['message'].presence ||
        params['friendly_message'].presence ||
        (successful? ? 'Successful executed' : 'Executed with error')
    end

    def error_message
      params['error_message'].presence
    end
  end
end
