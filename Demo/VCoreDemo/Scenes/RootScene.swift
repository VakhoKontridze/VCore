//
//  RootScene.swift
//  VCoreDemo
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit
import SwiftUI
import VCore

// MARK: - View Controller
final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }
}

// MARK: - Content View
struct ContentView: View {
    var body: some View {
        Text("Lorem Ipsum")
    }
}
