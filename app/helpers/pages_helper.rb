module PagesHelper
  def format_local_time(time)
    time.localtime.strftime("%b %d, %Y")
  end

end
