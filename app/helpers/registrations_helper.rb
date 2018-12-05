module RegistrationsHelper
    def devise_error_messages!
        flash[:error] = resource.errors.full_messages.first
    end
    def bootstrap_devise_error_messages!
        flash[:error] = resource.errors.full_messages.first
    end
end
