module Api
  module V1
    class JoinEventsController < ApplicationController
      def create
        event = Event.find_by(id: join_event_params[:event_id])
        if event.participant_number > event.join_users.count
          join_event = current_user.join_events.create(event_id: join_event_params[:event_id])
          render json: join_event.as_json(include: [:user, { event: { include: [{ post: { include: [:tags] } }, :join_users] } }]), status: :created
        else
          render json: join_event.errors, status: :unprocessable_entity
        end
      end

      def destroy
        join_event = JoinEvent.find_by(event_id: params[:id], user_id: current_user.id)
        if join_event.destroy
          render json: { message: '参加をキャンセルしました', status: :ok}
        else
          render json: join_event.errors, status: :unprocessable_entity
        end
      end

      private

      def join_event_params
        params.require(:join_event).permit(:user_id, :event_id)
      end
    end
  end
end
