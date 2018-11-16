module Api
  module V2
    class UsersController < ApplicationController
      before_action :set_user, only: [:show, :update, :destroy]

      # GET /users
      def index
        @users = User.all

        render json: @users
      end

      # GET /users/1
      def show
        render json: @user
      end

      # POST /users
      def create
        @user = User.new(user_params)
        puts @user.inspect

        if @user.save
          puts '@user was saved successfully'
          payload = { user_id: @user.id }
          session = JWTSessions::Session.new(payload: payload, refresh_by_access_allowed: true)
          tokens = session.login

          response.set_cookie(JWTSessions.access_cookie,
                              value: tokens[:access],
                              httponly: true,
                              secure: Rails.env.production?)

          puts @user.inspect
          # puts user_url(@user)
          render json: { csrf: tokens[:csrf] }
        else
          render json: @user.errors.full_messages, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /users/1
      def update
        if @user.update(user_params)
          render json: @user
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      # DELETE /users/1
      def destroy
        @user.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_user
          @user = User.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def user_params
          params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation)
        end
    end
  end
end