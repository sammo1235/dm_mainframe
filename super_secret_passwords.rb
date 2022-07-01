# this needs to be completely inacessible to any users on our website!

module SuperSecretPasswords
  module Decryption
    module TopSecret
      class UserNotCreatedError < StandardError; end
      class << self
        private

        def decrypt_password(user)
          return UserNotCreatedError unless user.instance_variables.include?(:@encrypted_password)
          user.send(:decrypt_hex, Base64.decode64(user.send(:encrypted_password)))
        end
      end
    end
  end
end
