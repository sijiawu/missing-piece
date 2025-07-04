class PhrasebookEntriesController < ApplicationController
  before_action :authenticate_user!

  def index
    @phrasebook_entries = current_user.phrasebook_entries.includes(:phrase).order(created_at: :desc)
  end

  def create
    entry = current_user.entries.find(params[:entry_id])
    target_language = params[:target_language] || 'French'
    saved_phrases = params[:save_phrases] || []
    translations = params[:translations] || {}

    saved_phrases.each do |phrase_text|
      # Create or find the phrase
      phrase = entry.phrases.find_or_create_by(text: phrase_text) do |p|
        p.translation = translations.dig(phrase_text, :translation) || ''
        p.explanation = translations.dig(phrase_text, :explanation) || ''
        p.example = translations.dig(phrase_text, :example) || ''
      end

      # Create phrasebook entry with language
      current_user.phrasebook_entries.find_or_create_by(phrase: phrase, language: target_language)
    end

    redirect_to phrasebook_entries_path, notice: "#{saved_phrases.count} phrase(s) saved to your #{target_language.downcase} phrasebook!"
  end

  def destroy
    phrasebook_entry = current_user.phrasebook_entries.find(params[:id])
    phrasebook_entry.destroy
    redirect_to phrasebook_entries_path, notice: 'Phrase removed from phrasebook.'
  end
end
