class AwsSes


  def create_custom_verification_email_template
    begin
      ses_client.create_custom_verification_email_template({
        template_name: "Email_Confirmation",
        from_email_address: "dev.zombek@gmail.com",
        template_subject: "Email Address Verification Request",
        template_content: '<html><body><div>Dear partner,</div><br><div>
        ...
        </div></body></html>',
        success_redirection_url: "www.devbops.com",
        failure_redirection_url: "www.rickroll.com",
      })
    rescue StandardError => e
      Airbrake.notify(e)
    end
  end

  private
  def ses_client
    @ses ||= Aws::SES::Client.new (
      region: region_name,
      credentials: credentials,
      # ...
    )
  end
end