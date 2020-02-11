//
//  CameraViewModel.swift
//  SecretMessage
//
//  Created by Elano on 09/02/20.
//  Copyright © 2020 Elano. All rights reserved.
//

import AVFoundation
import UIKit

protocol CameraViewModelDelegate: class {
    func cameraViewModel(_ model: CameraViewModel, didGet result: Result<Bool, CameraViewModelError>)
}

final class CameraViewModel: NSObject {

    let wallet: Wallet
    let code: Observable<String>
    let message: String
    
    weak var delegate: CameraViewModelDelegate?
    
    private lazy var captureSession: AVCaptureSession = AVCaptureSession()
    private var previewLayer: AVCaptureVideoPreviewLayer?
    
    
    init(wallet: Wallet, message: String) {
        self.message = message
        self.wallet = wallet
        self.code = Observable<String>("")
    }
    
    func addCamera(to view: UIView) {
        
        if previewLayer != nil {
            return
        }
        
        if setup() {
            previewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(previewLayer!)
            
            startCapture()
        }
    }
    
    func startCapture() {
        if (!captureSession.isRunning ) {
            captureSession.startRunning()
        }
    }
    
    func stopCapture() {
        if (captureSession.isRunning ) {
            captureSession.stopRunning()
        }
    }
    
    private func setup() -> Bool {
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else {
            delegate?.cameraViewModel(self, didGet: .failure(.videoInput))
            return false
        }
        let videoInput: AVCaptureDeviceInput

        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            delegate?.cameraViewModel(self, didGet: .failure(.videoInput))
            return false
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            delegate?.cameraViewModel(self, didGet: .failure(.captureSession))
            return false
        }
        
        let metadataOutput = AVCaptureMetadataOutput()

        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)

            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            delegate?.cameraViewModel(self, didGet: .failure(.metadataOutput))
            return false
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = .resizeAspectFill
        
        return true
    }
    
    func validade(signature: String) {

        wallet.validatePersonalMessageSignature(signature, for: message) { (result) in
            self.delegate?.cameraViewModel(self, didGet: .success(result))
        }
    }
    
}

extension CameraViewModel: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        stopCapture()

        if let metadataObject = metadataObjects.first {
            
            guard
                let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
                let stringValue = readableObject.stringValue
                else {
                    delegate?.cameraViewModel(self, didGet: .failure(.noValue))
                    return
                }
            
            validade(signature: stringValue)
        }else {
            delegate?.cameraViewModel(self, didGet: .failure(.noValue))
        }
    }
}

//MARK: -
enum CameraViewModelError: Error {
    case videoInput
    case captureSession
    case metadataOutput
    case noValue
}
