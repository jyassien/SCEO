class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
    has_many :events, dependent: :destroy
    has_many :flags, dependent: :destroy

    # validates :email, presence: true, uniqueness: { case_sensitive: false }
    # validate :email_format  # Required Format
    before_validation :downcase_email, if: :email_changed?


    private

    # Ensure the email is a school email
    def email_format
        unless email =~ /\A[\w+\-.]+@[a-zA-Z\d\-]+\.edu\z/i
            errors.add(:email, "must be a valid .edu school email address")
        end
    end
    
    def downcase_email
        self.email = email.downcase if email.present?
    end

end
