module LinkedInAPI
  class Client
    # https://docs.microsoft.com/en-us/linkedin/shared/integrations/people/profile-api
    module Profiles
      def me(projection = "")
        options = {}
        # Optionals
        options.merge!(projection: projection) if projection.present?

        get(Configuration::API_PREFIX + "me", options)
      end

      # https://api.linkedin.com/v2/people/
      # https://docs.microsoft.com/en-us/linkedin/shared/integrations/people/profile-api
      # GET https://api.linkedin.com/v2/people/(id:{profile ID})?projection=(id,firstName,lastName)
      def people(profile_id, projection = "")
        options = {}
        # Optionals
        options.merge!(projection: projection) if projection.present?

        get(Configuration::API_PREFIX + "people/(id:#{profile_id})", options)
      end
    end
  end
end
