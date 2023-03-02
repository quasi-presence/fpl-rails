require 'rails_helper'

RSpec.describe Api::Service, type: :service do
  describe '.call' do
    let(:result) { described_class.call(version, service_name, params) }

    context 'service that is supported' do
      let(:create_foo_klass) do
        Class.new do
          def self.call(params)
            { 'service_name' => 'CreateFoo called' }
          end
        end
      end
      let(:version) { 'v1' }
      let(:service_name) { 'CreateFoo'}
      let(:params) { { } }

      before do
        stub_const('Api::V1::CreateFoo', create_foo_klass)
      end

      it 'proxies call to service' do
        expect(result).to eq({ 'service_name' => 'CreateFoo called' })
      end
    end

    context 'service that is not supported' do
      let(:version) { 'v1' }
      let(:service_name) { 'NonExistent'}
      let(:params) { { } }

      it 'returns error' do
        expect(result).to eq({ 'errors' => ["API v1 does not support non existent"] })
      end
    end
  end
end
