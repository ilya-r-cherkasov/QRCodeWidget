//
//  MainScreenPresenter.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit

protocol MainScreenPresenterProtocol: AnyObject {
    func viewDidLoad()
    func toCamera()
}

final class MainScreenPresenter {
    
    weak var view: MainScreenViewProtocol?
    
    private let cameraManager = CameraManager()
    
    private func setupCamera() {
        
    }
    
}

extension MainScreenPresenter: MainScreenPresenterProtocol {
    
    func toCamera() {
        cameraManager.startRecording()
    }
    
    func viewDidLoad() {
        view?.configureCameraLayer(cameraManager.videoLayer)
    }
    
}
