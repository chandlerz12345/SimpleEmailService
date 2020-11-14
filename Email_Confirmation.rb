class AwsSes
...
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
            data: "subject"
          },
          body: {
            html: {
              data: "body"
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
...