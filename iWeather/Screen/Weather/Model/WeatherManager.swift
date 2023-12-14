//
//  WeatherManager.swift
//  iWeather
//
//  Created by SENTIENTGEEKS on 14/12/23.
//
import Foundation
protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager : WeatherManager,weather: WeatherModel)
    func didFaildWithError(error: Error)
}

struct WeatherManager{
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?&appid=3cdfdb85615ebae7095e0e9a4862b302&units=metric"
    var delegate : WeatherManagerDelegate?
    func fetchWeather(lattitude : Double, longitude : Double){
        let urlString = "\(weatherUrl)&lat=\(lattitude)&lon=\(longitude)"
        performRequest(urlString: urlString)
    }
    func fetchWeather(locationName : String){
        let urlString = "\(weatherUrl)&q=\(locationName)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString : String){
        // 1. Create url
        if let url = URL(string: urlString){
            print(url)
            // 2. Create a urlSession
            let session = URLSession(configuration: .default)
            // 3. Give urlsession a task
            let task = session.dataTask(with: url) { data, response, error in
                if(error != nil){
                    self.delegate?.didFaildWithError(error: error!)
                    return
                }
                if let safeData = data{
//                    let dataString = String(data: safeData, encoding: .utf8)
                    if let weather = self.parseJson(weatherData: safeData){
//                        let weatherViewController = WeatherViewController()
//                        weatherViewController.didUpdateWeather(weather: weather)
                        self.delegate?.didUpdateWeather(self,weather: weather)
                    }
                }
            }
            // start the task
            task.resume()
        }
    }
    func parseJson(weatherData : Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let temp = decodedData.main.temp
            let cityName = decodedData.name
            let precipitation = decodedData.clouds.all
            let humidity = decodedData.main.humidity
            let windSpeed = decodedData.wind.speed
            print(cityName)
            let id = decodedData.weather[0].id
            let weather = WeatherModel(conditionId: id, cityName: cityName, temprature: temp, precipitation: precipitation,humidity: humidity,windSpeed: windSpeed)
            return weather
        }catch{
            delegate?.didFaildWithError(error: error)
            return nil
        }
    }
}
