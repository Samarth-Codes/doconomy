# frozen_string_literal: true

RSpec.describe Doconomy::Api::Language do
  let(:language) { Doconomy::Api::Language.new(code: 'PL') }

  it 'should return code' do
    expect(language.code).to eq('PL')
  end

  it 'should return attributes' do
    expect(language.attributes).to eq({ code: 'PL' })
  end
end
