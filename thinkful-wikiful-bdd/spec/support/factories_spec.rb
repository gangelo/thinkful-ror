#
# https://github.com/thoughtbot/factory_girl/wiki/Testing-all-Factories-(with-RSpec)
require 'rails_helper' 

RSpec.describe "Factory Girl" do

  FactoryGirl.factories.map(&:name).each do |factory_name|
    
    describe "#{factory_name} factory" do

      # Test each factory
      it "is valid" do
        factory = FactoryGirl.build(factory_name)
        if factory.respond_to?(:valid?)
          # The lamba syntax only works with rspec 2.14 or newer; for earlier versions, 
          # you have to call #valid? before calling the matcher, otherwise the errors will be empty
          expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") }
        end
      end

      # Test each trait
      FactoryGirl.factories[factory_name].definition.defined_traits.map(&:name).each do |trait_name|
        context "with trait #{trait_name}" do
          it "is valid" do
            factory = FactoryGirl.build(factory_name, trait_name)
            if factory.respond_to?(:valid?)
              expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") }
            end
          end
        end
      end

    end
  end
end