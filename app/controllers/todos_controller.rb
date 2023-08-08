# frozen_string_literal: true

class TodosController < ApplicationController
  before_action :set_todo, only: %i[show edit update destroy cancel_edit move]

  def index
    @todos = Todo.all.order(position: :asc)
  end

  def show; end

  def new
    @todo = Todo.new
  end

  def edit; end

  def create # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    @todo = Todo.new(todo_params)

    respond_to do |format|
      if @todo.save
        @todo.move_to_top
        format.turbo_stream
        format.html { redirect_to todos_path, notice: 'Todo was successfully created.' }
        format.json { render :show, status: :created, location: @todo }
      else
        format.turbo_stream { render 'errors' }
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def update # rubocop:disable Metrics/MethodLength
    respond_to do |format|
      if @todo.update(todo_params)
        format.turbo_stream
        format.html { redirect_to todos_path, notice: 'Todo was successfully updated.' }
        format.json { render :show, status: :ok, location: @todo }
      else
        format.turbo_stream { render 'errors' }
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @todo.destroy

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to todos_path, notice: 'Todo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def cancel_create
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to todos_path }
    end
  end

  def cancel_edit
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to todos_path }
    end
  end

  def move
    @todo.insert_at(params[:position].to_i)
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_todo
    @todo = Todo.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def todo_params
    params.require(:todo).permit(:title, :description)
  end
end
