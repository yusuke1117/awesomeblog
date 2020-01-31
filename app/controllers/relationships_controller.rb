class RelationshipsController < ApplicationController
    before_action :only_loggedin_users

    # no reload!!!!
    #Follow button
    def create # you can now follow users
        @user = User.find(params[:followed_id])
        current_user.follow(@user)
        #javascript
        respond_to do |format|
            format.html { redirect_to @user } # it will always load to show page
            format.js
        end
    end
    #unfollow button
    def destroy
        @user = Relationship.find(params[:id]).followed # A user cannot unfollow someone if they didont follow yet
        current_user.unfollow(@user)
        respond_to do |format|
            format.html{ redirect_to @user }
            format.js
        end
    end
end
