require "omniauth-oauth2"

class OmniAuth::Strategies::Medium < OmniAuth::Strategies::OAuth2
  option :client_options,
    site: "https://api.medium.com/v1",
    authorize_url: "https://medium.com/m/oauth/authorize",
    token_url: "https://api.medium.com/v1/tokens"

  option :authorize_options, [:scope]
  option :scope, [:basic_profile, :publish_post]

  def authorize_params
    params = super

    # allow user to pass array of scopes instead of comma-seperated string
    # allow user to pass permissions as underscored symbols instead of
    #   camel-case strings
    params[:scope] = Array(params[:scope]).map do |scope|
      next scope unless scope.is_a? Symbol
      scope.to_s.gsub(/_./) { |m| m[1].upcase }
    end.join(?,)

    params
  end

  info do
    @info ||= access_token.get("me").parsed["data"]
  end

  uid do
    info["id"]
  end
end
