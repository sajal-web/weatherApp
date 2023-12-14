//
//  WeatherData.swift
//  iWeather
//
//  Created by SENTIENTGEEKS on 14/12/23.
//

import Foundation
struct WeatherData : Codable {
  let name : String
    let main : Main
    let wind : Wind
    let clouds : Clouds
    let weather : [Weather]
}
struct Main : Codable {
    let temp : Double
    let humidity : Int
}
struct Weather : Codable {
    let description : String
    let id : Int
}
struct Wind : Codable {
    let speed : Double
}
struct Clouds : Codable {
    let all : Int
}
