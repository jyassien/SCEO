class User < ApplicationRecord
    has_secure_password
    has_many :events, foreign_key: 'creator', dependent: :destroy
    has_many :flags, foreign_key: 'flagged_by', dependent: :destroy
  end
  