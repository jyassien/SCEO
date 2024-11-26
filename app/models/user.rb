class User < ApplicationRecord
    has_many :events, dependent: :destroy
    has_many :events, dependent: :destroy

    validates :email, presence: true, uniqueness: { case_sensitive: false }
    validate :email_format  # Required Format
    before_save :downcase_email

    private

    # Ensure the email is a school email
    def email_format
        unless email =~ /\A[\w+\-.]+@[\w\-]+\.\w*\.edu\z/i
          errors.add(:email, "must be an @.edu email address")
        end
    end
    
    def downcase_email
        self.email = email.downcase if email.present?
      end

end
