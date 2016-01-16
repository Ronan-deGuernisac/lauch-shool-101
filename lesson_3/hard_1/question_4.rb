# question_4.rb


# The SecureRandom module could be used for this purpose. Note p is divided by 2
# because the length hex string produce by SecureRandom.hx(n) is twice n
# see http://ruby-doc.org/stdlib-2.2.2/libdoc/securerandom/rdoc/SecureRandom.html#method-c-hex

require 'securerandom'

def create_UUID
  parts = [8, 4, 4, 4, 12]
  len = parts.size 
  uuid = ""
  parts.each do |p|
    if len > 1
      uuid += SecureRandom.hex(p/2).to_s + "-"
    else
      uuid += SecureRandom.hex(p/2).to_s
    end
    len -= 1
  end  
  uuid
end

puts create_UUID
