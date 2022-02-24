class ApplicationController < ActionController::Base
  # 共通Helper用
  include SessionsHelper

  private
  # ログイン済みユーザーかどうか確認
  def logged_in_user
    unless logged_in?
      redirect_to login_url
    end
  end

  # ログイン済みユーザーの場合、アクセス不可ページの処理
  def logged_in_user_deny
    if logged_in?
      redirect_to recipes_path
    end
  end

  # ユーザーアカウントの使用容量
  def user_total_capacity
    ret_cap = ActiveRecord::Base.connection.select_one("select check_upload_capacity(#{current_user.id});")
    return ret_cap['check_upload_capacity']
  end

  # 容量の単位変換
  def exchange_capacity_view(total_cap)
    case total_cap
    when nil
      return '0バイト[未使用]'
    when 0..(1024**1-1)
      return (total_cap).to_s + 'B'
    when 1024**1..(1024**2-1)
      return (total_cap/1024**1.to_f).round(2).to_s + 'KB'
    when 1024**2..(1024**3-1)
      return (total_cap/1024**2.to_f).round(2).to_s + 'MB'
    when 1024**3..nil
      return (total_cap/1024**2.to_f).round(2).to_s + 'GB'
    else
      return '???'
    end
  end

  # ユーザーアカウントの登録レシピ数
  def user_regist_recipe
    ret = ActiveRecord::Base.connection.select_one("select check_regist_recipe(#{current_user.id});")
    ret['check_regist_recipe'] == nil ? 0 : ret['check_regist_recipe']
  end

  # ユーザーアカウントの制限情報
  def user_limit_info
    ret = {}
    ret['USER_LIMIT_CAPACITY'] = ENV['USER_FREE_LIMIT_CAPACITY'].to_i
    ret['USER_LIMIT_REGIST_RECIPE'] = ENV['USER_FREE_LIMIT_REGIST_RECIPE'].to_i
    #ret['USER_LIMIT_CAPACITY'] = ENV['USER_PAID_LIMIT_CAPACITY'].to_i
    #ret['USER_LIMIT_REGIST_RECIPE'] = ENV['USER_PAID_LIMIT_REGIST_RECIPE'].to_i
    return ret
  end
end
