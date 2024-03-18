# frozen_string_literal: true

module Office
  class CommentsController < BaseController
    def new
      @comment = Comment.new
    end

    def create
      operation = Operations::Office::Comments::Create.new
      result = operation.call(comment_params.to_h, current_office_user)

      case result
      in Success[comment]
        @comment = comment

        respond_to do |format|
          format.html { redirect_to office_booking_path(comment.commentable_id) }
          format.turbo_stream
        end
      in Failure[error_code, errors]
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:commentable_id, :commentable_type, :content)
    end
  end
end
