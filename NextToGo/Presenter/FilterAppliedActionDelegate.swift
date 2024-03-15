//
//  FilterAppliedActionDelegate.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

@MainActor public protocol FilterAppliedActionDelegate: AnyObject {
    /*
     This function is expected to be called when `Apply Filters` button
     is tapped on filters screen and presenter will implement it to be notified
     */
    func filterDidApply(filter: RaceFilter)
}
