require 'faker'

namespace :populate do

  desc "Generate test patients"
  task patient_diseases: :environment do
    user_ids = User.all.pluck(:id)
    #Patient.destroy_all

    10.times do |n|
      name = Faker::Name.name
      address = Faker::Address.street_name
      phone = Faker::PhoneNumber.cell_phone
      status = ['Admitted','Success','Failure','InProgress'].sample
      patient = Patient.new(name: name,address: address,phone: phone,status: status, user_id: user_ids.sample)
      patient.disease = Disease.new(description: Faker::Lorem.sentence(6))
      patient.save!
    end
  end

  desc "TODO"
  task users: :environment do
  end

  desc "TODO"
  task managers: :environment do
  end

  desc "TODO"
  task agents: :environment do
    name = Faker::Name.name
    address = Faker::Address.street_name
    phone = Faker::PhoneNumber.cell_phone
    email = Faker::Internet.email(name)
    password = 'd.k.padhy'
    status = 'I'
    role = 2
    user = User.new(name: name, address: address, phone: phone, email: email, status: status, role_id: role, password: password, password_confirmation: password)
    user.save!
  end

  desc "Generat roles"
  task roles: :environment do
    roles = ["manager","agent","donor"]
    Role.delete_all
    roles.each do |role|
      Role.create(role_name: role)
    end
  end

  desc "Generat diseases"
  task diseases: :environment do
    descriptions = ["Cancer","Heart Choak","Brain tumor"]
    patient_id =  Patient.all.pluck(:id)
    Disease.delete_all
    patient_id.each do |p|
      Disease.create(description: descriptions.sample, patient_id: p)
    end
  end

end

namespace :roles do
  desc "assinging roles to users"

  task assign_roles: :environment do
    roles_id = Role.all.pluck(:id)
    users = User.all
    users.each do |user|
      user.update_attributes(role_id: roles_id.sample)
    end
    puts 'Successfully updated user roles. '
  end

end
