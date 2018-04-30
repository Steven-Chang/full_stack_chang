namespace :fsc do
  desc "Adding weekly rent to tenants"
  task :add_rent_to_tenants => :environment do

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
          if ( Date.today - tent_datails[:initial_date] ).to_i % 14 == 0
            tenant = User.where(:username => tenant_details[:username]).first
            new_rent_transaction = RentTransaction.new
            new_rent_transaction.date = Date.today
            new_rent_transaction.user_id = tenant.id
            new_rent_transaction.amount = tenant_details[:amount]
            new_rent_transaction.description = description
            new_rent_transaction.save
          end
        end
      end
    end

  end
end