class RecipientsController < ApplicationController

    def index 
        recipients = Recipient.all
        render json: recipients.to_json(
            :include => { 
                :recipient_items => {
                    :except => [:created_at, :updated_at]
                }
            }, 
            :except => [:created_at, :updated_at]
        )
    end

    def create
        recipient = Recipient.create(recipient_params)
        render json: recipient.to_json(
            :include => { 
                :recipient_items => {
                    :except => [:created_at, :updated_at]
                }
            }, 
            :except => [:created_at, :updated_at]
        )
    end

    def destroy
        recipient = Recipient.find(params[:id])
        recipient.delete
    end

    private
    def recipient_params
        params.require(:recipient).permit(:name, :budget)
    end
end
