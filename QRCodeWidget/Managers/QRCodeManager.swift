//
//  QRCodeManager.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit
import AVFoundation

class QRCodeManager: NSObject {
    
    static let shared = QRCodeManager()
    private override init() {}
    
    func detectQRCode(from output: AVCaptureMetadataOutput) {
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    }
    
}

extension QRCodeManager: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        guard let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject,
        object.type == AVMetadataObject.ObjectType.qr else {
            return
        }
        print(object.stringValue ?? "")
    }
    
}
