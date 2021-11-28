//
//  CameraManager.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import AVFoundation

final class CameraManager {

    lazy var videoLayer: AVCaptureVideoPreviewLayer = {
        AVCaptureVideoPreviewLayer(session: session)
    }()
        
    private let session = AVCaptureSession()
    private let captureDevice = AVCaptureDevice.default(for: .video)
    
    init() {
        setupVideoInput()
        setupVideoOutput()
    }
    
    func startRecording() {
        session.startRunning()
    }
    
    func stopRecording() {
        session.stopRunning()
    }
    
    private func setupVideoInput() {
        do {
            guard let captureDevice = captureDevice else {
                return
            }
            let input = try AVCaptureDeviceInput(device: captureDevice)
            session.addInput(input)
        } catch let error {
            print(error)
        }
    }
    
    private func setupVideoOutput() {
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        QRCodeManager.shared.detectQRCode(from: output)
    }
    
}
