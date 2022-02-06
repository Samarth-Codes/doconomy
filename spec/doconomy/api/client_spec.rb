# frozen_string_literal: true

RSpec.describe Doconomy::Api::Client do
  let(:client) { Doconomy::Api::Client.new }

  before { expect(client).to receive(:request).with(http_method, endpoint, payload, headers, options) }

  describe '#get' do
    let(:http_method) { :get }
    let(:endpoint) { '/this-is-get-endpoint' }
    let(:payload) { nil }
    let(:headers) { { 'Content-Type' => 'application/json' } }
    let(:options) { {} }

    it 'should execute GET request' do
      client.get(endpoint)
    end
  end

  describe '#post' do
    let(:http_method) { :post }
    let(:endpoint) { '/this-is-post-endpoint' }
    let(:payload) { { 'param1' => 'value1' } }
    let(:headers) { { 'Content-Type' => 'application/json' } }
    let(:options) { {} }

    it 'should execute POST request' do
      client.post(endpoint, payload, headers, options)
    end
  end

  describe '#put' do
    let(:http_method) { :put }
    let(:endpoint) { '/this-is-put-endpoint' }
    let(:payload) { { 'param1' => 'value1' } }
    let(:headers) { { 'Content-Type' => 'application/json' } }
    let(:options) { {} }

    it 'should execute PUT request' do
      client.put(endpoint, payload, headers, options)
    end
  end

  describe '#head' do
    let(:http_method) { :head }
    let(:endpoint) { '/this-is-head-endpoint' }
    let(:payload) { nil }
    let(:headers) { { 'Content-Type' => 'application/json' } }
    let(:options) { {} }

    it 'should execute HEAD request' do
      client.head(endpoint, headers, options)
    end
  end

  describe '#delete' do
    let(:http_method) { :delete }
    let(:endpoint) { '/this-is-delete-endpoint' }
    let(:payload) { nil }
    let(:headers) { { 'Content-Type' => 'application/json' } }
    let(:options) { {} }

    it 'should execute HEAD request' do
      client.delete(endpoint, headers, options)
    end
  end
end
