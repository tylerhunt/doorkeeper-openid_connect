module Doorkeeper
  module OpenidConnect
    module Claims
      class Claim
        attr_accessor :name, :scope

        # http://openid.net/specs/openid-connect-core-1_0.html#StandardClaims
        # http://openid.net/specs/openid-connect-core-1_0.html#ScopeClaims
        STANDARD_CLAIMS = {
          profile: %w[
            name family_name given_name middle_name nickname preferred_username
            profile picture website gender birthdate zoneinfo locale updated_at
          ],
          email: %w[ email email_verified ],
          address: %w[ address ],
          phone: %w[ phone_number phone_number_verified ],
        }

        def initialize(options = {})
          @name = options[:name]
          @scope = options[:scope]

          # use default scope for Standard Claims
          @scope ||= STANDARD_CLAIMS.find do |_scope, claims|
            claims.include? @name
          end.try(:first)

          # use profile scope as default fallback
          @scope ||= :profile
        end
      end
    end
  end
end
