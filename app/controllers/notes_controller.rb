class NotesController < ApplicationController

    def index
        notes = Note.where(recipient_id: params[:recipient_id])
        render json: notes, except: [:updated_at]
    end

    def create
        note = Note.create(note_params)
        render json: note, except: [:updated_at]
    end

    def destroy
        note = Note.find(params[:id])
        note.destroy
    end

    private
    def note_params
        params.require(:note).permit(:recipient_id, :message)
    end
end
