class TokenGenerator
    crypt = ActiveSupport::MessageEncryptor.new(Rails.application.credentials.secret_key_base)
    encrypted_data = crypt.encrypt_and_sign('my confidental data')
    decrypted_back = crypt.decrypt_and_verify(encrypted_data)
end