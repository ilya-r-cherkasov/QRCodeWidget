//
//  MainScreenViewController.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit
import AVFoundation

protocol MainScreenViewProtocol: UIViewController {
    func configureCameraLayer(_ layer: AVCaptureVideoPreviewLayer)
}

final class MainScreenViewController: UIViewController {
    
    var presenter: MainScreenPresenterProtocol?
    
    private lazy var startScanButton: UIButton = {
        let button = UIButton()
        button.setTitle("Start Scan!", for: .normal)
        button.sizeToFit()
        button.center = view.center
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5.0
        button.addTarget(self, action: #selector(toCamera), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        addSubviews()
        view.backgroundColor = .white
        title = "Main"
    }

    private func addSubviews() {
        view.addSubview(startScanButton)
    }
    
    @objc
    func toCamera() {
        presenter?.toCamera()
        startScanButton.isHidden = true
    }

}

extension MainScreenViewController: MainScreenViewProtocol {
    
    func configureCameraLayer(_ layer: AVCaptureVideoPreviewLayer) {
        layer.frame = UIScreen.main.bounds
        view.layer.addSublayer(layer)
    }
    
}
