//
//  OBQRCodeScannerViewController.swift
//  OpenBank
//
//  Created by Aleksander Evtuhov on 16/09/2017.
//  Copyright © 2017 Aleksander Evtuhov. All rights reserved.
//

import UIKit
import AVFoundation

class OBQRCodeScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    
    @IBOutlet weak var QRCodeLabel: UILabel!
  
    
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var qrCodeFrameView:UIView?
    let supportedCodeTypes = [AVMetadataObjectTypeUPCECode,
                              AVMetadataObjectTypeCode39Code,
                              AVMetadataObjectTypeCode39Mod43Code,
                              AVMetadataObjectTypeCode93Code,
                              AVMetadataObjectTypeCode128Code,
                              AVMetadataObjectTypeEAN8Code,
                              AVMetadataObjectTypeEAN13Code,
                              AVMetadataObjectTypeAztecCode,
                              AVMetadataObjectTypePDF417Code,
                              AVMetadataObjectTypeQRCode]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get an instance of the AVCaptureDevice class to initialize a device object and provide the video as the media type parameter.
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        do {
            // Get an instance of the AVCaptureDeviceInput class using the previous device object.
            let input = try AVCaptureDeviceInput(device: captureDevice)
            
            // Initialize the captureSession object.
            captureSession = AVCaptureSession()
            
            // Set the input device on the capture session.
            captureSession?.addInput(input)
            
            // Initialize a AVCaptureMetadataOutput object and set it as the output device to the capture session.
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            
            // Set delegate and use the default dispatch queue to execute the call back
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = supportedCodeTypes
            
            // Initialize the video preview layer and add it as a sublayer to the viewPreview view's layer.
            videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            videoPreviewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(videoPreviewLayer!)
            
            // Start video capture.
            captureSession?.startRunning()
            
            // Move the message label and top bar to the front
            view.bringSubview(toFront: QRCodeLabel)
            //view.bringSubview(toFront: topbar)
            
            // Initialize QR Code Frame to highlight the QR code
            qrCodeFrameView = UIView()
            
            if let qrCodeFrameView = qrCodeFrameView {
                qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
                qrCodeFrameView.layer.borderWidth = 2
                view.addSubview(qrCodeFrameView)
                view.bringSubview(toFront: qrCodeFrameView)
            }
            
        } catch {
            // If any error occurs, simply print it out and don't continue any more.
            print(error)
            return
        }
    }
    
    var flag:Bool = false
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        // Check if the metadataObjects array is not nil and it contains at least one object.
        if metadataObjects == nil || metadataObjects.count == 0 {
            qrCodeFrameView?.frame = CGRect.zero
            QRCodeLabel.text = "No QR/barcode is detected"
            return
        }
        
        // Get the metadata object.
        let metadataObj = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        if supportedCodeTypes.contains(metadataObj.type) {
            // If the found metadata is equal to the QR code metadata then update the status label's text and set the bounds
            let barCodeObject = videoPreviewLayer?.transformedMetadataObject(for: metadataObj)
            qrCodeFrameView?.frame = barCodeObject!.bounds
            
            if metadataObj.stringValue != nil {
                QRCodeLabel.text = metadataObj.stringValue
                var string = metadataObj.stringValue!
                
                //string = OBJKHCodeParser.ex
                
                if(string.contains("bank://")){
                    
                    let alert = UIAlertController(title: "Alert", message: "Успешно получен код", preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                        print("Handle Ok logic here")
                        self.dismiss(animated: true, completion: nil)
                        
                        
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "OBTransferViewController") as! OBTransferViewController
                        let array = string.components(separatedBy: "bank://")
                        viewController.encodedData = array[1];
                        self.navigationController?.pushViewController(viewController, animated: true)
                        
                    }))
                    
                   
                    
                    
                    
                }
                else if(OBJKHCodeParser.validateCode(code: string)){
                    
//                    let alert = UIAlertController(title: "Alert", message: "Успешно получен код", preferredStyle: UIAlertControllerStyle.alert)
//                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
//                        print("Handle Ok logic here")
//                        sleep(5)
//                        self.dismiss(animated: true, completion: nil)
                    
                        
                        var dataDictionary = OBJKHCodeParser.getAccountDictionary(code: string)
                        // add segue
                        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
                        let viewController = storyboard.instantiateViewController(withIdentifier: "OBTransferViewController") as! OBTransferViewController
                        //let array = url.absoluteString.components(separatedBy: "bank://")
                        viewController.accountDictionary = dataDictionary
                        OBTransferType.transferType = .linkTransfer
                        viewController.JKHMArker = true
                    
                    if(!flag){
                        self.navigationController?.pushViewController(viewController, animated: true)
                    }
                    flag = true
//                    }))
//                    self.present(alert, animated: true, completion: nil)
//                    
                    
                }
            }
        }
    }
    
    
    @IBAction func goBack(_ sender: OBBackBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    

}

