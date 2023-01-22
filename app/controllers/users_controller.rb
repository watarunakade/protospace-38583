class UsersController < ApplicationController
  def show
    @user = current_user
    @prototypes = user.prototypes(:id)
  end
end
