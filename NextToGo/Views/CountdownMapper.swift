//
//  CountdownMapper.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

import Foundation

public struct CountdownMapper {
    public func map(date: Date, startTime: Int) -> String {
        let dateInSeconds = startTime - Int(date.timeIntervalSince1970)
        let absDateInSeconds = abs(dateInSeconds)
        let hours = absDateInSeconds / 3600
        let minutes = absDateInSeconds % 3600 / 60
        let seconds = absDateInSeconds % 60
        return String(
            format: "\(dateInSeconds >= 0 ? "": "-")%02d:%02d:%02d",
            hours,
            minutes,
            seconds
        )
    }
}
