//
//  FilterViewController.swift
//  Alicorn
//
//  Created by Mac on 11/05/23.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
    var hasSetPointOrigin = false
      var pointOrigin: CGPoint?
    
    let topView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .red
        return view
    }()
    let topDarkLine: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 3
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        
        if !hasSetPointOrigin {
                  hasSetPointOrigin = true
                  pointOrigin = self.view.frame.origin
              }
        setupViews()
    }
   
    
    func setupViews() {
        view.addSubview(topView)
        topView.snp.makeConstraints { (make) in
                    make.top.left.right.equalToSuperview()
                    make.height.equalTo(50)
            
                }
        
                topView.addSubview(topDarkLine)
                topDarkLine.snp.makeConstraints { (make) in
                    make.top.equalToSuperview().offset(12)
                    make.height.equalTo(6)
                    make.width.equalToSuperview().multipliedBy(0.15)
                    make.centerX.equalToSuperview()
                }
          let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognizerAction))
          topView.addGestureRecognizer(panGesture)
        
      }
    
    @objc func panGestureRecognizerAction(sender: UIPanGestureRecognizer) {
         let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
         // Not allowing the user to drag the view upward
         guard translation.y >= 0 else { return }

         // setting x as 0 because we don't want users to move the frame side ways!! Only want straight up or down
         view.frame.origin = CGPoint(x: 0, y: 50)
         print(view.frame)

         if sender.state == .ended {
             let dragVelocity = sender.velocity(in: view)
             if dragVelocity.y >= 1300 {
                 // Velocity fast enough to dismiss the uiview
                 self.dismiss(animated: true, completion: nil)
             } else {
                 // Set back to original position of the view controller
                 UIView.animate(withDuration: 0.3) {
                     self.view.frame.origin = self.pointOrigin ?? CGPoint(x: 0, y: 400)
                 }
             }
         }
     }
   
}
