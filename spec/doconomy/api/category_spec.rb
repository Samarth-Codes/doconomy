# frozen_string_literal: true

RSpec.describe Doconomy::Api::Category, type: :sandbox do
  let(:attributes) do
    { id: '123', main_category: { id: '1234', name: 'main' }, sub_category: { id: '1235', name: 'sub' } }
  end
  let(:category) { Doconomy::Api::Category.new(attributes) }

  describe '#initialize' do
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

  describe '#all' do
    let(:categories) { Doconomy::Api::Category.all }

    it 'should get all categories' do
      VCR.use_cassette('it_should_get_all_categories') do
        expect(categories.size).to eq(34)
      end
    end
  end

  describe '#find' do
    let(:category) { Doconomy::Api::Category.find(1) }

    it 'should get a category with a specific id' do
      VCR.use_cassette('it_should_get_a_category_with_a_specific_id') do
        expect(category.id).to eq(1)
        expect(category.main_category.id).to eq(1)
        expect(category.main_category.name).to eq('Home & Garden')
        expect(category.sub_category.id).to eq(1)
        expect(category.sub_category.name).to eq('Hardware & Construction')
      end
    end
  end
end
