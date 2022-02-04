# frozen_string_literal: true

RSpec.describe Doconomy::Api::Category do
  let(:attributes) do
    { id: '123', main_category: { id: '1234', name: 'main' }, sub_category: { id: '1235', name: 'sub' } }
  end
  let(:category) { Doconomy::Api::Category.new(attributes) }

  it 'should return id' do
    expect(category.id).to eq('123')
  end

  it 'should return main_category.id' do
    expect(category.main_category.id).to eq('1234')
  end

  it 'should return main_category.name' do
    expect(category.main_category.name).to eq('main')
  end

  it 'should return sub_category.id' do
    expect(category.sub_category.id).to eq('1235')
  end

  it 'should return sub_category.name' do
    expect(category.sub_category.name).to eq('sub')
  end

  it 'should return attributes' do
    expect(category.attributes).to eq(attributes)
  end
end
