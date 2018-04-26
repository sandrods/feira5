class Calendar
  attr_accessor :date, :year

  def initialize(date: nil, year: nil)

    if date.present?
      @date = date.is_a?(String) ? Date.parse(date) : date

    elsif year.present?
      @date = Date.new year.to_i, 1, 1

    else
      @date = Date.today
    end

    @year = @date.year

  end

  def this_month?(day)
    day.month == @date.month
  end

  def future?
    range.begin.future?
  end

  def past?
    range.last.past?
  end

  def month
    @date.strftime('%m/%Y')
  end

  def last_month
    @date.last_month.strftime('%m/%Y')
  end

  def next_month
    @date.next_month.strftime('%m/%Y')
  end

  def range
    @range ||= @date.beginning_of_month..@date.end_of_month
  end

  def last_year
    @year - 1
  end

  def next_year
    @year + 1
  end

  def range_year
    @range ||= @date.beginning_of_year..@date.end_of_year
  end

end
