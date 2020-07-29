class Calender < ApplicationRecord
    #カレンダーからレシピを取得
    has_many :recipe,-> { order("created_at ASC") }, dependent: :destroy   #ASC小順にデータ取得
end
