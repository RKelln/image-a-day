module CommentsHelper
    def self.wall_comments(page)
      Comment.where(:image_id => nil).order('created_at DESC').paginate(:per_page => 15, :page => page)
    end
end
