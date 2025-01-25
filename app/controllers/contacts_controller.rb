class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)

    if @contact.save
      # Send email immediately
      ContactMailer.contact_form(@contact).deliver_now

      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "contact_form",
            partial: "pages/contact_success"
          )
        }
      end
    else
      respond_to do |format|
        format.turbo_stream {
          render turbo_stream: turbo_stream.replace(
            "contact_form",
            partial: "pages/contact_form",
            locals: { contact: @contact }
          ), status: :unprocessable_entity
        }
      end
    end
  end

  private

  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
