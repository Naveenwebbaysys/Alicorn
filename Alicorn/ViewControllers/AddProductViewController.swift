//
//  AddProductViewController.swift
//  Alicorn
//
//  Created by Mac on 24/05/23.
//

import UIKit

class AddProductViewController: UIViewController {
    
    var updateProductModelArray   = [Datum]()
    var isFromNewProduct = true
    @IBOutlet weak var productDescTF : UITextField!
    @IBOutlet weak var nmfcTF : UITextField!
    @IBOutlet weak var subTF : UITextField!
    @IBOutlet weak var classTF : UITextField!
    @IBOutlet weak var packageTypeTF : UITextField!
    @IBOutlet weak var lengthTF : UITextField!
    @IBOutlet weak var widthTF : UITextField!
    @IBOutlet weak var heightTF : UITextField!
    @IBOutlet weak var weightTF : UITextField!
    
    @IBOutlet weak var stackbleBtn : UIButton!
    @IBOutlet weak var hazBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isFromNewProduct == true
        {
            
        }
        else
        {
            print(self.updateProductModelArray[0].productDescription!)
            productDescTF.text = self.updateProductModelArray[0].productDescription!
            nmfcTF.text = "\(self.updateProductModelArray[0].nmfc!)"
            subTF.text = "\(self.updateProductModelArray[0].sub ?? 0)"
            classTF.text = "\(self.updateProductModelArray[0].datumClass!)"
            packageTypeTF.text = "\(self.updateProductModelArray[0].packageType!)"
            lengthTF.text = "\(self.updateProductModelArray[0].length ?? 0)"
            heightTF.text = "\(self.updateProductModelArray[0].height ?? 0)"
            widthTF.text = "\(self.updateProductModelArray[0].width ?? 0)"
            weightTF.text = "\(self.updateProductModelArray[0].weight ?? "0")"
        }
    }
    

    @IBAction func backbtnAction()
    {
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func stackablebtnAction()
    {
        if self.stackbleBtn.tag == 0
        {
             print("is -- Selected")
            self.stackbleBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            self.stackbleBtn.tag = 1
           
         }
        else
        {
            print("un -- Selected")
            self.stackbleBtn.setImage(UIImage(systemName: "square"), for: .normal)
            self.stackbleBtn.tag = 0
        }
    }
    @IBAction func hznbtnAction()
    {
        if self.hazBtn.tag == 0
        {
             print("is -- Selected")
            self.hazBtn.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            self.hazBtn.tag = 1
         }
        else
        {
            print("un -- Selected")
            self.hazBtn.setImage(UIImage(systemName: "square"), for: .normal)
            self.hazBtn.tag = 0
        }
    }
}
