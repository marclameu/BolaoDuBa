module ApplicationHelper
  #Data padrão
  def standart_date(date, caracter)
    date.strftime("%d#{caracter}%m#{caracter}%Y %H:%M:%S")
  end  
end
