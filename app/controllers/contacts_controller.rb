class ContactsController < ApplicationController
  def create
    # Contact form is disabled
    respond_to do |format|
      format.html { redirect_to root_path, notice: "Contact form is currently disabled." }
      format.turbo_stream {
        render turbo_stream: turbo_stream.replace(
          "contact_form",
          partial: "pages/contact_form"
        )
      }
      format.json { render json: { error: "Contact form is disabled" }, status: :unprocessable_entity }
    end
    return
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end

  def spam_detected?(contact)
    # 1. Check for known spam domains
    spam_domains = [
      'leadboost.click',
      'searchindex.site',
      'searchregister.info',
      # Add more as needed
    ]
    
    return true if spam_domains.any? { |domain| contact.email.downcase.end_with?("@#{domain}") }
    
    # 2. Check for spam keywords in the message
    spam_keywords = [
      'search engine index',
      'google search index',
      'add your domain',
      'seo',
      'boost your ranking',
      'searchregister',
      'index your website',
      'indexing service',
      # Add more as needed
    ]
    
    return true if spam_keywords.any? { |keyword| contact.message.downcase.include?(keyword.downcase) }
    
    # 3. Check for suspicious patterns
    # Emails with generic names like "submissions@", "info@", etc.
    suspicious_emails = [
      'submissions@',
      'info@',
      'admin@',
      'contact@',
      'support@',
      'no-reply@',
      'search@'
      # Add more as needed
    ]
    
    return true if suspicious_emails.any? { |email_pattern| contact.email.downcase.include?(email_pattern.downcase) }
    
    # 4. Check if message contains URLs (common in spam)
    # url_regex = /(https?:\/\/[^\s]+)/
    # if contact.message.scan(url_regex).count > 4 
    #   return true
    # end
    
    false  # Not spam
  end
end
