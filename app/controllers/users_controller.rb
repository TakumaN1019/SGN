class UsersController < ApplicationController

  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [:uhoings, :uhoers] #deviseのヘルパーメソッド、デフォルトではログイン画面に遷移する

  def index
    @title = "ゴリラ一覧"
    @users = User.all.order(banana: :desc) #バナナ資産が多い順
  end

  def show
    @title = "投稿"
    @uhos = Relationship.all
  end

  def uhoings
    @title = "あなたがウホしているゴリラ一覧"
    @users = current_user.uhoings.order(banana: :desc) #バナナ資産が多い順
  end

  def uhoers
    @title = "あなたをウホしたゴリラ一覧"
    @users = current_user.uhoers.order(banana: :desc) #バナナ資産が多い順
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

end
