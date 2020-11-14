class AwsSes

  def create_custom_verification_email_template
    begin
      ses_client.create_custom_verification_email_template({
        template_name: "SES_TEMPLATE_EMAIL",
        from_email_address: "dev.zombek@gmail.com",
        template_subject: "Email Address Verification Request",
        template_content: '<html><body><div>Hello user,</div><br><div>
        ...
        </div></body></html>',
        success_redirection_url: "https://devbops.com",
        failure_redirection_url: "https://google.com",
      })
    rescue StandardError => e
      Airbrake.notify(e)
    end



  private
  def ses_client
    @ses ||= Aws::SES::Client.new(
      region: region_name,
      credentials: credentials,
      # ...
    )
    end
    def send_custom_verification_email
    begin
      ses_client.send_custom_verification_email({
        email_address: "dev.zombek@gmail.com",
        template_name: "SES_TEMPLATE_EMAIL"
      })
      true
    rescue StandardError => e
      Airbrake.notify(e)
    end
    end
    def get_verified_emails
    result = ses_client.list_verified_email_addresses
    result.verified_email_addresses
    end
    end
  def send_email
    begin
      from = "dev.zombek@gmail.com"
      ses_client.send_email({
        source: from,
        destination: {
          to_addresses: [customer.email]
        },
        message: {
          subject: {
            data: "Email Verification"
          },
          body: {
            html: {
              data: "Welcome to the DevBops community fam. Here is your {username}"
            }
          },
        },
        reply_to_addresses: from,
      })
    rescue StandardError => e
      Airbrake.notify(e)
    end
 end
end
AwsSes.create_custom_verification_email_template