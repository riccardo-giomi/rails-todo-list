# frozen_string_literal: true

# Basic check that the tooling works
RSpec.describe 'Basic smoke tests' do # rubocop:disable RSpec/DescribeClass
  specify 'RSpec works' do
    expect(true).to be_truthy
  end

  specify 'FactoryBot works' do
    expect { build(:smoke) }.not_to raise_error
  end
end
