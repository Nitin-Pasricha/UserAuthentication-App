class User < ApplicationRecord
    attr_accessor :pswd
    has_one_attached :profile_pic
    validates :first_name, presence: true
    validates :email, presence: true, uniqueness: true, format: { with: /\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+/ }
    validates :pswd, length: {in: 6..20 },  confirmation: true, on: :create
    validates :pswd_confirmation, presence: true, on: :create

    before_save :encrypt_password
    
    def self.authenticate(email, pwd)
        user = find_by_email(email)
        return user if user && user.check_password(pwd)
    end

    def check_password(pwd)
        encrypt(pwd) == self.password
    end

    protected

        def encrypt_password
            return if pswd.blank?
            self.password = encrypt(pswd)
            puts self.password
        end

        def encrypt(string)
            Digest::SHA1.hexdigest(string)
        end
end
