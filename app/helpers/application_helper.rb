module ApplicationHelper
  #Data padrão
  def standart_date(date, caracter)
    date.strftime("%d#{caracter}%m#{caracter}%Y %H:%M:%S")
  end 
  #Corrige a diferença entre o banco de dados MySQL e o horário atual do sistema 
  def self.get_utc_time
     now = Time.now
     Time.utc(now.year, now.month, now.day, now.hour, now.min, now.sec)
   end
end
