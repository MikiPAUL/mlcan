# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   def create
    super do |admin|
      debugger
      if admin.persisted?
          # Generate an access token for the admin
        doorkeeper_token = Doorkeeper::AccessToken.create!(
            resource_owner_id: admin.id,
            expires_in: Doorkeeper.configuration.access_token_expires_in,
            scopes: Doorkeeper.configuration.default_scopes
          )
          # Set the access token in the response
          headers['Authorization']  = "Bearer #{doorkeeper_token.token}"
        end
      end
    end

  # DELETE /resource/sign_out
  def destroy
    super do |admin|
      @token = Doorkeeper::AccessToken.find_by(token: request.headers['Authorization'])
      @token.destroy if @token
      render json: "logout successful"
    end
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end
end
