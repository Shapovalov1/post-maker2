module Posts
  class CreateService < Service
    class Input < BaseInput
      attribute :title, type: String
      attribute :post, type: String
      attribute :social_networks, array: true
      attribute :schedule_time, type: Date

      validates :title, presence: true
      validates :post, presence: true
      validates :schedule_time, presence: true
    end

    attr_reader :input, :post

    def perform
      if input[:schedule_time] > Date.today && input[:post].length <= 250 && input[:title].length <= 50  && input[:post].length != 0 && input[:title].length != 0 && input[:social_networks].length > 1
        input[:social_networks].each do |item|
          if item.length != 0
            @p = SocialContent.create(title: input[:title], post: input[:post])
            @p.social_posts.create(schedule_time: input[:schedule_time], social_network: item)
          end
        end

      else
        errors.add(:schedule_time, 'date is in past') if input[:schedule_time] <= Date.today
        errors.add(:title, 'length more then 50 symbols') if input[:title].length > 50
        errors.add(:post, 'length more then 250 symbols') if input[:post].length > 250
        errors.add(:title, 'empty') if input[:title].length == 0
        errors.add(:post, 'empty') if input[:post].length == 0
        errors.add(:social_networks, 'can not be empty') if input[:social_networks].length < 2
      end
    end
  end
end