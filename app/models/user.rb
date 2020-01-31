class User < ApplicationRecord
  has_many :microposts, dependent: :destroy #If the user is deleted, the posts are also deleted.
  # fllowing function ===================================================
  #followed
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed # how you assign a nameto a relationship
  # followers
  has_many :reverse_relationships, foreign_key: "followed_id", dependent: :destroy, class_name: "Relationship"
  has_many :followers, through: :reverse_relationships, source: :follower # this is where you see your followers
  #======================================================================

  validates :name, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true,
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  
  has_secure_password
  validates :password, length: { minimum: 6 }


  # making a function inside model means we are going to talkto the detabase
  def feed
    #sihntaro is ID #1
    # Micropost.where("user_id = id", #1)
    # meaning all of_shintaro7s posts about sush will show up
    # Micropost.where("user_id = ?", id)
    Micropost.from_users_followed_by(self) #this shows pasts from other users you followed
  end

  # this is where we make our working fllow methods
  # Follows a user
  def follow(other_user)
    relationships.create!(followed_id: other_user.id) # whoever we follow, we get their ID
    # current user is FLLOWER and the other user is FOLLOWED
  end

  # Unfollows a user 
  def unfollow(other_user)
    relationships.find_by(followed_id: other_user.id).destroy
  end

  #Returns true if the current user is folloeing the other user
  # this one is the same as logged_in? function
  def following?(other_user)
    relationships.find_by(followed_id: other_user.id)
  end
end
