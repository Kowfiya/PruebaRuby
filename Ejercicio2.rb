require 'uri'
require 'net/http'
require 'json'

def request(url, api_key = "K6j0PyEOPtrGodgBdrx5qr6Detq9L7d7Ffoi02pQ")
    url = URI("#{url}&api_key=#{api_key}")
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true
    request = Net::HTTP::Get.new(url)
    request["cache-control"] = 'no-cache'
    request["Postman-Token"] = '2178e596-b98d-4395-bfa7-e0ac0e2df059'
    response = http.request(request)
    JSON.parse(response.read_body)
end

def buid_web_page(hash)
    archivo_html = File.open("index.html", "w")
    archivo_html.puts("<html>\n\t<head>\n\t\t\t<title>Niño nasa</title>\n\t</head>\n\t<body>\n\t\t<h1>Imagenes del niño nasa</h1>\n\t\t<ul>")
    hash["photos"].each do |imagen|
        archivo_html.puts("\t\t\t<li><img src=\"#{imagen["img_src"]}\"></li>")
    end
    archivo_html.puts("\t\t</ul>\n\t</body>\n</html>")
    archivo_html.close
end

def photos_count(hash)
    camaras = {"CHEMCAM" => 0, "MAHLI" => 0, "NAVCAM" => 0}
    hash["photos"].each do |camara|
        camaras[camara["camera"]["name"]] += 1
    end
    return(camaras)
end
data = request("https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=10")
buid_web_page(data)
print(photos_count(data))
print("\n")