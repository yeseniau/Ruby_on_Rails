#Requerimientos
#1. Crear el método request que reciba una url y retorne el hash con los resultados.

require "uri"
require "net/http"
require 'json'

def request(url_requested)
  url = URI(url_requested) # recibe la url a consultar
  http = Net::HTTP.new(url.host, url.port)
  http.use_ssl = true # pregunta si esta usa certificado ssl
  #http.verify_mode = OpenSSL::SSL::VERIFY_NONE # esta linea no verifica la MIM vulnerabilidad
  http.verify_mode = OpenSSL::SSL::VERIFY_PEER # colocar este parametro PEER para evitar la vulnerabilidad 
  request = Net::HTTP::Get.new(url)
  request['cache-control'] = 'no-cache'
  request['postman-token'] = '5f4b1b36-5bcd-4c49-f578-75a752af8fd5'
  response = http.request(request)
  return JSON.parse(response.read_body) #retora un hash
end

data = request('https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10&api_key=tSG4tzoga8Sgy7dv7ouLgV4chKj5wkisJUsuGQDQ')

puts "-------resultado de JSON parceador------------"
puts data
puts "-------entrando al hash en la posicion 0-------"
puts data['photos'][0]
puts "-------entrando al hash en la posicion 0 e identificando en nombre de la camara---------"
puts data['photos'][0]['camera']['name']
puts 


#2. Crear un método llamado buid_web_page que reciba el hash de respuesta con todos los datos y construya una página web.

def buil_web_page(respuesta)
  cuerpo='<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Api Nasa</title>
</head>
<body>
<h1>Recorriendo Api de la Nasa</h1>
<ul>
'
 cuerpo= cuerpo + respuesta + '</ul>
</body>
</html>'
  
  File.write("apinasa.html", cuerpo)
end

#3. Crear un método photos_count que reciba el hash de respuesta y 
# devuelva un nuevo hash con el nombre de la cámara y la cantidad de fotos
# tambien devuelve las imagenes de existentes

def photos_camara(respuesta)
  resultado = {}

  respuesta["photos"].each do |foto|
    camera_name = foto["camera"]["name"]
    count = resultado[camera_name] || 0
    resultado[camera_name] = count + 1
  end
  
  puts resultado    #has resultante con nombre de la camara y cantidad de fotos
    
  html=""
  resultado.each do |camera_name, count|
      html= html+ "<p> La Camara #{camera_name} tiene #{count} fotos</p>\n"
  end 
  html  

  imagen=""
  respuesta['photos'].each do |foto|
    imagen = imagen + "<li><img src='#{foto['img_src']}' alt=""></li>\n"
  end

  html= html + imagen

end

resultado = photos_camara(data)

puts resultado  #resultado a imprimir en el archivo html

buil_web_page(resultado)