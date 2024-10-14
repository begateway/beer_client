# -*- coding: utf-8 -*-
require 'spec_helper'
require 'json'

RSpec.describe Beer::Client do
  let(:client) do
    Beer::Client.new(secret_key: 'secret_key', url: 'https://beer-staging.begateway.com')
  end

  describe '#get_all_source' do
    subject { client.get_all_source }

    context 'successful BeER response' do
      before { stub_request(:get, /sources/).to_return(status: 200, body: body) }
      let(:body) do
        {
          "data": [
            {
              "enabled": true,
              "id": 1,
              "type": "open_exchange",
              "credentials": {},
              "base": "USD"
            },
            {
              "enabled": true,
              "id": 2,
              "type": "nbrb",
              "credentials": {},
              "base": "BYN"
            },
            {
              "enabled": true,
              "id": 3,
              "type": "bank_dabrabyt",
              "credentials": {},
              "base": "BYN"
            }
          ]
        }.to_json
      end

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successful executed')
        expect(response.http_code).to eq('200')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:get, /sources/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#get_source_by_id' do
    subject { client.get_source_by_id(1) }

    context 'successful BeER response' do
      before { stub_request(:get, /sources/).to_return(status: 200, body: body) }
      let(:body) do
        {
          "data": {
            "enabled": true,
            "id": 1,
            "type": "open_exchange",
            "credentials": {},
            "base": "USD"
          }
        }.to_json
      end

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq(JSON.parse(body))
        expect(response.id).to eq(1)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successful executed')
        expect(response.http_code).to eq('200')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:get, /sources/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#create_source' do
    subject { client.create_source({}) }

    context 'successful BeER response' do
      before { stub_request(:post, /sources/).to_return(status: 200, body: body) }
      let(:body) do
        {
          "data": {
            "enabled": true,
            "id": 1,
            "type": "open_exchange",
            "credentials": {},
            "base": "USD"
          }
        }.to_json
      end

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq(JSON.parse(body))
        expect(response.id).to eq(1)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successful executed')
        expect(response.http_code).to eq('200')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:post, /sources/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#update_source_by_id' do
    subject { client.update_source_by_id(1, {}) }

    context 'successful BeER response' do
      before { stub_request(:patch, /sources/).to_return(status: 200, body: body) }
      let(:body) do
        {
          "data": {
            "enabled": true,
            "id": 1,
            "type": "open_exchange",
            "credentials": {},
            "base": "USD"
          }
        }.to_json
      end

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq(JSON.parse(body))
        expect(response.id).to eq(1)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successful executed')
        expect(response.http_code).to eq('200')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:patch, /sources/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#delete_source_by_id' do
    subject { client.delete_source_by_id(1) }

    context 'successful BeER response' do
      before { stub_request(:delete, /sources/).to_return(status: 204, body: body) }
      let(:body) { '' }

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq({})
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successful executed')
        expect(response.http_code).to eq('204')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:delete, /sources/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#exchange_rates' do
    subject { client.exchange_rates({}) }

    context 'successful BeER response' do
      before { stub_request(:post, /exchange/).to_return(status: 200, body: body) }
      let(:body) do
        {
          "code": "S.0000",
          "message": "Successfully received exchange rates",
          "source": "open_exchange",
          "exchange_rates": [
            {
              "name": "USD/BBD",
              "value": "2.0",
              "scale": 1
            },
            {
              "name": "USD/BAM",
              "value": "1.751081",
              "scale": 1
            }
          ]
        }.to_json
      end

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successfully received exchange rates')
        expect(response.http_code).to eq('200')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:post, /exchange/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#exchange_calculator' do
    subject { client.exchange_calculator({}) }

    context 'successful BeER response' do
      before { stub_request(:post, /exchange/).to_return(status: 200, body: body) }
      let(:body) do
        {
          "code": "S.0000",
          "message": "Successfully received exchange rates",
          "source": "open_exchange",
          "source_base": "USD",
          "converted_amount": 327,
          "exchange_rate": {
            "name": "USD/BYN",
            "value": "3.267646"
          },
          "exchange_rate_date": "2024-09-27T09:03:01.561854",
          "friendly_message": "The operation is successful."
        }.to_json
      end

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successfully received exchange rates')
        expect(response.http_code).to eq('200')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:post, /exchange/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#exchange_sources_info' do
    subject { client.exchange_sources_info({}) }

    context 'successful BeER response' do
      before { stub_request(:post, /exchange/).to_return(status: 200, body: body) }
      let(:body) do
        {
          "code": "S.0000",
          "message": "Successfully received exchange rates",
          "sources": [
            {
              "type": "open_exchange",
              "base": "USD",
              "currencies": [
                "AED",
                "AFN",
                "ANG"
              ]
            }
          ]
        }.to_json
      end

      it 'returns a list of sources' do
        response = subject
        expect(response.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(true)
        expect(response.message).to eq('Successfully received exchange rates')
        expect(response.http_code).to eq('200')
      end
    end

    context 'failed BeER response' do
      before { stub_request(:post, /exchange/).to_return(status: 404, body: body) }
      let(:body) do
        {
          code: 'E.1000',
          message: 'Not Found',
          friendly_message: 'Not Found'
        }.to_json
      end

      it 'returns error' do
        response = subject
        expect(subject.params).to eq(JSON.parse(body))
        expect(response.id).to eq(nil)
        expect(response.successful?).to eq(false)
        expect(response.message).to eq('Not Found')
        expect(response.http_code).to eq('404')
      end
    end
  end

  describe '#initialization' do
    let(:secret_key) { 'secret_key' }
    let(:url) { 'https://beer-staging.begateway.com' }
    let(:headers) { {'X-Request-ID' => '112233'} }
    let(:client) do
      Beer::Client.new(secret_key: secret_key,
                       url: url,
                       options: {headers: headers})
    end

    it 'sets secret_key' do
      expect(client.secret_key).to eq(secret_key)
    end

    it "sets url" do
      expect(client.beer_url).to eq(url)
    end

    it 'sets opts' do
      expect(client.opts).to eq(headers: headers)
    end
  end

  describe '#connection' do
    context 'when passed headers in options' do
      let(:secret_key) { 'secret_key' }
      let(:url) { 'https://beer-staging.begateway.com' }
      let(:headers) { {'X-Request-ID' => '112233'} }
      let(:client) do
        Beer::Client.new(secret_key: secret_key,
                          url: url,
                          options: {headers: headers})
      end

      it 'adds this headers to connection' do
        expect(client.send(:connection).headers).to include(headers)
      end
    end

    context 'when there are network issues' do
      let(:client) { Beer::Client.new(secret_key: '1', url: 'https://example.com') }

      before do
        stub_request(:get, /example.com/).and_raise(Net::ReadTimeout)
      end

      it 'returns error response' do
        expect {
          expect(client.get_all_source).to be_kind_of(Beer::Response::Error)
        }.not_to raise_exception
      end
    end
  end
end
