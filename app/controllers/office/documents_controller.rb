# frozen_string_literal: true

module Office
  class DocumentsController < BaseController
    before_action :find_document

    def show
      send_data @document.file.read, filename: @document.file.original_filename, type: @document.file.mime_type
    end

    def download
      tempfile = @document.file.download
      send_data tempfile.read, filename: @document.file.original_filename, type: @document.file.mime_type
    end

    private

    def find_document
      @document = current_office_user.documents.find(params[:id])
    end
  end
end
