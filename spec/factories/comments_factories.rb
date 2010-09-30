Factory.define :comment do |c|
    c.text "This is a comment."
    c.association :user
end