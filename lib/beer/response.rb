# frozen_string_literal: true

module Beer
  class Response
    SUCCESSFUL_BEER_RESPONSE_CODE = 'S.0000'.freeze

    class Error
      def initialize(error)
        @error = error
      end

      def id
        nil
      end

      def successful?
        false
      end

      def message
        "[Beer::Client] Failed with error: #{@error.message}"
      end

      def error_message
        params['error_message'].presence || message
      end

      def params
        { 'code' => 'E.1000', 'message' => message, 'error_message' => error_message }
      end

      def http_code
        '500'
      end
    end

    attr_reader :response, :params

    def initialize(response)
      @response = response
      @params = begin
                  JSON.parse(response.body)
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

    def http_code
      response.status.to_s
    end
  end
end
