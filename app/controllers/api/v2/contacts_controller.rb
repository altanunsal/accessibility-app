module Api
  module V2
    class ContactsController < ApplicationController
      # before_action :authorize_access_request!
      before_action :set_contact, only: [:show, :update, :destroy]

      # GET /contacts
      def index
        @user = User.find(params[:user_id])
        @contacts = @user.contacts

        render json: @contacts
      end

      # GET /contacts/1
      def show
        @user = User.find(params[:user_id])
        @contacts = @user.contacts.find(params[:id])
        render json: @contact
      end

      # POST /contacts
      def create
        @contact = Contact.new(contact_params)

        if @contact.save
          render json: @contact, status: :created, location: api_v2_user_contacts_url(@contact)
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /contacts/1
      def update
        if @contact.update(contact_params)
          render json: @contact
        else
          render json: @contact.errors, status: :unprocessable_entity
        end
      end

      # DELETE /contacts/1
      def destroy
        @contact.destroy
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_contact
          @contact = Contact.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def contact_params
          params.require(:contact).permit(:user_id, :first_name, :last_name, :email, :phone_number, :emergency)
        end
    end
  end
end
