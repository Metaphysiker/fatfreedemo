namespace :sync do

    task users: :environment do

    url      = 'http://localhost:3000/getusers'
    uri      = URI(url)
    response = Net::HTTP.get(uri)
    response2 = JSON.parse(response)
    response3 = response2.first
    users = response3.second

    users.each do |u|
      user = OpenStruct.new(u)
      puts user.firstname
      Contact.create(
        first_name: user.firstname,
        last_name: user.lastname,
        access: "Public",
        email: user.email,
        created_at: user.created_at
      )
    end


  end

  task societies: :environment do

  url      = 'http://localhost:3000/getsocieties'
  uri      = URI(url)
  response = Net::HTTP.get(uri)
  response2 = JSON.parse(response)
  response3 = response2.first
  societies = response3.second

  societies.each do |s|
    society = OpenStruct.new(s)
    Account.create(
      name: society.name,
      access: "Public",
      created_at: society.created_at
    )
  end


end

end
