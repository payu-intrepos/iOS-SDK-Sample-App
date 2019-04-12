//
//  PUSANetbankingVC.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift

class PUSANetbankingVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  var netBankingArray = Array<AnyObject>()
  var paymentParams = PayUModelPaymentParams()
  
  @IBOutlet weak var containerAmountTxnID: UIView!
  @IBOutlet weak var lblMessage: UILabel!
  @IBOutlet weak var lblAmount: UILabel!
  
  @IBOutlet weak var lblTxnID: UILabel!
  //@IBOutlet weak var tblNetBanking: UITableView!
  @IBOutlet weak var lblSelectYourBank: UIButton!
  var tblNetBanking = UITableView()
  
  
  override func viewDidLoad() {
    
    self.lblAmount.text = "Amount " + "\u{20B9} :" + self.paymentParams.amount!
    self.lblTxnID.text = "Txn ID: " + self.paymentParams.txnId!
    
    
    createDynamicTable()
    tblNetBanking.isHidden = true
    
    lblMessage.text = "Note : You'll be redirected to Bank's website on the next screen"
    paymentParams.bankCode = ""
    
  }
  
  
  // MARK: Table View Delegate Methods
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    return netBankingArray.count
    
    
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "netBankingCell")
    
    cell = UITableViewCell.init(style: .subtitle, reuseIdentifier:"netBankingCell")
    
    var netBanking  = PUExtended ()
    
    netBanking = netBankingArray[indexPath.row] as! PUExtended
    
    //    cell?.textLabel?.text = netBanking.bankCode
    //    cell?.detailTextLabel?.text = netBanking.title
    
    cell?.textLabel?.text =  netBanking.title
    
    return cell!
  }
  
  //  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  //    return 44
  //
  //  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    // let currentCell  = tableView.cellForRow(at: indexPath)
    
    tblNetBanking.isHidden = true
    
    var netBanking  = PUExtended ()
    
    
    netBanking = self.netBankingArray[indexPath.row] as! PUExtended
    
    
    self.paymentParams.bankCode = netBanking.bankCode
    
    
    
    // know the status of bank
    let webService = PayUWebService()
    webService.getVASStatus(bankCodeOrCardBin: self.paymentParams.bankCode!) { (status, error) in
      if (status as! String != "")
      {
        self.lblMessage.textColor = UIColor.red
        self.lblMessage.text = status as! String
      }
      else
      {
        self.lblMessage.textColor = UIColor.black
        self.lblMessage.text = "Note : You'll be redirected to Bank's website on the next screen"
        
      }
    }
    
    // set Button's title
    self.lblSelectYourBank.setTitle("  " +  netBanking.title , for: UIControl.State.normal )
    
  }
  @IBAction func btnSelectYourBank(_ sender: UIButton) {
    
    
    tblNetBanking.isHidden = false
    
    tblNetBanking.reloadData()
    
    
  }
  
  // MARK: Create dynamic table function here
  
  func createDynamicTable () -> ()
  {
    // Get main screen bounds
    let screenSize: CGRect = UIScreen.main.bounds
    
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height - 64
    
    
    let rect = CGRect(origin:CGPoint(x: 0,y :64), size: CGSize(width: screenWidth, height: screenHeight))
    
    tblNetBanking = UITableView(frame: rect)
    tblNetBanking.dataSource = self
    tblNetBanking.delegate = self
    
    tblNetBanking.register(UITableViewCell.self, forCellReuseIdentifier: "netBankingCell")
    
    self.view.addSubview(tblNetBanking)
    
  }
  
  
  @IBAction func btnPayNow(_ sender: UIButton) {
    
    let createRequest = PayUCreateRequest()
    
    createRequest.createRequest(withPaymentParam: self.paymentParams, forPaymentType: PAYMENT_PG_NET_BANKING) { (request, error) in
      
      if (error == "")
      {
        
        let strBrd = UIStoryboard(name: "Main", bundle: nil)
        let webViewVC = strBrd.instantiateViewController(withIdentifier: "PUUIWebViewVC") as! PUUIWebViewVC
        webViewVC.request = request
        self.navigationController?.pushViewController(webViewVC, animated: true)
        
      }
      else
      {
        let alert = UIAlertController(title: "oops !", message: error as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
      }
    }
    
  }
  // MARK : Direct Payment Buttons
  @IBAction func btnAxis(_ sender: UIButton) {
    
    
    self.paymentParams.bankCode = "AXIB"
    let createRequest = PayUCreateRequest()
    
    createRequest.createRequest(withPaymentParam: self.paymentParams, forPaymentType: PAYMENT_PG_NET_BANKING) { (request, error) in
      
      if (error == "")
      {
        
        let strBrd = UIStoryboard(name: "Main", bundle: nil)
        let webViewVC = strBrd.instantiateViewController(withIdentifier: "PUUIWebViewVC") as! PUUIWebViewVC
        webViewVC.request = request
        self.navigationController?.pushViewController(webViewVC, animated: true)
        
      }
      else
      {
        print(error)
        let alert = UIAlertController(title: "oops !", message: error as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
      }
    }
    
  }
  
  
  @IBAction func btnICICI(_ sender: UIButton) {
    
    self.paymentParams.bankCode = "ICIB"
    let createRequest = PayUCreateRequest()
    
    createRequest.createRequest(withPaymentParam: self.paymentParams, forPaymentType: PAYMENT_PG_NET_BANKING) { (request, error) in
      
      
      
      
      
      if (error == "")
      {
        
        
        
        let strBrd = UIStoryboard(name: "Main", bundle: nil)
        let webViewVC = strBrd.instantiateViewController(withIdentifier: "PUUIWebViewVC") as! PUUIWebViewVC
        webViewVC.request = request
        self.navigationController?.pushViewController(webViewVC, animated: true)
        
      }
      else
      {
        let alert = UIAlertController(title: "oops !", message: error as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
      }
    }
    
  }
  @IBAction func btnSBI(_ sender: UIButton) {
    
    paymentParams.bankCode = "SBIB"
    let createRequest = PayUCreateRequest()
    
    createRequest.createRequest(withPaymentParam: self.paymentParams, forPaymentType: PAYMENT_PG_NET_BANKING) { (request, error) in
      
      
      if (error == "")
      {
        
        let strBrd = UIStoryboard(name: "Main", bundle: nil)
        let webViewVC = strBrd.instantiateViewController(withIdentifier: "PUUIWebViewVC") as! PUUIWebViewVC
        webViewVC.request = request
        self.navigationController?.pushViewController(webViewVC, animated: true)
        
      }
      else
      {
        let alert = UIAlertController(title: "oops !", message: error as String, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
      }
    }
    
  }
  
  
}
