class UsersController < ApplicationController

  before_action :set_user, only: [:show]
  before_action :authenticate_user!, only: [:uhoings, :uhoers] #deviseのヘルパーメソッド、デフォルトではログイン画面に遷移する

  def index
    @title = "ゴリラ一覧"
    @users = User.all.order(banana: :desc).shuffle[0..15] #バナナ資産が多い順
    @users_count = User.all.count
  end

  def ranking
    @title = "ランキング"
    @users = User.all.order(level: :desc).take(15)
    #@users = @users.order(banana: :desc).order(level: :desc).take(10)
    @users_count = @users.count
  end

  def show
    @title = "投稿"
    @uhos = Relationship.all
  end

  def uhoings
    @title = "あなたがウホしているゴリラ一覧"
    @users = current_user.uhoings.order(banana: :desc).shuffle[0..15] #バナナ資産が多い順
    @users_count = current_user.uhoings.count
  end

  def uhoers
    @title = "あなたをウホしたゴリラ一覧"
    @users = current_user.uhoers.order(banana: :desc).shuffle[0..15] #バナナ資産が多い順
    @users_count = current_user.uhoers.count
  end

  private
    def set_user
      @user = User.find_by(id: params[:id])
    end

end
