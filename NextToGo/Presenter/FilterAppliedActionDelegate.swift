//
//  FilterAppliedActionDelegate.swift
//  NextToGo
//
//  Created by Alvin He on 15/3/2024.
//

@MainActor public protocol FilterAppliedActionDelegate: AnyObject {
    func filterDidApply(filter: RaceFilter)
}
