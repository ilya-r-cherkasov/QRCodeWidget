//
//  MainScreenBuilder.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit

final class MainScreenBuilder {
    
    static func build() -> UIViewController {
        let view = MainScreenViewController()
        let presenter = MainScreenPresenter()
        view.presenter = presenter
        presenter.view = view
        return view
    }
    
}
