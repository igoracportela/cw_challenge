module Api
  module V1
    class TransactionsController < ActionController::Base
      def create
        @transaction = Transaction.create(transaction_params)

        if @transaction.valid?
          render json: @transaction, status: :created
        else
          render json: @transaction.errors, status: :unprocessable_entity
        end
      end

      private

      def transaction_params
        params.require(:transaction).permit(
          :transaction_id,
          :merchant_id,
          :user_id,
          :card_number,
          :transaction_date,
          :transaction_amount,
          :device_id
        )
      end
    end
  end
end
