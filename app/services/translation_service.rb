class TranslationService
  include HTTParty
  
  # DeepL API endpoint
  base_uri 'https://api-free.deepl.com'
  
  # Set default timeout
  default_timeout 10
  
  def initialize
    @api_key = Rails.application.credentials.deepl_api_key
    raise "DeepL API key not configured. Please add 'deepl_api_key: your_key_here' to your Rails credentials." unless @api_key
  end
  
  def translate(text, target_language, source_language = 'en')
    return nil if text.blank?
    
    # Map our language names to DeepL language codes
    target_code = language_to_deepl_code(target_language)
    source_code = language_to_deepl_code(source_language)
    
    return nil unless target_code && source_code
    
    # Don't translate if source and target are the same
    return text if source_code == target_code
    
    response = self.class.post('/v2/translate', {
      body: {
        text: text,
        source_lang: source_code,
        target_lang: target_code
      },
      headers: {
        'Authorization' => "DeepL-Auth-Key #{@api_key}",
        'Content-Type' => 'application/x-www-form-urlencoded'
      },
      timeout: 10
    })
    
    if response.success?
      translated_text = response.parsed_response['translations']&.first&.dig('text')
      # Return the original text if translation is empty or same as original
      translated_text.present? && translated_text != text ? translated_text : nil
    else
      Rails.logger.error "DeepL translation failed: #{response.code} - #{response.body}"
      nil
    end
  rescue Net::ReadTimeout, Net::OpenTimeout => e
    Rails.logger.error "DeepL translation timeout: #{e.message}"
    nil
  rescue => e
    Rails.logger.error "DeepL translation error: #{e.message}"
    nil
  end
  
  def get_explanation(phrase, target_language)
    # For now, return a simple explanation
    # In the future, this could call an AI service for better explanations
    case target_language.downcase
    when 'french'
      "Cette expression est utilisée pour exprimer #{phrase.downcase}."
    when 'spanish'
      "Esta expresión se usa para expresar #{phrase.downcase}."
    when 'polish'
      "To wyrażenie jest używane do wyrażania #{phrase.downcase}."
    when 'german'
      "Dieser Ausdruck wird verwendet, um #{phrase.downcase} auszudrücken."
    when 'italian'
      "Questa espressione è usata per esprimere #{phrase.downcase}."
    when 'portuguese'
      "Esta expressão é usada para expressar #{phrase.downcase}."
    when 'russian'
      "Это выражение используется для выражения #{phrase.downcase}."
    when 'japanese'
      "この表現は #{phrase.downcase} を表現するために使用されます。"
    when 'chinese'
      "这个表达用于表达 #{phrase.downcase}。"
    when 'korean'
      "이 표현은 #{phrase.downcase}를 표현하는 데 사용됩니다."
    else
      "This expression is used to express #{phrase.downcase}."
    end
  end
  
  def get_example(phrase, target_language)
    # For now, return a simple example
    # In the future, this could call an AI service for better examples
    case target_language.downcase
    when 'french'
      "Exemple: Voici un exemple avec '#{phrase}'."
    when 'spanish'
      "Ejemplo: Aquí hay un ejemplo con '#{phrase}'."
    when 'polish'
      "Przykład: Oto przykład z '#{phrase}'."
    when 'german'
      "Beispiel: Hier ist ein Beispiel mit '#{phrase}'."
    when 'italian'
      "Esempio: Ecco un esempio con '#{phrase}'."
    when 'portuguese'
      "Exemplo: Aqui está um exemplo com '#{phrase}'."
    when 'russian'
      "Пример: Вот пример с '#{phrase}'."
    when 'japanese'
      "例: '#{phrase}'を使った例です。"
    when 'chinese'
      "例子：这是使用 '#{phrase}' 的例子。"
    when 'korean'
      "예시: '#{phrase}'를 사용한 예시입니다."
    else
      "Example: Here is an example with '#{phrase}'."
    end
  end
  
  private
  
  def language_to_deepl_code(language)
    case language.to_s.downcase
    when 'french'
      'FR'
    when 'spanish'
      'ES'
    when 'polish'
      'PL'
    when 'german'
      'DE'
    when 'italian'
      'IT'
    when 'portuguese'
      'PT'
    when 'russian'
      'RU'
    when 'japanese'
      'JA'
    when 'chinese'
      'ZH'
    when 'korean'
      'KO'
    when 'english', 'en'
      'EN'
    else
      nil
    end
  end
end 