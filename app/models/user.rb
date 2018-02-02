class User < ApplicationRecord
    devise :omniauthable, omniauth_providers: [:saml]

    class << self
        def from_saml(auth_hash)
            @data = auth_hash['extra']['raw_info'].attributes
            uid = parse('urn:oid:0.9.2342.19200300.100.1.1')
            user = where(uid: uid, provider: auth_hash['provider']).first_or_initialize
            first_name = parse('urn:oid:2.5.4.42')
            last_name = parse('urn:oid:2.5.4.4')
            user.name = "#{user.first_name} #{user.last_name}"
            user.save!
            user
        end

        def parse key
            @data[key][0]
        end
    end
end
