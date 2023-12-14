//
//  ViewController.swift
//  iWeather
//
//  Created by SENTIENTGEEKS on 13/12/23.
//

import UIKit
import CoreLocation
class WeatherViewController: UIViewController {

    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var cityLabel: UIButton!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cloudPrecipitation: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    var weatherManager = WeatherManager()
    let locationManager = CLLocationManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherManager.delegate = self
        locationManager.delegate = self
        // Start updating the date and time with a timer
        DateTimeFormatter.startUpdatingDateTime(labelToUpdate: dateTimeLabel)
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
//        weatherManager.fetchWeather(lattitude: 22.58, longitude: 88.43)
        // Do any additional setup after loading the view.
    }
}

//MARK: - WeatherManagerDelegate
extension WeatherViewController : WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager : WeatherManager,weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.tempratureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.cityLabel.setTitle(weather.cityName, for: .normal)
            self.cloudPrecipitation.text = ("\(weather.precipitation)%")
            self.humidityLabel.text = ("\(weather.humidity)%")
            self.windSpeedLabel.text = ("\(weather.windSpeed) km/h")
            
        }
    }
    func didFaildWithError(error: Error) {
        print(error)
    }
}
//MARK: - CLLocationManagerDelegate

extension WeatherViewController : CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(lattitude: lat, longitude: lon)
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(animated)

           // Stop the timer when the view is no longer visible
           DateTimeFormatter.stopUpdatingDateTime()
       }
}
