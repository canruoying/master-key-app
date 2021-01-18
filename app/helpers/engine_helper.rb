module EngineHelper
    Secure_base = 'AEIOUaeiouBCDFGHJKLMNPQRSTVWXYZbcdfghjklmnpqrstvwxyz0123456789!#$%+/=@~'.chars.to_a
    Upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.chars.to_a
    Lower = 'abcdefghijklmnopqrstuvwxyz'.chars.to_a
    Numbers = '0123456789'.chars.to_a
    Spechars = '!#$%+/=@~'.chars.to_a

    def generate(word, salt, template_set)
        return nil if word.nil? || salt.nil? || template_set.nil?
        key = SCrypt::Engine.scrypt(word.encode('UTF-8'), salt.encode('UTF-8'), 2**15, 8, 2, 64)
        code = Digest::SHA256.hexdigest(key)
        code = Bases.val(code).in_base(16).to_base(10).to_i
        encode_password(code / template_set.length, template_set[code % template_set.length])
    end

    def encode_password(code, template)
        password = ''
        template.each_char do |i|
          password, code = case i
          when 'a'
            encode_letter(password, code, Lower)
          when 'A'
            encode_letter(password, code, Upper)
          when 'n'
            encode_letter(password, code, Numbers)
          when 's'
            encode_letter(password, code, Spechars)
          when 'x'
            encode_letter(password, code, Secure_base)
          else
            return "Error due to template character " + i + "!"
          end
        end
        password
    end

    def encode_letter(password, code, char_set)
        length = char_set.length
        password += char_set[code % length]
        code /= length
        return password, code
    end
end