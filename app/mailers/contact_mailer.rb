class ContactMailer < ApplicationMailer
  default to: "cristobal.rojasbrito@gmail.com"

  def contact_form(contact)
    @contact = contact
    I18n.with_locale(I18n.locale) do
      mail(
        from: "#{@contact.name} <#{@contact.email}>",
        reply_to: @contact.email,
        subject: t(".subject")
      )
    end
  end
end
