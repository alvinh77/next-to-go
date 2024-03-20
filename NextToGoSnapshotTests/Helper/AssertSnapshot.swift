//
//  AssertSnapshot.swift
//  NextToGoSnapshotTests
//
//  Created by Alvin He on 20/3/2024.
//

import SnapshotTesting
import SwiftUI

@MainActor public func snapshotTest<Content: View>(
    view: Content,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    let viewController = TestHostingController(rootView: view)
    for configration in Configuration.configurations {
        viewController.overrideUserInterfaceStyle = configration.style
        assertSnapshot(
            of: viewController,
            as: .image(on: configration.image),
            file: file,
            testName: "\(testName)_\(configration.name)",
            line: line
        )
    }
}

@MainActor public func snapshotTest(
    viewController: UIViewController,
    file: StaticString = #file,
    testName: String = #function,
    line: UInt = #line
) {
    for configration in Configuration.configurations {
        viewController.overrideUserInterfaceStyle = configration.style
        assertSnapshot(
            of: viewController,
            as: .image(on: configration.image),
            file: file,
            testName: "\(testName)_\(configration.name)",
            line: line
        )
    }
}

struct Configuration: @unchecked Sendable {
    let image: ViewImageConfig
    let style: UIUserInterfaceStyle
    let name: String

    enum Device: String {
        case iPhone12Pro
        case iPhone12ProMax
    }

    static let configurations: [Configuration] = {
        var result = [Configuration]()
        for style in [UIUserInterfaceStyle.light, UIUserInterfaceStyle.dark] {
            for device in [Device.iPhone12Pro, Device.iPhone12ProMax] {
                for orientation in [
                    ViewImageConfig.Orientation.landscape,
                    ViewImageConfig.Orientation.portrait
                ] {
                    let image: ViewImageConfig = {
                        switch device {
                        case .iPhone12Pro:
                            return .iPhone12Pro(orientation)
                        case .iPhone12ProMax:
                            return .iPhone12ProMax(orientation)
                        }
                    }()
                    result.append(
                        .init(
                            image: image,
                            style: style,
                            name: "\(device.rawValue)_\(style.name)_\(orientation.name)"
                        )
                    )
                }
            }
        }
        return result
    }()
}

extension ViewImageConfig.Orientation {
    var name: String {
        switch self {
        case .landscape:
            return "landscape"
        case .portrait:
            return "portrait"
        }
    }
}

extension UIUserInterfaceStyle {
    var name: String {
        switch self {
        case .unspecified:
            return "unspecified"
        case .light:
            return "light"
        case .dark:
            return "dark"
        @unknown default:
            return "unknown"
        }
    }
}

private final class TestHostingController<Content: View>: UIHostingController<Content> {
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let size = view.sizeThatFits(
            CGSize(
                width: CGFloat.greatestFiniteMagnitude,
                height: CGFloat.greatestFiniteMagnitude
            )
        )
        preferredContentSize = CGSize(width: size.width, height: size.height)
        view.bounds.size = preferredContentSize
    }
}
