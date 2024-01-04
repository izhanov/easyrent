# frozen_string_literal: true

module Operations
  module Office
    module Users
      class ChangePassword < Base
        def call(user_id, new_password, new_password_confirmation)
          user = yield find_user(user_id)
          encrypted_password = yield check_password_equality(new_password, new_password_confirmation)
          yield not_equal_to_temp_password?(user, encrypted_password)
          yield commit(user, new_password, new_password_confirmation)
          Success(user)
        end

        private

        def find_user(user_id)
          user = User.find(user_id)
          Success(user)
        rescue ActiveRecord::RecordNotFound
          Failure[:user_not_found, {}]
        end

        def check_password_equality(new_password, new_password_confirmation)
          encrypted_password = BCrypt::Password.create(new_password)

          if BCrypt::Password.new(encrypted_password) == new_password_confirmation
            Success(encrypted_password)
          else
            Failure[:password_and_password_confirmation_are_not_equal, {}]
          end
        end

        def not_equal_to_temp_password?(user, encrypted_password)
          if BCrypt::Password.new(encrypted_password) != user.temp_password
            Success(true)
          else
            Failure[:new_password_can_t_be_equal_to_temp_password, {}]
          end
        end

        def commit(user, new_password, new_password_confirmation)
          user.password = new_password
          user.password_confirmation = new_password_confirmation
          user.temp_password = nil
          user.save!
          Success(user)
        rescue ActiveRecord::RecordInvalid => e
          Failure[:record_invalid, e.record.errors.messages]
        end
      end
    end
  end
end
