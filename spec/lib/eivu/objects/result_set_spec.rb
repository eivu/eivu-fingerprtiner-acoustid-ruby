# frozen_string_literal: true

require 'spec_helper'
require 'eivu/eivu-objects'

describe Eivu::Objects::ResultSet do
  subject(:instance) { described_class.new(**info) }

  describe '#new' do
    context 'with results' do
      let(:info) do
        Oj.load(
          File.read('spec/fixtures/objects/result_set_01_tank.json')
        ).deep_symbolize_keys
      end

      it 'parses the hash successfully' do
        aggregate_failures do
          expect(instance.results.count).to eq(1)
          expect(instance.results[0].id).to eq('75d9e6c8')
          expect(instance.results[0].recordings[0].id).to eq('72a74c8b')
          expect(instance.results[0].recordings[1].id).to eq('9737ce56')
          expect(instance.results[0].score).to eq(0.999934)
          expect(instance.status).to eq('ok')
        end
      end
    end

    context 'without results' do
      let(:info) { { results: [], status: 'ok' } }

      it 'parses the hash successfully' do
        expect(instance.results.count).to eq(0)
        expect(instance.status).to eq('ok')
      end
    end
  end

  describe 'ok?' do
    subject(:response) { described_class.new(**info).ok? }

    context 'success' do
      let(:info) { { results: [], status: 'ok' } }

      it 'parses the hash successfully' do
        expect(response).to be(true)
      end
    end

    context 'failure' do
      let(:info) { { results: [], status: 'failure' } }

      it 'parses the hash successfully' do
        expect(response).to be(false)
      end
    end
  end
end