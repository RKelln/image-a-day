module CommentsHelper
    def self.wall_comments(page)
      Comment.where(:image_id => nil).reverse.paginate(:per_page => 15, :page => page)
    end
end
