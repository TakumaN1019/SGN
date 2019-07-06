class RelationshipsController < ApplicationController

  before_action :block, only: [:create, :destroy]

  def create
    #if not current_user.id == 1980
    @user = User.find(params[:uhoer_id]) #ウホされる側のユーザー
    current_user.uho!(@user) #ウホ

    # 相手からすでにウホされている場合はリセットして、相手のゴリラからまたウホしてもらえるようにする。
    if @user.uhoing?(current_user)
      @user.unuho!(current_user)
      # バナナ１本追加
      if not current_user.banana.present?
        current_user.update(banana:1)
      else
        current_user.update(banana:current_user.banana+1)
        # レベルアップ機能
        if current_user.banana.to_i >= 1000
          if not current_user.level.present?
            if current_user.banana.to_i >= 10000
              current_user.update(level:10, banana:0)
            end
            if current_user.banana.to_i >= 9000
              current_user.update(level:9, banana:0)
            end
            if current_user.banana.to_i >= 8000
              current_user.update(level:8, banana:0)
            end
            if current_user.banana.to_i >= 7000
              current_user.update(level:7, banana:0)
            end
            if current_user.banana.to_i >= 6000
              current_user.update(level:6, banana:0)
            end
            if current_user.banana.to_i >= 5000
              current_user.update(level:5, banana:0)
            end
            if current_user.banana.to_i >= 4000
              current_user.update(level:4, banana:0)
            end
            if current_user.banana.to_i >= 3000
              current_user.update(level:3, banana:0)
            end
            if current_user.banana.to_i >= 2000
              current_user.update(level:2, banana:0)
            end
            if current_user.banana.to_i >= 1000
              current_user.update(level:1, banana:0)
            end 
          else
            current_user.update(level:current_user.level+1, banana:0)
          end
        end

      end
    end




    path = Rails.application.routes.recognize_path(request.referer) #直前のコントローラーとアクションのpathを取得
    if path[:controller] == "users" && path[:action] == "index"
      @title = "ゴリラ一覧"
      @users = User.all.shuffle[0..15] #ajaxの部分変更で使う
      @users_count = User.all.count
    end
    if path[:controller] == "users" && path[:action] == "ranking"
      @title = "ランキング"
      @users = User.all.order(level: :desc).take(15) #ajaxの部分変更で使う
      @users_count = @users.count
    end
    if path[:controller] == "users" && path[:action] == "uhoings"
      @title = "あなたがウホしているゴリラ一覧"
      @users = current_user.uhoings.shuffle[0..15] #ajaxの部分変更で使う
      @users_count = current_user.uhoings.count
    end
    if path[:controller] == "users" && path[:action] == "uhoers"
      @title = "あなたをウホしたゴリラ一覧"
      @users = current_user.uhoers.shuffle[0..15] #ajaxの部分変更で使う
      @users_count = current_user.uhoers.count
    end

    #end
  end

  def destroy
    #if not current_user.id == 1980
    @user = User.find(params[:uhoer_id]) #ウホされている側のユーザー
    current_user.unuho!(@user) #ウホ取り消し

    path = Rails.application.routes.recognize_path(request.referer) #直前のコントローラーとアクションのpathを取得
    if path[:controller] == "users" && path[:action] == "index"
      @title = "ゴリラ一覧"
      @users = User.all.shuffle[0..15] #ajaxの部分変更で使う
      @users_count = User.all.count
    end
    if path[:controller] == "users" && path[:action] == "ranking"
      @title = "ランキング"
      @users = User.all.order(level: :desc).take(15) #ajaxの部分変更で使う
      @users_count = @users.count
    end
    if path[:controller] == "users" && path[:action] == "uhoings"
      @title = "あなたがウホしているゴリラ一覧"
      @users = current_user.uhoings.shuffle[0..15] #ajaxの部分変更で使う
      @users_count = current_user.uhoings.count
    end
    if path[:controller] == "users" && path[:action] == "uhoers"
      @title = "あなたをウホしたゴリラ一覧"
      @users = current_user.uhoers.shuffle[0..15] #ajaxの部分変更で使う
      @users_count = current_user.uhoers.count
    end
    #end
  end


  private

    def block
      if current_user.id == 1980
      #if current_user.id == 1
        redirect_to root_path
      end
    end

end
