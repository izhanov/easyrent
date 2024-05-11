# frozen_string_literal: true

module Operations
  module Office
    module Documents
      module ContractContext
        class Create < Base
          def call(contract, responsible)
            document = yield create_contract_document(contract, responsible)
            Success(document)
          end

          private

          def create_contract_document(contract, responsible)
            document_template = responsible.document_templates.current_for("contract").last
            car_park = contract.booking.car.owner
            client = contract.booking.client
            contract_content = prepare_contract_content(document_template, car_park, contract, client)

            word_template = prepare_word_template

            pdf = Htmltoword::Document.create(
              word_template.render("content" => contract_content)
            )

            pdf_tempfile = prepare_word_tempfile(pdf, contract)

            document = contract.documents.create!(
              document_template_id: document_template.id,
              file: pdf_tempfile
            )
            Success(document)
          end

          def prepare_contract_content(document_template, car_park, contract, client)
            contract_template = Liquid::Template.parse(document_template.content)
            contract_template.render(contract_params(car_park, contract, client))
          end

          def contract_params(car_park, contract, client)
            booking = contract.booking
            car = contract.booking.car
            offer = booking.offer

            {
              "contract" => {
                "number" => contract.number,
                "date" => contract.date,
                "rental_amount" => contract.cost_per_day * contract.rental_days,
                "total_amount" => contract.total_amount,
                "pledge_amount" => contract.pledge_amount,
                "prepayment_amount" => contract.prepayment_amount,
                "services_total_amount" => contract.services_total_amount,
                "permissible_mileage_limit" => contract.permissible_mileage_limit,
                "cost_per_day" => contract.cost_per_day,
                "rental_days" => contract.rental_days,
                "pledge_return_method" => contract.pledge_return_method,
                "pledge_return_date" => contract.pledge_return_date,
                "pledge_return_requisites" => contract.pledge_return_requisites,
                "services" => collect_services(booking),
                "manager" => ""
              },
              "client" => {
                "full_name" => client.full_name,
                "identification_number" => client.identification_number,
                "passport_number" => client.passport_number,
                "phone" => client.phone,
                "email" => client.email,
                "driving_license" => client.driving_license,
                "driving_license_issued_date" => client.driving_license_issued_date.strftime("%d.%m.%Y")
              },
              "car_park" => {
                "title" => car_park.title,
                "business_id_number" => car_park.business_id_number,
                "address" => car_park.llp? ? car_park.legal_address : car_park.residence_address,
                "phone" => car_park.contact_phone,
                "service_phone" => car_park.service_phone,
                "iban" => car_park.bank_account_number,
                "bik" => car_park.bank_code,
                "kbe" => car_park.benificiary_code,
                "email" => car_park.email,
                "bank_name" => car_park.bank_name
              },
              "offer" => {
                "title" => offer.title,
                "price" => contract.cost_per_day
              },
              "booking" => {
                "starts_at" => booking.starts_at.strftime("%d.%m.%Y %H:%M"),
                "ends_at" => booking.ends_at.strftime("%d.%m.%Y %H:%M"),
                "pickup_location" => booking.pickup_location,
                "drop_off_location" => booking.drop_off_location,
                "vip_service" => {
                  "title" => booking_vip_service(booking)[:title],
                  "price" => booking_vip_service(booking)[:price]
                },
                "prepayment_method" => booking.prepayment_method,
                "prepayment_amount" => booking.prepayment_amount,
                "payment_method" => booking.payment_method,
                "payment_amount" => contract.total_amount,
                "remain_payment_amount" => contract.total_amount - booking.prepayment_amount
              },
              "car" => {
                "title" => car.mark_title,
                "vin_code" => car.vin_code,
                "plate_number" => car.plate_number,
                "year" => car.year,
                "over_mileage_price" => car.over_mileage_price,
                "technical_certificate_number" => car.technical_certificate_number
              }
            }
          end

          def prepare_word_template
            html_string = ActionController::Base.new.render_to_string(
              template: "office/document_templates/word",
              layout: false
            )
            Liquid::Template.parse(html_string)
          end

          def prepare_word_tempfile(pdf, contract)
            file = Tempfile.new(["contract", ".docx"]).tap do |tempfile|
              tempfile.binmode
              tempfile.write(pdf)
              tempfile.rewind
            end

            ActionDispatch::Http::UploadedFile.new(
              {
                tempfile: file,
                filename: "Договор#{contract.number}.docx"
              }
            )
          end
        end
      end
    end
  end
end
