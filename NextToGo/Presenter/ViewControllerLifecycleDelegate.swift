//
//  ViewControllerLifecycleDelegate.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

@MainActor public protocol ViewControllerLifecycleDelegate: AnyObject {
    /*
     To get notified from UIViewController's `viewDidLoad` event and then
     load data from backend. Normally will be implement by Presenter
     */
    func viewDidLoad()
}
