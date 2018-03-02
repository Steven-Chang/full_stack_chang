namespace :fsc do
  desc "Adding weekly rent to tenants"
  task :add_rent_to_tenants => :environment do
    rent_details_by_day = {
      "Friday" => [{
        :username => "Dan Nitarski",
        :amount => 130
      }, {
        :username => "Sid Sahi",
        :amount => 149
      }, {
        :username => "Cheyenne Harmatz",
        :amount => 150
      }]
    }

    current_day_name = Date.today.strftime("%A")
    if rent_details_by_day[current_day_name]
      todays_date = Date.today.strftime("%e %b %y").strip
      date_in_six_days = (Date.today + 6.days).strftime("%e %b %y").strip
      description = "Rent #{ todays_date } - #{ date_in_six_days }"

      rent_details_by_day[current_day_name].each do |tenant_details|
        tenant = User.where(:username => tenant_details[:username]).first
        new_rent_transaction = RentTransaction.new
        new_rent_transaction.user_id = tenant.id
        new_rent_transaction.amount = tenant_details[:amount]
        new_rent_transaction.description = description
        new_rent_transaction.save
      end
    end
  end
end