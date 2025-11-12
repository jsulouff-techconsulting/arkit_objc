//
//  ocinterface.swift
//  ObjectiveCApp
//
//  Created by Joshua Sulouff on 11/12/25.
//

import Foundation
import SwiftUI

@objc
public class SwiftArInterface: NSObject {
    @MainActor @objc public func mkSwiftArViewUi() -> UIViewController {
        return UIHostingController(rootView: SwiftUIARView())
    }
}
