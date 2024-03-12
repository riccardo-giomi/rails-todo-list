# frozen_string_literal: true

FactoryBot.define do
  factory :todo do
    name { 'Name Value' }
    description { 'Description Value' }

    # Handy for specs with more than one record, specifically those specifying
    # update operations
    factory :another_todo do
      name { 'Another Name Value' }
      description { 'Another Description Value' }
    end

    # Used to generate "models with valid attributes" in specs, e.g. for
    # requests.
    #
    # Same as the default factory if there are no special attributes like
    # attachments.
    # It can be expanded later if the model gains special attributes.
    factory :complete_todo
    # Used to create "model with invalid attributes" in specs (e.g. requests).
    # Add invalid/empty values here for attributes as you define validations for
    # them in the model.
    #
    # Note that if there are required attachments nothing needs to be added here.
    factory :invalid_todo do
      name { nil }
    end
  end
end
