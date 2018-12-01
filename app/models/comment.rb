class Comment < ApplicationRecord

    belongs_to :movie

    def get_create_user
        User.find(self.user_id).name
    end

end
