//
//  SearchViewController.swift
//  Alicorn
//
//  Created by Mac on 04/05/23.
//

import UIKit
import AVFoundation
import AudioToolbox
import AudioToolbox.AudioServices
//import ViewAnimator
class SearchViewController:  UIViewController {
    
    @IBOutlet weak var searchTF : UITextField!
    @IBOutlet weak var menuAnimationView : UIView!
    
    @IBOutlet weak var segmentMenu: UISegmentedControl!
    let menuOpend = false
    @IBOutlet weak var btn1 : UIButton!
    @IBOutlet weak var btn2 : UIButton!
    @IBOutlet weak var btn3 : UIButton!
    @IBOutlet weak var btn4 : UIButton!
    @IBOutlet weak var btn5 : UIButton!
    @IBOutlet weak var btn6 : UIButton!
    @IBOutlet weak var btn7 : UIButton!
    @IBOutlet weak var btn8 : UIButton!
    @IBOutlet weak var btn9 : UIButton!
    @IBOutlet weak var btn10 : UIButton!
    
    var menuAnimationViewDownOffset: CGFloat!
    var menuAnimationViewUp: CGPoint!
    var menuAnimationViewDown: CGPoint!
    var barCodeBGView  = UIView()
    var captureSession: AVCaptureSession!
    var previewLayer: AVCaptureVideoPreviewLayer!
    
    var yCenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var filterSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuAnimationViewUp = CGPoint(x: 0 ,y: self.filterSegment.frame.origin.y)
        menuAnimationViewDown = CGPoint(x: 0 ,y: view.height - 130)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPan(_:)))
        menuAnimationView.addGestureRecognizer(panGestureRecognizer)
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.lightGray, NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
        segmentMenu.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmentMenu.setTitleTextAttributes(titleTextAttributes, for: .selected)
    }
    
    @objc private func didPan(_ sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: view)
        // User tapped at the point above. Do something with that if you want.
        print(velocity.y)
        if velocity.y > 0 {
            UIView.animate(withDuration: 0.3) {
//                self.menuAnimationView.frame.origin = self.menuAnimationViewDown
                self.menuAnimationView.frame.origin.y = self.view.height - 130
            }
        } else {
            UIView.animate(withDuration: 0.3) {
//                self.menuAnimationView.frame.origin = self.menuAnimationViewUp
                self.menuAnimationView.frame.origin.y = self.filterSegment.frame.maxY
            }
        }
    }
    
    @IBAction func searchBtnAction(sender : UIButton){
        
    }
    
    
    @IBAction func backBtnAction(_ sender : UIButton)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction  func barCodeBtnAction(_ sender : UIButton)
    {
        barCode()
    }
    
    func barCode(){
        view.backgroundColor = UIColor.white
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
            metadataOutput.metadataObjectTypes = [.ean8, .ean13, .pdf417]
        } else {
            failed()
            return
        }
        let closeBtn = UIButton(frame: CGRect(x: 20, y: 20, width: 50, height: 50))
        closeBtn.setImage(UIImage(systemName: "clear"), for: .normal)
        closeBtn.addTarget(self, action: #selector(closeBarCodeView), for: .touchUpInside)
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //        previewLayer.frame = view.layer.bounds
        previewLayer.frame = CGRect(x: 0, y: 200, width: view.width, height: 300)
        previewLayer.videoGravity = .resizeAspectFill
        barCodeBGView = UIView(frame: view.layer.bounds)
        barCodeBGView.backgroundColor = UIColor.lightGray
        //        view.layer.addSublayer(previewLayer)
        self.view.addSubview(self.barCodeBGView)
        self.barCodeBGView.layer.addSublayer(self.previewLayer)
        barCodeBGView.addSubview(closeBtn)
        DispatchQueue.global(qos: .background).async {
            self.captureSession.startRunning()
        }
        
    }
    
    @objc func closeBarCodeView (){
        barCodeBGView.removeFromSuperview()
    }
}



extension SearchViewController : AVCaptureMetadataOutputObjectsDelegate
{
    
    func failed() {
        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning a code from an item. Please use a device with a camera.", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
        captureSession = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if (captureSession?.isRunning == false) {
            DispatchQueue.global(qos: .background).async {
                self.captureSession.startRunning()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if (captureSession?.isRunning == true) {
            self.captureSession.stopRunning()
        }
    }
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        captureSession.stopRunning()
        
        if let metadataObject = metadataObjects.first {
            guard let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject else { return }
            guard let stringValue = readableObject.stringValue else { return }
            AudioServicesPlaySystemSound(SystemSoundID(kSystemSoundID_Vibrate))
            AudioServicesPlayAlertSound (1105)
            found(code: stringValue)
        }
        
        dismiss(animated: true)
    }
    
    func found(code: String) {
        print(code)
        
        barCodeBGView.removeFromSuperview()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    
}



