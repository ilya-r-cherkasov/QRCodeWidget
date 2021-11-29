//
//  MainScreenViewController.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit
import AVFoundation
import WidgetKit

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
    
    private lazy var qrCodeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.bounds.size = CGSize(width: 300, height: 300)
        imageView.center = view.center
        imageView.backgroundColor = .clear
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        addSubviews()
        view.backgroundColor = .white
        QRCodeManager.shared.delegate = self
        title = "Main"
        
        if let userDefaults = UserDefaults(suiteName: "group.qrCodeSuite"),
           let data = userDefaults.object(forKey: "qrcode") as? Data {
            let image = UIImage(data: data)
            qrCodeImageView.image = image
        }
    }

    private func addSubviews() {
        view.addSubview(qrCodeImageView)
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

extension MainScreenViewController: QRCodeManagerDelegate {
    
    func obtainString(_ string: String) {
        qrCodeImageView.image = QRCodeManager.shared.generateQRCode(from: string)
    }
    
}
