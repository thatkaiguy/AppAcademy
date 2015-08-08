class BoardsController < ApplicationController
  def index
    @boards = Board.all
    render json: @boards
  end

  def new
    @board = Board.new
    render json: @board
  end

  def create
    @board = current_user.created_boards.new(board_params)
    fail
    if @board.save
      render json: @board
    else
      render json: @board.errors.full_messages, status: unprocessable_entity
    end
  end

  def show
    @board = Board.find(params[:id])
    render json: @board
  end

  private

  def board_params
    params.require(:board).permit(:title)
  end
end
