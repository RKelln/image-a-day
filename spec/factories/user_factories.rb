Factory.define :user do |u|
    u.sequence(:email) {|n| "user_#{n}@mailinator.com"}
    u.sequence(:nickname) {|n| "User#{n}"}
    u.name 'Default User'
    u.password 'password'
end

Factory.define :admin, :class => User do |u|
    u.sequence(:email) {|n| "admin_#{n}@mailinator.com"}
    u.sequence(:nickname) {|n| "Admin#{n}"}
    u.name 'Default Admin'
    u.password 'password'
end
