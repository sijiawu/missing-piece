class PhrasesController < ApplicationController
  before_action :authenticate_user!

  # POST /phrases
  def create
    entry = current_user.entries.find(params[:entry_id])
    selected_phrases = JSON.parse(params[:selected_phrases] || '[]')
    target_language = params[:target_language] || 'French'
    
    begin
      translation_service = TranslationService.new
      @suggestions = selected_phrases.map do |phrase|
        translation = translation_service.translate(phrase, target_language)
        explanation = translation_service.get_explanation(phrase, target_language)
        example = translation_service.get_example(phrase, target_language)
        
        {
          text: phrase,
          translation: translation || "[Translation unavailable]",
          explanation: explanation,
          example: example
        }
      end
      @entry = entry
      @target_language = target_language
      render :review
    rescue => e
      Rails.logger.error "Translation error: #{e.message}"
      flash[:error] = "Translation service is currently unavailable. Please try again later."
      redirect_to entry_path(entry)
    end
  end
end
