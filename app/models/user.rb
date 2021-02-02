class User < ApplicationRecord

    include Commentable

    attr_reader :password

    validates :username, :session_token, presence: true
    validates :username, uniqueness: true
    validates :password_digest, presence: {message: "Password can\'t be blank"}
    validates :password, length: {minimum: 6, allow_nil: true}
    validates :cheers_to_give_counter, numericality: { less_than_or_equal_to: 12, greater_than: 0}

    has_many :goals, dependent: :destroy
    has_many :cheers, dependent: :destroy
    has_many :given_comments, class_name: :Comment, dependent: :destroy

    after_initialize :ensure_session_token 

    def self.find_by_credentials(username, password)
        user = User.find_by(username: username)

        return nil if user.nil?

        user.is_password?(password) ? user : nil
    end

    def is_password?(password)
        BCrypt::Password.new(self.password_digest).is_password?(password)
    end

    def self.generate_token
        SecureRandom::urlsafe_base64
    end

    def ensure_session_token
        self.session_token ||= self.class.generate_token
    end

    def reset_session_token!
        self.session_token = self.class.generate_token
        self.save!
    end

    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
    end

end
