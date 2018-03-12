class User < ApplicationRecord
  self.primary_key = 'uid'
  devise :omniauthable, omniauth_providers: [:saml]
  has_many :expectations
  has_many :enrolled_courses, through: :expectations
  has_many :teachings
  has_many :taught_courses, through: :teachings
  has_many :checkins
  has_many :attendances, through: :checkins
  alias_attribute :id, :uid

  def display_name
    name.empty? ? uid : "#{name} (#{uid})"
  end

  class << self
    def from_saml(auth_hash)
      @data = auth_hash['extra']['raw_info'].attributes
      puts @data
      uid = parse('urn:oid:0.9.2342.19200300.100.1.1').downcase
      user = find_or_create_by(uid: uid)
      getname
      user.name = "#{@first_name} #{@last_name}"
      user.preferred = @preferred
      user.save
      user
    end

    def getname
      @preferred = true
      @first_name = parse('urn:mace:dir:attribute-def:displayGivenName')
      @last_name = parse('urn:mace:dir:attribute-def:displaySN')
      rescue
        @preferred = false
        @first_name = parse('urn:oid:2.5.4.42')
        @last_name = parse('urn:oid:2.5.4.4')
    end

    def parse(key)
      @data[key][0]
    end
  end
end
