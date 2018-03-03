namespace :fsc do
  desc "Weekly emailing of rental statement"
  task :send_rent_statement => :environment do

    require 'sendgrid-ruby'
    include SendGrid

    if Time.now.gmtime.strftime("%A") == "Saturday"

      User.all.each do |user|
        next unless user.tenant
        from = Email.new(email: 'prime_pork@hotmail.com', name: "Steven Chang")
        to = Email.new(email: "admin@livefinder.com")
        subject = "Rent Spreadsheet"

        html = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'>
        <html data-editor-version='2' class='sg-campaigns' xmlns='http://www.w3.org/1999/xhtml'>
          <head>
            <meta http-equiv='Content-Type' content='text/html; charset=utf-8' />
            <meta name='viewport' content='width=device-width, initial-scale=1, minimum-scale=1, maximum-scale=1' /><!--[if !mso]><!-->
            <meta http-equiv='X-UA-Compatible' content='IE=Edge' /><!--<![endif]-->
            <!--[if (gte mso 9)|(IE)]>
            <xml>
            <o:OfficeDocumentSettings>
            <o:AllowPNG/>
            <o:PixelsPerInch>96</o:PixelsPerInch>
            </o:OfficeDocumentSettings>
            </xml>
            <![endif]-->
            <!--[if (gte mso 9)|(IE)]>
            <style type='text/css'>
              body {width: 600px;margin: 0 auto;}
              table {border-collapse: collapse;}
              table, td {mso-table-lspace: 0pt;mso-table-rspace: 0pt;}
              img {-ms-interpolation-mode: bicubic;}
            </style>
            <![endif]-->

            <style type='text/css'>
              body, p, div {
                font-family: arial;
                font-size: 14px;
              }
              body {
                color: #9B9B9B;
              }
              body a {
                color: #0070CD;
                text-decoration: none;
              }
              a {
                text-decoration: none;
              }
              p { margin: 0; padding: 0; }
              table.wrapper {
                width:100% !important;
                table-layout: fixed;
                -webkit-font-smoothing: antialiased;
                -webkit-text-size-adjust: 100%;
                -moz-text-size-adjust: 100%;
                -ms-text-size-adjust: 100%;
              }
              img.max-width {
                max-width: 100% !important;
              }
              .column.of-2 {
                width: 50%;
              }
              .column.of-3 {
                width: 33.333%;
              }
              .column.of-4 {
                width: 25%;
              }
              @media screen and (max-width:480px) {
                .preheader .rightColumnContent,
                .footer .rightColumnContent {
                    text-align: left !important;
                }
                .preheader .rightColumnContent div,
                .preheader .rightColumnContent span,
                .footer .rightColumnContent div,
                .footer .rightColumnContent span {
                  text-align: left !important;
                }
                .preheader .rightColumnContent,
                .preheader .leftColumnContent {
                  font-size: 80% !important;
                  padding: 5px 0;
                }
                table.wrapper-mobile {
                  width: 100% !important;
                  table-layout: fixed;
                }
                img.max-width {
                  height: auto !important;
                  max-width: 480px !important;
                }
                a.bulletproof-button {
                  display: block !important;
                  width: auto !important;
                  font-size: 80%;
                  padding-left: 0 !important;
                  padding-right: 0 !important;
                }
                .columns {
                  width: 100% !important;
                }
                .column {
                  display: block !important;
                  width: 100% !important;
                  padding-left: 0 !important;
                  padding-right: 0 !important;
                }
              }
            </style>
            <!--user entered Head Start-->
            
             <!--End Head user entered-->
          </head>
          <body>Test Test Test Test Test</body></html>"

        content = Content.new(type: 'text/html', value: html)
        mail = SendGrid::Mail.new(from, subject, to, content)
        mail.reply_to = Email.new(email: 'prime_pork@hotmail.com')

        sg = SendGrid::API.new(api_key: ENV['SENDGRID_API_KEY'])
        response = sg.client.mail._('send').post(request_body: mail.to_json)

        puts response.status_code
        puts response.body
        puts response.headers

      end
    end
  end
end