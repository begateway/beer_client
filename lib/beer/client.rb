# frozen_string_literal: true

require 'logger'
require 'ostruct'

module Beer
  class Client
    BASIC_AUTH_LOGIN = 'admin'.freeze
    DEFAULT_API_VERSION = '1'.freeze
    DEFAULT_OPEN_TIMEOUT = 5
    DEFAULT_TIMEOUT = 25

    attr_reader :secret_key, :beer_url, :opts, :headers, :api_version, :logger
    cattr_accessor :proxy

    def initialize(params)
      @secret_key = params.fetch(:secret_key)
      @beer_url = params.fetch(:url)
      @opts = params[:options] || {}
      @headers = (@opts[:headers] || {}).except('X-Api-Version') # BeER only supports API V1. For multi supporting: @headers = @opts[:headers] || {}
      @api_version = DEFAULT_API_VERSION # BeER only supports API V1. For multi supporting: @api_version = @headers.dig( 'X-Api-Version').presence || DEFAULT_API_VERSION
      @logger = params[:logger] || Logger.new(STDOUT)
    end

    # /sources :index
    def get_all_source
      get("#{api_path}/sources")
    end

    # /sources :show
    def get_source_by_id(id)
      get("#{api_path}/sources/#{id}")
    end

    # /sources :create
    def create_source(params)
      post("#{api_path}/sources", source: params)
    end

    # /sources :update
    def update_source_by_id(id, params)
      patch("#{api_path}/sources/#{id}", source: params)
    end

    # /sources :delete
    def delete_source_by_id(id)
      delete("#{api_path}/sources/#{id}")
    end

    def exchange_rates(params)
      post("#{api_path}/exchange/rates", params)
    end

    def exchange_calculator(params)
      post("#{api_path}/exchange/calculator", params)
    end

    def exchange_sources_info(params)
      post("#{api_path}/exchange/sources_info", params)
    end

    private

    attr_reader :response

    def request
      begin
        Response.new(yield)
      rescue StandardError => e
        logger.error("Error: #{e.message}\nTrace:\n#{e.backtrace.join("\n")}")
        Response::Error.new(e)
      end
    end

    def connection
      @connection ||= Faraday::Connection.new(opts) do |c|
        c.options[:open_timeout] ||= DEFAULT_OPEN_TIMEOUT
        c.options[:timeout] ||= DEFAULT_TIMEOUT
        c.options[:proxy] = proxy if proxy
        c.request :json

        c.headers = {'Content-Type' => 'application/json'}.update(opts[:headers].to_h)

        c.basic_auth(BASIC_AUTH_LOGIN, secret_key)
        c.adapter Faraday.default_adapter
      end
    end

    def post(path, data = {})
      request { connection.post(full_path(path), data.to_json) }
    end

    def get(path)
      request { connection.get(full_path(path)) }
    end

    def patch(path, data = {})
      request { connection.patch(full_path(path), data.to_json) }
    end

    def delete(path)
      request { connection.delete(full_path(path)) }
    end

    def full_path(path)
      [beer_url, path].join
    end

    def api_path
      "/api/v#{api_version}"
    end
  end
end
