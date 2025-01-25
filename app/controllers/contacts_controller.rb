class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    respond_to do |format|
      if @contact.save
        # Send email
        ContactMailer.contact_form(@contact).deliver_later

        format.html { redirect_back(fallback_location: root_path, notice: t("contact.success")) }
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("contact_form",
            partial: "pages/contact_success")
        }
      else
        format.html { redirect_back(fallback_location: root_path, alert: t("contact.error")) }
        format.turbo_stream {
          render turbo_stream: turbo_stream.update("contact_form",
            partial: "pages/contact_form",
            locals: { contact: @contact })
        }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
