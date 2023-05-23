//
//  ProductListViewController.swift
//  Alicorn
//
//  Created by Mac on 23/05/23.
//

import UIKit
import Alamofire
import MBProgressHUD

class ProductListViewController: UIViewController {
    
    var bgv = UIView()
    @IBOutlet weak var productsTB : UITableView!
    @IBOutlet weak var productDetailsView : UIView!
    @IBOutlet weak var productDescLbl : UILabel!
    @IBOutlet weak var nmfcLbl : UILabel!
    @IBOutlet weak var subLbl : UILabel!
    @IBOutlet weak var classLbl : UILabel!
    @IBOutlet weak var packageTypeLbl : UILabel!
    @IBOutlet weak var lengthLbl : UILabel!
    @IBOutlet weak var stackableLbl : UILabel!
    
    
    
    
    var productModelArray   = [Datum]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.productsTB.delegate = self
        self.productsTB.dataSource = self
        self.productsTB.register(UINib(nibName: "ProductListTableViewCell", bundle: nil), forCellReuseIdentifier: "ProductListTableViewCell")
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.productDetailsView.isHidden = true
        if Reachability.isConnectedToNetwork()
        {
            productListAPICall()
        }
        else
        {
            showToast(message: "Please check your Internet connection")
        }
    }
    
    func productListAPICall() {
        print(baseURL + productAPI)
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AF.request(baseURL + productAPI, method: .get, headers: headers).response { productResponse in
            MBProgressHUD.hide(for: self.view, animated: true)
            if productResponse.response?.statusCode == 200
            {
                let productsResponseModel = try? JSONDecoder().decode(ProductsResponseModel.self, from: productResponse.data!)
                self.productModelArray = (productsResponseModel?.data!)!
                print(self.productModelArray[0].productDescription!)
                self.productsTB.reloadData()
            }
            else
            {
                let jsonResponse = try! JSONSerialization.jsonObject(with: productResponse.data!, options: .allowFragments) as? [String: Any]
                print(jsonResponse?["error"] ?? "")
            }
        }
    }
    
    func deleteProductAPICall(id : Int)
    {
        print(baseURL + deleteProductAPI + "\(id)")
        let deleteAPI = baseURL + deleteProductAPI + "\(id)"
        MBProgressHUD.showAdded(to: self.view, animated: true)
        AF.request(deleteAPI, method: .delete, headers: headers).response { deleteResponse in
            MBProgressHUD.hide(for: self.view, animated: true)
            if deleteResponse.response?.statusCode == 200
            {
                let jsonResponse = try! JSONSerialization.jsonObject(with: deleteResponse.data!, options: .allowFragments) as? [String: Any]
                print(jsonResponse?["message"] ?? "")
                self.productModelArray.removeAll(where: { $0.id == id})
                print(self.productModelArray.count)
                self.productsTB.reloadData()
            }
            else
            {
                let jsonResponse = try! JSONSerialization.jsonObject(with: deleteResponse.data!, options: .allowFragments) as? [String: Any]
                print(jsonResponse?["error"] ?? "")
            }
        }
    }
    
    @IBAction func okBtnAction()
    {
        self.productDetailsView.isHidden = true
        bgv.removeFromSuperview()

    }
}


extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productModelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductListTableViewCell", for: indexPath) as! ProductListTableViewCell
        let serialNo = indexPath.row + 1
        cell.productDescLbl.text = "\(serialNo)" + ". " + self.productModelArray[indexPath.row].productDescription!
        cell.nmfcLbl.text =        "NMFC : " + "\(self.productModelArray[indexPath.row].nmfc!)"
        cell.packageTypeLbl.text = "Package Type : "  + "\(self.productModelArray[indexPath.row].packageType!)"
        cell.editBtn.addTarget(self, action: #selector(deleteProduct(sender:)), for: .touchUpInside)
        cell.deleteBtn.addTarget(self, action: #selector(editProduct(sender:)), for: .touchUpInside)
        cell.editBtn.tag = indexPath.row
        cell.deleteBtn.tag = indexPath.row
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.productDetailsView.isHidden = false
   
        bgv = UIView(frame: view.frame)
        bgv.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(bgv)
        view.bringSubviewToFront(self.productDetailsView)
        self.productDescLbl.text = self.productModelArray[indexPath.row].productDescription!
        self.nmfcLbl.text = "\(self.productModelArray[indexPath.row].nmfc!)"
        subLbl.text = "\(self.productModelArray[indexPath.row].sub!)"
        classLbl.text = "\(self.productModelArray[indexPath.row].packageType!)"

        
    }
    
    @objc func deleteProduct (sender : UIButton)
    {
        
    }
    
    @objc func editProduct (sender : UIButton)
    {
        let productId = self.productModelArray[sender.tag].id
//        self.deleteProductAPICall(id: productId!)
        self.productModelArray.removeAll(where: { $0.id == productId})
        print(self.productModelArray.count)
        self.productsTB.reloadData()
    }
}
