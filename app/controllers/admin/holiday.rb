module Admin
  class Holiday
    attr_accessor :from_date, :to_date, :message

    def initialize(from_date:, to_date:, message:)
      @from_date = from_date
      @to_date = to_date
      @message = message
      @created = false

      @range = (from_date..to_date).to_a.select do |d|
        (1..5).include? d.strftime('%w').to_i
      end

      @errors = []
    end

    def create_events
      @range.each do |date|
        User.all.each do |user|
          user.events.create(
              worked_at: date,
              gefroren: true,
              hours: 8,
              description: @message
          )
        end
      end

      @created = true
      reset
    end

    def full_error_message
      @errors.join('<br>').html_safe
    end

    def success_message
      @created ? 'Holiday Successfully Scheduled!' : ''
    end

    def holiday_params
      {
          from_date: @from_date,
          to_date: @to_date,
          message: @message
      }
    end

    def valid?
      validate
      @errors.empty?
    end

    private
    def validate
      if message.blank?
        @errors << 'A vacation message is required!'
      end

      if @range.count > 5
        @errors << 'Invalid date range! Please specify a period with at most 5 working days!'
      end

      if @range.count == 0
        @errors << 'Invalid date range! No working days found in the specified period!'
      end
    end

    def reset
      @from_date = nil
      @to_date = nil
      @message = nil
    end
  end
end