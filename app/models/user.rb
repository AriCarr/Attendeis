class User < ApplicationRecord
    self.primary_key = 'uid'
    devise :omniauthable, omniauth_providers: [:saml]
    has_many :expectations
    has_many :courses, through: :expectations
    alias_attribute :id, :uid


    class << self
        def from_saml(auth_hash)
            @data = auth_hash['extra']['raw_info'].attributes
            uid = parse('urn:oid:0.9.2342.19200300.100.1.1').downcase
            puts "UID = #{uid}"
            first_name = parse('urn:oid:2.5.4.42')
            last_name = parse('urn:oid:2.5.4.4')
            name = "#{user.first_name} #{user.last_name}"
            user.find_or_create_by(uid: uid)
            user.name = name
            user.save
            user
        end

        def parse key
            @data[key][0]
        end
    end
end
