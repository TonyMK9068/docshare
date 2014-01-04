module PagesHelper
  def format_local_time
    self.localtime.strftime("%b %d, %Y")
  end

end
