//
//  ViewController.swift
//  VCoreDemo
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit
import SwiftUI
import VCore

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let button: SomeButton = {
            let button: SomeButton = .init(
                title: "Lorem Ipsum",
                action: { print("Clicked") }
            )
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: -40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

struct ContentView: View {
    var body: some View {
        Text("Lorem Ipsum")
    }
}
