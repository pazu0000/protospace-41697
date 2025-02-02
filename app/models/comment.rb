class Comment < ApplicationRecord
  belongs_to :prototype  # prototypeテーブルとのアソシエーション
  belongs_to :user       # useテーブルとのアソシエーション

  validates :text, presence: true

end
