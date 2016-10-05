class Generator < ActiveRecord::Base
  @secure_base = 'AEIOUaeiouBCDFGHJKLMNPQRSTVWXYZbcdfghjklmnpqrstvwxyz0123456789!@#$%^&*()'.chars.to_a

  def self.generate(word, salt)
    return nil if word.nil? || salt.nil?
    key = SCrypt::Engine.scrypt(word, salt, 2**15, 8, 2, 64)
    encode = Digest::SHA256.hexdigest(key)
    password = Bases.val(encode).in_base(16).to_base(@secure_base)
    password[0...10]
  end
end
