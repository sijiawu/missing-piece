# Translation Service Setup

This app uses DeepL API for high-quality translations. DeepL is known for producing very natural and accurate translations, especially for European languages.

## Setup Instructions

### 1. Get a DeepL API Key

1. **Visit DeepL Pro API:** https://www.deepl.com/pro-api
2. **Sign up for a free account** (500,000 characters/month)
3. **Get your API key** from your account dashboard

### 2. Add the API Key to Rails Credentials

```bash
rails credentials:edit
```

Add this line to your credentials file:
```yaml
deepl_api_key: your_deepl_api_key_here
```

### 3. Restart Your Rails Server

```bash
rails server
```

## DeepL API Features

### Free Tier
- **500,000 characters per month**
- **High-quality translations**
- **Support for 29+ languages**
- **Perfect for development and small projects**

### Pro Tier
- **Higher character limits**
- **Additional features like glossary support**
- **Priority support**
- **Suitable for production applications**

## Supported Languages

The app currently supports:
- **French** (FR)
- **Spanish** (ES) 
- **Polish** (PL)
- **English** (EN) - source language

DeepL supports many more languages. To add new languages:
1. Add the language mapping in `TranslationService#language_to_deepl_code`
2. Add the language option to the dropdown in `phrases/_highlight.html.erb`
3. Update the explanation and example methods if needed

## API Endpoints

- **Free tier:** `https://api-free.deepl.com`
- **Pro tier:** `https://api.deepl.com`

The app is configured for the free tier by default. If you have a pro account, update the `base_uri` in `app/services/translation_service.rb`.

## Error Handling

The service includes comprehensive error handling:
- **Network timeouts** (10-second timeout)
- **API rate limits** (graceful fallback)
- **Invalid API keys** (clear error messages)
- **Translation failures** (fallback to original text)

## Troubleshooting

### "DeepL API key not configured" error:
1. Make sure you've added the API key to your credentials
2. Restart your Rails server
3. Check that the key is correct

### Translation unavailable errors:
- Check your internet connection
- Verify your DeepL API key is valid
- Check if you've hit your monthly character limit
- Look at the Rails logs for specific error messages

### Adding new languages:
1. Check DeepL's supported languages: https://www.deepl.com/docs-api/translate-text/
2. Add the language mapping in `TranslationService#language_to_deepl_code`
3. Add the language option to the dropdown in `phrases/_highlight.html.erb`
4. Update the explanation and example methods if needed

## Rate Limits and Costs

- **Free tier:** 500,000 characters/month
- **Pro tier:** Varies by plan
- **Character counting:** Includes spaces and punctuation
- **Cost:** Free tier is completely free

## Quality Benefits

DeepL is particularly good at:
- **Natural-sounding translations**
- **Context-aware translations**
- **European languages** (especially French, German, Spanish)
- **Technical and professional content**
- **Maintaining tone and style**

## Fallback Behavior

If translations fail, the app will:
1. Show "[Translation unavailable]" for the translation
2. Still allow users to save phrases to their phrasebook
3. Provide basic explanations and examples in the target language
4. Log detailed errors for debugging 