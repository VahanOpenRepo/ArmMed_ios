//
//  ScanQRViewController.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 7/18/21.
//

import UIKit
import AVFoundation
import Foundation
import ViewModel
import Shared
import Services

class ScanQRViewController: ViewController<ScanQRViewModel, ApplicationCoordinator>, StoryboardInstantiable, IUnitFormatter, AVCaptureMetadataOutputObjectsDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScanner()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if (captureSession?.isRunning == false) {
            captureSession.startRunning()
        }

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if (captureSession?.isRunning == true) {
            captureSession.stopRunning()
        }
    }

    private func setupScanner() {
        configCamera()
        addBlure()
    }

    override func bindViewModel(viewModel: ScanQRViewModel) {
        super.bindViewModel(viewModel: viewModel)

        viewModel.tokenRecived.subscribe(onNext: { [weak self] data in
            DispatchQueue.main.async {
                let profileNavModel = viewModel.getProfileNavigationModel()
                guard let self = self, let user = profileNavModel.user else { return }
                KeychainStorage.shared.setString(value: user.token, for: Environment.Keys.token.rawValue)
                self.coordinator.showTabBar(user: user)
            }

        }).disposed(by: disposeBag)
    }

    private func configCamera() {
        view.backgroundColor = UIColor.black
        captureSession = AVCaptureSession()
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            failed()
            return
        }
        
        let metadataOutput = AVCaptureMetadataOutput()
        
        if (captureSession.canAddOutput(metadataOutput)) {
            captureSession.addOutput(metadataOutput)
            
            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            metadataOutput.metadataObjectTypes = [.qr]
        } else {
            failed()
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer.frame = view.layer.bounds
        previewLayer.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer)
        
        captureSession.startRunning()
    }
    
    private func addBlure() {
        let pathBigRect = UIBezierPath(rect: view.layer.bounds)
        let pathSmallRect = UIBezierPath(rect: CGRect(x: view.layer.bounds.width/2 - 130, y: 120, width: 260, height: 260))

        pathBigRect.append(pathSmallRect)
        pathBigRect.usesEvenOddFillRule = true

        let fillLayer = CAShapeLayer()
        fillLayer.path = pathBigRect.cgPath
        fillLayer.fillRule = CAShapeLayerFillRule.evenOdd
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        blurEffectView.layer.mask = fillLayer
        view.add(subview: blurEffectView )
    }
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        viewModel.fetchData(loginString: code)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }

    override func handleError() {
        setupScanner()
    }

    deinit {
        print("Deinit ScanVC")
    }
}
