class RelationshipsController < ApplicationController

   def create
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
      end
    end

    path = Rails.application.routes.recognize_path(request.referer) #直前のコントローラーとアクションのpathを取得
    if path[:controller] == "users" && path[:action] == "index"
      @title = "ゴリラ一覧"
      @users = User.all #ajaxの部分変更で使う
    end
    if path[:controller] == "users" && path[:action] == "uhoings"
      @title = "あなたがウホしているゴリラ一覧"
      @users = current_user.uhoings #ajaxの部分変更で使う
    end
    if path[:controller] == "users" && path[:action] == "uhoers"
      @title = "あなたをウホしたゴリラ一覧"
      @users = current_user.uhoers #ajaxの部分変更で使う
    end
  end

  def destroy
    @user = User.find(params[:uhoer_id]) #ウホされている側のユーザー
    current_user.unuho!(@user) #ウホ取り消し

    path = Rails.application.routes.recognize_path(request.referer) #直前のコントローラーとアクションのpathを取得
    if path[:controller] == "users" && path[:action] == "index"
      @title = "ゴリラ一覧"
      @users = User.all #ajaxの部分変更で使う
    end
    if path[:controller] == "users" && path[:action] == "uhoings"
      @title = "あなたがウホしているゴリラ一覧"
      @users = current_user.uhoings #ajaxの部分変更で使う
    end
    if path[:controller] == "users" && path[:action] == "uhoers"
      @title = "あなたをウホしたゴリラ一覧"
      @users = current_user.uhoers #ajaxの部分変更で使う
    end
  end

end
