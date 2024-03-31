# frozen_string_literal: true

module Office
  class DocumentTemplatesController < BaseController
    before_action :find_document_template, only: %i[show edit update destroy download]

    def index
      @document_templates = current_office_user.document_templates
    end

    def new
      @document_template = current_office_user.document_templates.build
      @owners = current_office_user.car_parks
    end

    def create
      operation = Operations::Office::DocumentTemplates::Create.new
      result = operation.call(document_template_params.to_h, current_office_user)

      case result
      in Success[document_template]
        success_message = success_resolver(operation)
        redirect_to edit_office_document_template_path(document_template), notice: success_message
      in Failure[error_code, errors]
        failure_message = failure_resolver(operation, error_code: error_code)
        flash.now[:alert] = failure_message
        @document_template = current_office_user.document_templates.build(document_template_params)
        @owners = current_office_user.car_parks
        render :new
      end
    end

    def show
      @owners = current_office_user.car_parks
    end

    def edit
      @owners = current_office_user.car_parks
    end

    def update
      operation = Operations::Office::DocumentTemplates::Update.new
      result = operation.call(@document_template, document_template_params.to_h, current_office_user)

      case result
      in Success[document_template]
        success_message = success_resolver(operation)
        redirect_to edit_office_document_template_path(document_template), notice: success_message
      in Failure[error_code, errors]
        failure_message = failure_resolver(operation, error_code: error_code)
        flash.now[:alert] = failure_message
        render :edit
      end
    end

    def destroy
      operation = Operations::Office::DocumentTemplates::Destroy.new
      result = operation.call(@document_template, current_office_user)

      case result
      in Success[document_template]
        success_message = success_resolver(operation)
        redirect_to office_document_templates_path, notice: success_message
      in Failure[error_code, errors]
        failure_message = failure_resolver(operation, error_code: error_code)
        redirect_to office_document_template_path(document_template), alert: failure_message
      end
    end

    def download
      pdf_template_string = render_to_string(
        template: "office/document_templates/pdf",
        layout: false
      )

      pdf_template = Liquid::Template.parse(pdf_template_string)

      pdf = WickedPdf.new.pdf_from_string(
        pdf_template.render(
          "content" => @document_template.content
        )
      )
      send_data(pdf, filename: "#{@document_template.title}.pdf", type: "application/pdf")
    end

    private

    def document_template_params
      params.require(:document_template).permit(:context, :title, :kind, :owner_type, :owner_id, :content, :current)
    end

    def find_document_template
      @document_template = current_office_user.document_templates.find(params[:id])
    end
  end
end
