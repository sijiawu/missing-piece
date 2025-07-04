# Translation Service Configuration
# 
# This app uses DeepL API for high-quality translations
# 
# To set up DeepL:
# 1. Get a DeepL API key from https://www.deepl.com/pro-api
# 2. Add it to your credentials: rails credentials:edit
# 3. Add: deepl_api_key: your_api_key_here
#
# DeepL offers:
# - Free tier: 500,000 characters/month
# - Pro tier: Higher limits and additional features
# - Excellent translation quality, especially for European languages

Rails.application.config.after_initialize do
  # Set default timeout for translation requests
  TranslationService.default_timeout 10
end 