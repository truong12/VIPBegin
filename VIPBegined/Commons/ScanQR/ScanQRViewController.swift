//
//  ScanQRViewController.swift
//  VIPBegined
//
//  Created by Phat Tran on 3/9/21.
//

import UIKit
import AVFoundation

protocol ScanQRViewControllerDelegate: class {
    func scanQRDidReceive(_ decodeCode: String)
}

class ScanQRViewController: BaseViewController {
    
    @IBOutlet fileprivate weak var frontView: UIView!
    @IBOutlet fileprivate weak var rectView: UIView!
    @IBOutlet fileprivate weak var cameraOverlayView: UIView!
    @IBOutlet fileprivate weak var flashButton: UIButton!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var alignLablel: UILabel!
    
    weak var delegate: ScanQRViewControllerDelegate?
    
    var qrCodeFrameView: UIView?
    private var videoPreviewLayer: AVCaptureVideoPreviewLayer?
    private var captureSession = AVCaptureSession()
    private let supportedCodeTypes = [AVMetadataObject.ObjectType.qr]
    private let captureMetadataOutput = AVCaptureMetadataOutput()
    
    var isEnableFlash = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func setupUIStyles() {
        titleLabel.text = "scan.qr.add.new.place".localized
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        enableScanQR()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

// MARK: - ScanQR
extension ScanQRViewController {
    fileprivate func enableScanQR() {
        // Get the back-facing camera for capturing videos
        let deviceDiscoverySession = AVCaptureDevice.default(for: .video)
        
        guard let captureDevice = deviceDiscoverySession else {
            print("Failed to get the camera device")
            return
        }
        
        checkCameraAccess()
        
        let scanRect = rectView.frame
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Set the input device on the capture session.
            captureSession.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            
            captureSession.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
        
        // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
        videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        videoPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        
        videoPreviewLayer?.frame = cameraOverlayView.layer.bounds
        
        cameraOverlayView.layer.addSublayer(videoPreviewLayer!)
        
        // Start video capture.
        captureSession.startRunning()
        
        if let cvRect = videoPreviewLayer?.metadataOutputRectConverted(fromLayerRect: scanRect) {
             captureMetadataOutput.rectOfInterest = cvRect
        }
        
        // Move the description and button to the front
        view.bringSubviewToFront(frontView)
        
        // Initialize QR Code Frame to highlight the QR code
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            cameraOverlayView.addSubview(qrCodeFrameView)
            cameraOverlayView.bringSubviewToFront(qrCodeFrameView)
        }
    }
    
    func checkCameraAccess() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .denied:
            print("Denied, request permission from settings")
            presentCameraSettings()
        case .restricted:
            print("Restricted, device owner must approve")
        case .authorized:
            print("Authorized, proceed")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { success in
                if success {
                    print("Permission granted, proceed")
                } else {
                    print("Permission denied")
                }
            }
        @unknown default:
            print("Unknown")
        }
    }
    
    func presentCameraSettings() {
        let title = "alert.title.camera.access".localized
        let message = "alert.body.camera.access".localized
        AppAlertManager.shared.openSettingAlert(withTitle: title,
                                                           andMessage: message,
                                                           fromViewController: self) { [weak self] (_) in
            self?.removeWithAnimate()
            
        }
    }
}

// MARK: - AVCaptureMetadataOutputObjectsDelegate

extension ScanQRViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ output: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from connection: AVCaptureConnection) {
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects.isEmpty {
            qrCodeFrameView?.frame = CGRect.zero
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                captureSession.stopRunning()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    self.removeWithAnimate { [self] _ in
                        guard let data = metadataObj.stringValue else { return }
                        let splitData = data.components(separatedBy: "=")
                        self.delegate?.scanQRDidReceive(splitData[0])
                        print(splitData)
                    }
                })
            }
        }
    }
    
}

// MARK: - Action
extension ScanQRViewController {
    @IBAction fileprivate func closeAction(_ sender: Any) {
        self.removeWithAnimate()
    }
    
    @IBAction fileprivate func flashAction(_ sender: Any) {
        isEnableFlash = !isEnableFlash
        if isEnableFlash {
            flashButton.setImage(UIImage(named: "ic_flash_on"), for: .normal)
        } else {
            flashButton.setImage(UIImage(named: "ic_flash_off"), for: .normal)
        }
        toggleTorch(onSwitch: isEnableFlash)
    }
    
    func toggleTorch(onSwitch: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if onSwitch == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
}
