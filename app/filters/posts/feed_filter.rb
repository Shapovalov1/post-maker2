module Posts
  class FeedFilter < BaseFilter
    def perform
      #@a = base_scope
      #@a = @a.where("title LIKE ?", "%#{input[:search_text]}%") if input[:search_text].present?
      #@a = @a.where("post LIKE ?", "%#{input[:search_text]}%") if input[:search_text].present?
      #@a = @a.joins(:social_posts).where(social_posts: { social_network: input[:social_networks] } ) if input[:social_networks].present?
      #@a = @a.joins(:social_posts).where(social_posts: { schedule_time: (input[:date_from])..input[:date_to] } ) if input[:date_from] && input[:date_to]
      
      if input[:search_text]
        @a = SocialContent.where("title LIKE ?", "%#{input[:search_text]}%").or(SocialContent.where("post LIKE ?", "%#{input[:search_text]}%"))
      else
        @a = base_scope
      end

      if input[:social_networks]
        @b = SocialContent.joins(:social_posts).where(social_posts: { social_network: input[:social_networks] } )
        @b = @a & @b
      else
        @b = @a
      end

      if input[:date_from] && input[:date_to]
        @c = SocialContent.joins(:social_posts).where(social_posts: { schedule_time: (input[:date_from])..input[:date_to] } )
        @c = @b & @c
      else
        @c = @b
      end
    end

    private

    # NOTE: this method can be modified
    def base_scope
        SocialContent.all.includes(:social_posts)
    end
  end
end