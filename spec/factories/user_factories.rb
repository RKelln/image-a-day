Factory.define :user do |u|
    u.sequence(:email) {|n| "user_#{n}@mailinator.com"}
    u.sequence(:nickname) {|n| "User#{n}"}
    u.name 'Default User'
    u.password 'password'
end
