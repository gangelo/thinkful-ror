
module RSpecHelpers
  module Methods
    def force_current_user(current_user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(current_user)
    end

    def force_current_user?
      allow_any_instance_of(ApplicationController).to receive(:current_user?).and_return(User)
    end
  end
end

RSpec.configure do |config|
  config.include RSpecHelpers::Methods
end