# frozen_string_literal: true

module Office
  class ClientsController < BaseController
    def index
    end

    def new
      @client = Client.new
    end

    def create
      operation = Operations::Office::Clients::Accession.new
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
      result = operation.call(@car_park, client_params.to_h)

      case result
      in Success[client]
        @client = client
        respond_to do |format|
          format.html
          format.turbo_stream
        end
      in Failure[error_code, errors]
        @client = Client.new(client_params)
        @errors = errors
        flash.now[:alert] = "error"
        render :new
      end
    end

    def show
    end

    def edit
    end

    def update
    end

    def destroy
    end

    def search
      @q = Client.typesense(
        q: params[:q],
        query_by: "surname, name, identification_number, full_name_of_the_head, phone",
        infix: "off, always, always, always, always",
        query_by_weights: "5, 3, 4, 1, 1"
      )
      @car_park = current_office_user.car_parks.find(params[:car_park_id])
      @clients = @car_park.clients.where(id: @q.pluck(:id))
      render partial: "office/clients/search", locals: {clients: @clients}
    end

    private

    def client_params
      params.require(:client).permit(
        :name,
        :surname,
        :identification_number,
        :phone,
        :kind,
        :citizen,
        :driving_license,
        :driving_license_issued_date,
        :email,
        :patronymic,
        :passport_number,
        :full_name_of_the_head,
        :signed_on_basis,
        :legal_address,
        :bank_account_number,
        :bank_code,
        :car_park_id
      )
    end
  end
end
