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
            {
              "contract" => {
                "number" => contract.number,
                "date" => contract.date
              },
              "client" => {
                "full_name" => client.full_name,
                "identification_number" => client.identification_number,
                "passport_number" => client.passport_number,
                "phone" => client.phone,
                "email" => client.email
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
