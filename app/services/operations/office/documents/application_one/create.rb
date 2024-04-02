# frozen_string_literal: true

module Operations
  module Office
    module Documents
      module ApplicationOne
        class Create < Base
          def call(contract, responsible)
            create_application_one_document(contract, responsible)
          end

          private

          def create_application_one_document(contract, responsible)
            # it's a not a good idea to use not relevant document template to create a document
            # must be a document template for application one
            # or we should use a document template for contract ??
            document_template = responsible.document_templates.current_for("contract").last

            application_one_content = prepare_application_one_content(contract)
            pdf = WickedPdf.new.pdf_from_string(application_one_content)
            pdf_tempfile = prepare_pdf_tempfile(pdf, contract)
            contract.documents.create!(
              document_template_id: document_template.id,
              file: ActionDispatch::Http::UploadedFile.new(
                tempfile: pdf_tempfile,
                filename: "application_one_#{contract.number}.pdf"
              )
            )
          end

          def prepare_application_one_content(contract)
            application_one_template = ActionController::Base.new.render_to_string(
              template: "office/document_templates/application_one",
              layout: false
            )

            application_one_template = Liquid::Template.parse(application_one_template)
            application_one_template.render(application_one_params(contract))
          end

          def application_one_params(contract)
            booking = contract.booking
            car = contract.booking.car
            offer = booking.offer
            client = booking.client

            {
              "car_park" => {
                "title" => car.owner.title
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
              "contract" => {
                "number" => contract.number,
                "date" => contract.date.strftime("%d.%m.%Y г."),
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

          def collect_services(booking)
            start_number = 8
            booking.services.map do |(service_id, price)|
              service = AdditionalService.find_by(id: service_id)
              next unless service && BigDecimal(price).positive?  && !service.vip_service?
              [
                start_number += 1,
                service.title_ru,
                BigDecimal(price),
                booking.contract.rental_days,
                BigDecimal(price) * booking.contract.rental_days
              ]
            end.compact
          end

          def booking_vip_service(booking)
            booking.services.each_with_object({}) do |(service_id, price), service|
              if AdditionalService.find_by(id: service_id)&.vip_service? && BigDecimal(price).positive?
                service[:title] = AdditionalService.find_by(id: service_id).title_ru
                service[:price] = BigDecimal(price)
              end
            end
          end

          def prepare_pdf_tempfile(pdf, contract)
            pdf_tempfile = Tempfile.new([contract.number, ".pdf"])
            pdf_tempfile.binmode
            pdf_tempfile.write(pdf)
            pdf_tempfile.rewind
            pdf_tempfile
          end
        end
      end
    end
  end
end
