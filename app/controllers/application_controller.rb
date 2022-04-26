class ApplicationController < ActionController::Base
  # 共通Helper用
  include SessionsHelper
  include ApplicationHelper

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
    return ret_cap['check_upload_capacity'] == nil ? 0 : ret_cap['check_upload_capacity']
  end

  # 容量の単位変換
  def exchange_capacity_view(total_cap)
    case total_cap
      when nil
        return {num: 0, unit: 'バイト[未使用]'}
      when 0..(1024**1-1)
        return {num: (total_cap).to_s, unit: 'B'}
      when 1024**1..(1024**2-1)
        return {num: (total_cap/1024**1.to_f).round(2).to_s, unit: 'KB'}
      when 1024**2..(1024**3-1)
        return {num: (total_cap/1024**2.to_f).round(2).to_s, unit: 'MB'}
      when 1024**3..nil
        return {num: (total_cap/1024**2.to_f).round(2).to_s, unit: 'GB'}
      else
        return {num: '???', unit: '???'}
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

    # アカウントプラン毎の判定
    case get_user_plan
      # 管理者モード
      when 0
        ret['USER_LIMIT_CAPACITY'] = 99999
        ret['USER_LIMIT_REGIST_RECIPE'] = 99999
      # フリープラン
      when 1
        ret['USER_LIMIT_CAPACITY'] = ENV['USER_FREE_LIMIT_CAPACITY'].to_i
        ret['USER_LIMIT_REGIST_RECIPE'] = ENV['USER_FREE_LIMIT_REGIST_RECIPE'].to_i
      # 有料プラン
      when 2
        ret['USER_LIMIT_CAPACITY'] = ENV['USER_PAID_LIMIT_CAPACITY'].to_i
        ret['USER_LIMIT_REGIST_RECIPE'] = ENV['USER_PAID_LIMIT_REGIST_RECIPE'].to_i
      else
    end

    return ret
  end
end
