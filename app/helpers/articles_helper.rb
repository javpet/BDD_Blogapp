module ArticlesHelper
  def persisted_comments(comments)
    comments.reject(&:new_record?) # comments that are coming from the database only
    # http://api.rubyonrails.org/classes/ActiveRecord/Persistence.html#method-i-new_record-3F
  end
end
