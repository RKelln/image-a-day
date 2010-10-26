Factory.define :image do |i|
    i.data {image_file = File.new(File.join(Rails.root, 'public', 'images', 'rails.png'))}
    i.sequence(:description) {|n| "This is image #{n}."}
    i.date Date.current # Today is the default so images are always current
    #i.sequence(:date) {|n| Date.current - (n-1).days}
    
    i.association :user
end
