class ApplicationController < ActionController::Base
	include SessionsHelper
	def authorize
      unless user_signed_in?
        redirect_to root_url
      end
   end
end
