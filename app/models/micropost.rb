class Micropost < ApplicationRecord
    belongs_to :user
    default_scope -> { order('created_at DESC')} # latest post is the first post you see
    validates :content, presence: true, length: { maximum: 140 } # limit to 140 characters only
    validates :user_id, presence: true

    # returns microposts from the users beiing followed by the current user
    def self.from_users_followed_by(user)
        followed_user_ids = "SELECT followed_id FROM relationships
                            WHERE follower_id = :user_id"
        where("user_id IN (#{followed_user_ids}) OR user_id = :user_id",
                    user_id: user.id)
    end
end
