class GroupingsController < ApplicationController
  def create
    @grouping = Grouping.new(grouping_params)
    if @grouping.save
      render json: @grouping
    else
      render(
        json: @grouping.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    @grouping = Grouping.find(params[:id])
    if @grouping.destroy
      render json: @grouping
    else
      render(
        json: "Unable to delete grouping."
      )
    end
  end

  private
  def grouping_params
    params.require(:grouping).permit(:group_id, :contact_id)
  end
end
