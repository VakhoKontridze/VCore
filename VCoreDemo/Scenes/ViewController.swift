//
//  ViewController.swift
//  VCoreDemo
//
//  Created by Vakhtang Kontridze on 9/10/21.
//

import UIKit
import VCore

final class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        NetworkService.default.GET.json(
            endpoint: "https://jsonplaceholder.typicode.com/posts/1",
            headers: [:],
            parameters: [:],
            completion: { result in
                guard case .success(let data) = result else { fatalError() }
                print(data["id"].toInt ?? "-")
            }
        )

        NetworkService.default.POST.json(
            endpoint: "https://httpbin.org/post",
            headers: [
                "Accept": "application/json",
                "Content-Type": "application/json"
            ],
            parameters: [
                "app": "VCore"
            ],
            completion: { result in
                guard case .success(let data) = result else { fatalError() }
                print(data["json"].toJSON?["app"].toString ?? "-")
            }
        )

        NetworkService.default.PUT.json(
            endpoint: "https://httpbin.org/put",
            headers: [
                "Accept": "application/json",
                "Content-Type": "application/json"
            ],
            parameters: [
                "app": "VCore"
            ],
            completion: { result in
                guard case .success(let data) = result else { fatalError() }
                print(data["json"].toJSON?["app"].toString ?? "-")
            }
        )

        NetworkService.default.PATCH.json(
            endpoint: "https://httpbin.org/patch",
            headers: [
                "Accept": "application/json",
                "Content-Type": "application/json"
            ],
            parameters: [
                "app": "VCore"
            ],
            completion: { result in
                guard case .success(let data) = result else { fatalError() }
                print(data["json"].toJSON?["app"].toString ?? "-")
            }
        )

        NetworkService.default.DELETE.json(
            endpoint: "https://httpbin.org/delete",
            headers: [
                "Accept": "application/json",
                "Content-Type": "application/json"
            ],
            parameters: [
                "app": "VCore"
            ],
            completion: { result in
                guard case .success(let data) = result else { fatalError() }
                print(data["json"].toJSON?["app"].toString ?? "-")
            }
        )
    }
}
