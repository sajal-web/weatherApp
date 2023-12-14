//
//  DateTimeFormatter.swift
//  iWeather
//
//  Created by SENTIENTGEEKS on 14/12/23.
//
import Foundation
import UIKit
class DateTimeFormatter {

    static var timer: Timer?

    static func startUpdatingDateTime(labelToUpdate: UILabel) {
        // Schedule the timer to call the updateDateTime function every second
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateDateTime(_:)), userInfo: labelToUpdate, repeats: true)
    }

    static func stopUpdatingDateTime() {
        timer?.invalidate()
        timer = nil
    }

    @objc static func updateDateTime(_ timer: Timer) {
        guard let labelToUpdate = timer.userInfo as? UILabel else {
            return
        }

        // Get the current date and time
        let currentDate = Date()

        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy HH:mm:ss" // Customize the format as per your requirement

        // Format the date as a string
        let formattedDateTime = dateFormatter.string(from: currentDate)

        // Set the formatted date and time with day name into the UILabel
        labelToUpdate.text = formattedDateTime
    }
}

