//
//  QRCodeManager.swift
//  QRCodeWidget
//
//  Created by Ilya Cherkasov on 28.11.2021.
//

import UIKit
import AVFoundation
import WidgetKit

protocol QRCodeManagerDelegate: AnyObject {
    func obtainString(_ string: String)
}

class QRCodeManager: NSObject {
    
    static let shared = QRCodeManager()
    weak var delegate: QRCodeManagerDelegate?
    weak var currentImage: UIImage?
    private override init() {}
    
    func detectQRCode(from output: AVCaptureMetadataOutput) {
        output.setMetadataObjectsDelegate(self, queue: .main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 20, y: 20)

            if let output = filter.outputImage?.transformed(by: transform) {
                let image = UIImage(ciImage: output)
                writeImage(image)
                return image
            }
        }

        return nil
    }
    
    func writeImage(_ image: UIImage?) {
        if let pngRepresentation = image?.pngData(),
           let userDefaults = UserDefaults(suiteName: "group.qrCodeSuite") {
            userDefaults.set(pngRepresentation, forKey: "qrcode")
            userDefaults.synchronize()
            WidgetCenter.shared.reloadAllTimelines()
        }
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
        delegate?.obtainString(object.stringValue ?? "")
    }
    
}
