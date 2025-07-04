class EntriesController < ApplicationController
  before_action :authenticate_user!

  PROMPTS = [
    "Describe something that made you happy this week.",
    "What is a challenge you faced recently?",
    "Write about a goal you have for this month."
  ]

  def new
    @entry = Entry.new
    @prompt = PROMPTS.sample
  end

  def create
    @entry = current_user.entries.build(entry_params)
    if @entry.save
      redirect_to @entry
    else
      @prompt = PROMPTS.sample
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @entry = current_user.entries.find(params[:id])
    # Next step: phrase selection/highlighting
  end

  def index
    @entries = current_user.entries.includes(:phrases).order(created_at: :desc)
  end

  def destroy
    @entry = current_user.entries.find(params[:id])
    @entry.destroy
    redirect_to entries_path, notice: 'Journal entry deleted successfully.'
  end

  private

  def entry_params
    params.require(:entry).permit(:content)
  end
end
