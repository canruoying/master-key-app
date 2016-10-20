class Generator < ActiveRecord::Base
  @secure_base = 'AEIOUaeiouBCDFGHJKLMNPQRSTVWXYZbcdfghjklmnpqrstvwxyz0123456789!#$%+/=@~'.chars.to_a
  @upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.chars.to_a
  @lower = 'abcdefghijklmnopqrstuvwxyz'.chars.to_a
  @numbers = '0123456789'.chars.to_a
  @spechars = '!#$%+/=@~'.chars.to_a

  def self.generate(word, salt, template_set)
    return nil if word.nil? || salt.nil? || template_set.nil?
    key = SCrypt::Engine.scrypt(word.encode('UTF-8'), salt.encode('UTF-8'), 2**15, 8, 2, 64)
    code = Digest::SHA256.hexdigest(key)
    code = Bases.val(code).in_base(16).to_base(10).to_i
    encode_password(code / template_set.length, template_set[code % template_set.length])
  end

  def self.encode_password(code, template)
    password = ''
    template.each_char do |i|
      password, code = case i
      when 'a'
        encode_letter(password, code, @lower)
      when 'A'
        encode_letter(password, code, @upper)
      when 'n'
        encode_letter(password, code, @numbers)
      when 's'
        encode_letter(password, code, @spechars)
      when 'x'
        encode_letter(password, code, @secure_base)
      else
        return "Error due to template character " + i + "!"
      end
    end
    password
  end

  def self.encode_letter(password, code, char_set)
    length = char_set.length
    password += char_set[code % length]
    code /= length
    return password, code
  end
end
