require "rails_helper"

RSpec.describe "Api::V1::Transactions", type: :request do
  describe "POST /create" do
    let(:transaction) { FactoryBot.build(:transaction) }

    context "with valid parameters" do
      let(:transaction_params) do
        {
          transaction_id: transaction.transaction_id,
          merchant_id: transaction.merchant_id,
          user_id: transaction.user_id,
          card_number: transaction.card_number,
          transaction_date: transaction.transaction_date,
          transaction_amount: transaction.transaction_amount,
          device_id: transaction.device_id
        }
      end

      before do
        post "/api/v1/transactions",
          params: transaction_params
      end

      it "returns a created status" do
        puts response.status
        expect(response).to have_http_status(:created)
      end
    end
  end
end
