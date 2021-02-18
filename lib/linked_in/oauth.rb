module LinkedInAPI
  # Defines HTTP request methods
  module OAuth
    # Return an access token from authorization
    # https://docs.microsoft.com/en-us/linkedin/shared/authentication/client-credentials-flow?context=linkedin/context
    def refresh_access_token(options={})
      options[:grant_type] ||= "refresh_token"
      params = refresh_token_params.merge(options)
      post("oauth/" + Configuration::API_PREFIX + "accessToken", params, signature=false, raw=false, no_response_wrapper=true)
    end

    private

    def refresh_token_params
      {
        grant_type: "refresh_token",
        refresh_token: refresh_token,
        client_id: client_id,
        client_secret: client_secret
      }
    end
  end
end
