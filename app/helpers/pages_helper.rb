module PagesHelper
  def format_local_time(time)
    time.localtime.strftime("%b %d, %Y")
  end
  
  def format_local_date_time(datetime)
    datetime.localtime.strftime("%b %d, %Y %l:%M:%S %p")
  end

end
