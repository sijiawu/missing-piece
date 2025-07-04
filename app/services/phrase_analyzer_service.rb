class PhraseAnalyzerService
  # Common stop words that don't add much meaning to a phrase
  STOP_WORDS = %w[
    a an and are as at be by for from has he in is it its of on that the to was will with
    i you we they this that these those my your his her its our their me him her us them
    am is are was were been being have has had do does did will would could should may might
    the a an and or but in on at to for of with by from up down out off over under
    this that these those i you he she it we they me him her us them my your his her its our their
    am is are was were been being have has had do does did will would could should may might
    not no yes very really quite just only even still yet already also too so such
    here there where when why how what which who whom whose
  ].freeze

  # Extract the most meaningful word from a phrase for Youglish
  def extract_core_word(phrase)
    return phrase if phrase.blank?
    
    # Clean the phrase
    clean_phrase = phrase.strip.downcase
    
    # Remove punctuation
    clean_phrase = clean_phrase.gsub(/[.,!?;:'"()]/, '')
    
    # Split into words
    words = clean_phrase.split(/\s+/)
    
    # Filter out stop words and very short words
    meaningful_words = words.reject do |word|
      word.length < 3 || STOP_WORDS.include?(word)
    end
    
    # If no meaningful words found, return the longest word
    if meaningful_words.empty?
      return words.max_by(&:length) || phrase
    end
    
    # Return the longest meaningful word (usually the most important)
    meaningful_words.max_by(&:length)
  end

  # Get Youglish URL for a phrase in the target language
  # Note: Youglish expects the translated word and language name, not English word and language code
  def youglish_url(phrase, target_language, translation = nil)
    # If we have a translation, extract the core word from the translation
    # Otherwise, fall back to the English phrase
    if translation.present? && translation != "[Translation unavailable]"
      core_word = extract_core_word(translation)
    else
      core_word = extract_core_word(phrase)
    end
    
    language_name = language_to_youglish_name(target_language)
    
    "https://youglish.com/pronounce/#{URI.encode_www_form_component(core_word)}/#{language_name}"
  end

  # Get Reverso URL for a phrase
  def reverso_url(phrase, target_language)
    language_code = language_to_reverso_code(target_language)
    "https://context.reverso.net/translation/english-#{language_code}/#{URI.encode_www_form_component(phrase)}"
  end

  private

  def language_to_youglish_name(language)
    case language.to_s.downcase
    when 'french'
      'french'
    when 'spanish'
      'spanish'
    when 'polish'
      'polish'
    when 'german'
      'german'
    when 'italian'
      'italian'
    when 'portuguese'
      'portuguese'
    when 'russian'
      'russian'
    when 'japanese'
      'japanese'
    when 'chinese'
      'chinese'
    when 'korean'
      'korean'
    when 'english', 'en'
      'english'
    else
      'french' # default to French
    end
  end

  def language_to_reverso_code(language)
    case language.to_s.downcase
    when 'french'
      'french'
    when 'spanish'
      'spanish'
    when 'polish'
      'polish'
    when 'german'
      'german'
    when 'italian'
      'italian'
    when 'portuguese'
      'portuguese'
    when 'russian'
      'russian'
    when 'japanese'
      'japanese'
    when 'chinese'
      'chinese'
    when 'korean'
      'korean'
    else
      'french' # default to French
    end
  end
end 