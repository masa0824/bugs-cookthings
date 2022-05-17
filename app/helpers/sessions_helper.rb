module SessionsHelper
  # ログインチェック  
  def log_in(user)
    session[:user_id] = user.id
  end

  # 現在ログイン中のユーザーを返す (いる場合)
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  #受け取ったユーザーがログイン中のユーザーと一致すればtrueを返す
  def current_user?(user)
    user == current_user
  end

  # ユーザーがログインしていればtrue、その他ならfalseを返す
  def logged_in?
    !current_user.nil?
  end

  # 現在のユーザーをログアウトする
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # 新着のお知らせ(ニュース)チェック
  def check_latest_news
    User.find(current_user.id).check_latest_news
  end

  # お知らせ(ニュース)の一覧取得
  def news_list
    News.all.order(id: 'DESC').page(params[:page]).per(5)
  end
end
