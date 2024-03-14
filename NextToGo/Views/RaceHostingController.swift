//
//  RaceHostingController.swift
//  NextToGo
//
//  Created by Alvin He on 14/3/2024.
//

import SwiftUI

public final class RaceHostingController<Content: View>: UIHostingController<Content> {
    weak var delegate: ViewControllerLifecycleDelegate?

    override init(rootView: Content) {
        super.init(rootView: rootView)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        delegate?.viewDidLoad()
    }
}
