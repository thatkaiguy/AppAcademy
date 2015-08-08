class Api::BoardsController < ApplicationController
  def index
    @boards = Board.all
  end

  def create
    @board = current_user.created_boards.new(board_params)
    if @board.save
      render json: @board
    else
      render json: @board.errors.full_messages, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end
end
