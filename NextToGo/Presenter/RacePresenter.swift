//
//  RacePresenter.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import Combine

public protocol RacePresenterProtocol: ObservableObject {
    var viewState: ViewState<RaceListViewModel, ActionViewModel> { get }
}
