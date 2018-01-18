//
//  PUSACashcardVC.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift

class PUSACashcardVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
  var cashCardArray = Array<AnyObject>()
  var paymentParams = PayUModelPaymentParams()
  var tblCashCard = UITableView()
  
  @IBOutlet weak var lblMessage: UILabel!
  @IBOutlet weak var containerAmountTxnID: UIView!
  @IBOutlet weak var lblSelectYourBank: UIButton!
  @IBOutlet weak var lblTxnID: UILabel!
  @IBOutlet weak var lblAmount: UILabel!
  
  override func viewDidLoad() {
    
    
    self.lblAmount.text = "Amount " + "\u{20B9} :" + self.paymentParams.amount!
    self.lblTxnID.text = "Txn ID: " + self.paymentParams.txnId!
    
    tblCashCard.reloadData()
    createDynamicTable()
    tblCashCard.isHidden = true
    
    
    self.lblMessage.text = "Note : You'll be redirected to Bank's website on the next screen"
    paymentParams.bankCode = ""
    
  }
  
  
  // MARK: Table View Delegate Methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return cashCardArray.count
    
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = tableView.dequeueReusableCell(withIdentifier: "cashCardCell")
    
    cell = UITableViewCell.init(style: .subtitle, reuseIdentifier:"cashCardCell")
    
    var cashCard = PUExtended()
    
    cashCard = cashCardArray[indexPath.row] as! PUExtended
    
    // cell?.textLabel?.text = cashCard.bankCode
    cell?.detailTextLabel?.text = cashCard.title
    
    return cell!
    
  }
  
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
  {
    
    
    var cashCard = PUExtended()
    
    cashCard = cashCardArray[indexPath.row] as! PUExtended
    
    paymentParams.bankCode = cashCard.bankCode
    // if wallet is City Reward points
    if (paymentParams.bankCode == "CPMC")
    {
      enforcementPaymentCode = true
      paymentParams.enforcedCashCardParam = "CPMC"
    }
    else
    {
      enforcementPaymentCode = false
    }
    
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
    
    self.lblSelectYourBank.setTitle("  " + cashCard.title, for: UIControlState.normal)
    
    tblCashCard.isHidden = true
    
  }
  
  
  
  func createDynamicTable () -> ()
  {
    // Get main screen bounds
    let screenSize: CGRect = UIScreen.main.bounds
    
    let screenWidth = screenSize.width
    let screenHeight = screenSize.height - 64
    
    
    let rect = CGRect(origin:CGPoint(x: 0,y :64), size: CGSize(width: screenWidth, height: screenHeight))
    
    tblCashCard = UITableView(frame: rect)
    tblCashCard.dataSource = self
    tblCashCard.delegate = self
    
    tblCashCard.register(UITableViewCell.self, forCellReuseIdentifier: "cashCardCell")
    
    self.view.addSubview(tblCashCard)
    
  }
  
  @IBAction func btnSelectYourBank(_ sender: UIButton) {
    
    
    
    self.tblCashCard.isHidden = false
    self.tblCashCard.reloadData()
    
    
  }
  
  @IBAction func btnPayNow(_ sender: UIButton) {
    
    let createRequest = PayUCreateRequest()
    
    createRequest.createRequest(withPaymentParam: paymentParams, forPaymentType: PAYMENT_PG_CASHCARD) { (request, error) in
      
      if (error == "")
      {
        
        
        let strBrd = UIStoryboard(name: "Main", bundle: nil)
        
        let webViewVC = strBrd.instantiateViewController(withIdentifier: "PUUIWebViewVC") as! PUUIWebViewVC
        webViewVC.request = request
        
        self.navigationController?.pushViewController(webViewVC, animated: true)
        
      }
      else
      {
        let alert = UIAlertController(title: "oops !", message: error as String, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
      }
    }
    
  }
  
  
}
