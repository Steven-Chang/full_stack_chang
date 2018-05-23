require_relative '../task_helpers/email_helper'
namespace :fsc do
  desc "Adding rent to tenants and sending"
  task :add_rent_and_send => :environment do

    if Date.today > Date.new(2018, 03, 10)
      rent_details_by_day = {
        "Tuesday" => [{
          :username => "Dan Nitarski",
          :amount => 260,
          :initial_date => Date.new( 2018, 04, 24)
        }, {
          :username => "Sid Sahi",
          :amount => 298,
          :initial_date => Date.new( 2018, 04, 17)
        }, {
          :username => "Isabel Lozano",
          :amount => 260,
          :initial_date => Date.new( 2018, 04, 24)
        }],
        "Thursday" => [{
          :username => "Cheyenne Harmatz",
          :amount => 300,
          :initial_date => Date.new( 2018, 04, 26)
        }],
        "Friday" => [{
          :username => "Ella Kabel",
          :amount => 300,
          :initial_date => Date.new( 2018, 04, 27)
        }]
      }

      current_day_name = Date.today.strftime("%A")
      if rent_details_by_day[current_day_name]
        todays_date = Date.today.strftime("%e %b %y").strip
        date_in_thirteen_days = (Date.today + 13.days).strftime("%e %b %y").strip
        description = "Rent #{ todays_date } - #{ date_in_thirteen_days }"

        rent_details_by_day[current_day_name].each do |tenant_details|
          if ( Date.today - tenant_details[:initial_date] ).to_i % 14 == 0
            tenant = User.where(:username => tenant_details[:username]).first
            new_rent_transaction = RentTransaction.new
            new_rent_transaction.date = Date.today
            new_rent_transaction.user_id = tenant.id
            new_rent_transaction.amount = tenant_details[:amount]
            new_rent_transaction.description = description
            new_rent_transaction.save

            bond = RentTransaction.get_bond_for_user( tenant.id )
            balance = RentTransaction.get_balance_for_user( tenant.id )
            email_content = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Strict//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd'>
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
        color: #000000;
      }
      body a {
        color: #1188E6;
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
          margin-left: 0 !important;
          margin-right: 0 !important;
        }
      }
    </style>
    <!--user entered Head Start-->
    
     <!--End Head user entered-->
  </head>
  <body>
    <center class='wrapper' data-link-color='#1188E6' data-body-style='font-size: 14px; font-family: arial; color: #000000; background-color: #ffffff;'>
      <div class='webkit'>
        <table cellpadding='0' cellspacing='0' border='0' width='100%' class='wrapper' bgcolor='#ffffff'>
          <tr>
            <td valign='top' bgcolor='#ffffff' width='100%'>
              <table width='100%' role='content-container' class='outer' align='center' cellpadding='0' cellspacing='0' border='0'>
                <tr>
                  <td width='100%'>
                    <table width='100%' cellpadding='0' cellspacing='0' border='0'>
                      <tr>
                        <td>
                          <!--[if mso]>
                          <center>
                          <table><tr><td width='600'>
                          <![endif]-->
                          <table width='100%' cellpadding='0' cellspacing='0' border='0' style='width: 100%; max-width:600px;' align='center'>
                            <tr>
                              <td role='modules-container' style='padding: 0px 0px 0px 0px; color: #000000; text-align: left;' bgcolor='#ffffff' width='100%' align='left'>
                                
    <table class='module preheader preheader-hide' role='module' data-type='preheader' border='0' cellpadding='0' cellspacing='0' width='100%'
           style='display: none !important; mso-hide: all; visibility: hidden; opacity: 0; color: transparent; height: 0; width: 0;'>
      <tr>
        <td role='module-content'>
          <p></p>
        </td>
      </tr>
    </table>
  
    <table  border='0'
            cellpadding='0'
            cellspacing='0'
            align='center'
            width='100%'
            role='module'
            data-type='columns'
            data-version='2'
            style='padding:0px 0px 0px 0px;box-sizing:border-box;'
            bgcolor=''>
      <tr role='module-content'>
        <td height='100%' valign='top'>
            <!--[if (gte mso 9)|(IE)]>
              <center>
                <table cellpadding='0' cellspacing='0' border='0' width='100%' style='border-spacing:0;border-collapse:collapse;table-layout: fixed;' >
                  <tr>
            <![endif]-->
          
    <!--[if (gte mso 9)|(IE)]>
      <td width='300.000px' valign='top' style='padding: 0px 0px 0px 0px;border-collapse: collapse;' >
    <![endif]-->

    <table  width='300.000'
            style='width:300.000px;border-spacing:0;border-collapse:collapse;margin:0px 0px 0px 0px;'
            cellpadding='0'
            cellspacing='0'
            align='left'
            border='0'
            bgcolor=''
            class='column column-0 of-2
                  empty'
      >
      <tr>
        <td style='padding:0px;margin:0px;border-spacing:0;'>
            
    <table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;'>
      <tr>
        <td style='padding:18px 0px 18px 0px;line-height:22px;text-align:inherit;'
            height='100%'
            valign='top'
            bgcolor=''>
            <div><u>#{ tenant.username }</u></div>

<div><strong>Amount to be paid: $#{ balance }</strong></div>
<div><strong>If the amount to be paid is negative, you don't need to pay anything</strong></div>
<div>Bond: $#{ bond }</div>

        </td>
      </tr>
    </table>
  
        </td>
      </tr>
    </table>

    <!--[if (gte mso 9)|(IE)]>
      </td>
    <![endif]-->
    <!--[if (gte mso 9)|(IE)]>
      <td width='300.000px' valign='top' style='padding: 0px 0px 0px 0px;border-collapse: collapse;' >
    <![endif]-->

    <table  width='300.000'
            style='width:300.000px;border-spacing:0;border-collapse:collapse;margin:0px 0px 0px 0px;'
            cellpadding='0'
            cellspacing='0'
            align='left'
            border='0'
            bgcolor=''
            class='column column-1 of-2
                  empty'
      >
      <tr>
        <td style='padding:0px;margin:0px;border-spacing:0;'>
            
    <table class='module' role='module' data-type='text' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;'>
      <tr>
        <td style='padding:18px 0px 18px 0px;line-height:22px;text-align:inherit;'
            height='100%'
            valign='top'
            bgcolor=''>
            <div>
<div style='font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; font-family: arial; font-size: 14px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);'>Name: Steven Chang</div>

<div style='font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; font-family: arial; font-size: 14px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);'>BSB: 014274</div>

<div style='font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; font-family: arial; font-size: 14px; color: rgb(0, 0, 0); background-color: rgb(255, 255, 255);'>Account Number: 571706197&nbsp;</div>
</div>
        </td>
      </tr>
    </table>
  
        </td>
      </tr>
    </table>

    <!--[if (gte mso 9)|(IE)]>
      </td>
    <![endif]-->
            <!--[if (gte mso 9)|(IE)]>
                  <tr>
                </table>
              </center>
            <![endif]-->
        </td>
      </tr>
    </table>
  <table class='module' role='module' data-type='code' border='0' cellpadding='0' cellspacing='0' width='100%' style='table-layout: fixed;'>
      <tr>
        <td height='100%' valign='top'>
          <table>
  <thead>
    <tr>
      <th scope='col'>Date</th>
      <th scope='col'>Description</th>
      <th scope='col'>+/-</th>
    </tr>
  </thead>
  <tbody>"
    tenant.rent_transactions.order("date DESC").each do |rent_transaction|
      email_content = email_content + "<tr>
        <td>#{ rent_transaction.date }</td>
        <td>#{ rent_transaction.description }</td>
        <td>#{ rent_transaction.amount }</td>
      </tr>"
    end
  email_content = email_content + "</tbody>
</table>
        </td>
      </tr>
    </table>
                              </td>
                            </tr>
                          </table>
                          <!--[if mso]>
                          </td></tr></table>
                          </center>
                          <![endif]-->
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </div>
    </center>
  </body>
</html>"

            EmailHelper.send_email( "prime_pork@hotmail.com",
                                    "Steven Chang",
                                    tenant.email,
                                    "Rent Spread Sheet",
                                    email_content )
          end
        end
      end
    end

  end
end