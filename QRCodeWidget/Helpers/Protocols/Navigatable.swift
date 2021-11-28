//
//  Navigatable.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit

protocol Navigatable: UIViewController {
    func push(_ vc: UIViewController)
    func pop(_ vc: UIViewController)
    func popLast()
}

extension Navigatable {
    
    func push(_ vc: UIViewController) {
        navigationController?.push(vc)
    }
    
    func pop(_ vc: UIViewController) {
        navigationController?.pop(vc)
    }
    
    func popLast() {
        guard let lastVC = navigationController?.viewControllers.last else {
            return
        }
        navigationController?.pop(lastVC)
    }
    
}
