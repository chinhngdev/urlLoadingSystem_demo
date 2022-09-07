import UIKit

struct CurrentWeatherData: Codable {
    var coord: [String: Double]
    var weather: [Weather]
    var base: String
    var main: Main
    var name: String
}

struct Weather: Codable {
    var id: Int
    var main: String
    var description: String
    var icon: String
}

struct Main: Codable {
    var temp: Double
    var feels_like: Double
    var temp_min: Double
    var temp_max: Double
    var pressure: Double
    var humidity: Double
    var sea_level: Double
    var grnd_level: Double
}

func decode(data: Data) {
    let decoder = JSONDecoder()
    do {
        let currentWeatherData = try decoder.decode(CurrentWeatherData.self, from: data)
        print(currentWeatherData.name)
        print(currentWeatherData.coord)
        print(currentWeatherData.weather[0])
        print(currentWeatherData.main)
    } catch {
        print(error)
    }
}

let apiKey = "ae2759b5f89ae4b3846ca1d230f8ecb5"
let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=21.02&lon=105.80&appid=\(apiKey)"
if let url = URL(string: urlString) {
    // 1 - Create an URLSession with default configuration
    let session = URLSession(configuration: .default)
    // 2 - Create an URLSessionDataTask instance
    let dataTask = session.dataTask(with: url) { data, response, error in
        if let data = data {
            decode(data: data)
        } else if let error = error {
            print(error.localizedDescription)
        }
    }
    dataTask.resume()
}
