//
//  PUSAPaymentOptionsVC.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift

class PUSAPaymentOptionsVC : UIViewController,UITableViewDelegate,UITableViewDataSource
{
  
  var netBankingSwiftArray = Array<AnyObject>()
  var cashCardArray = Array<AnyObject>()
  var emiArray = Array<AnyObject>()
  var savedCardArray = Array<AnyObject>()
  var oneTapArray = Array<AnyObject>()
  
  @IBOutlet weak var containerAmountTxnID: UIView!
  @IBOutlet weak var lblAmount: UILabel!
  @IBOutlet weak var lblTxnID : UILabel!
  
  @IBOutlet weak var tblPaymentOptions: UITableView!
  var paymentParam = PayUModelPaymentParams()
  var paymentOptinonsArray = NSMutableArray()
  
  
  override func viewDidLoad() {
    self.lblAmount.text = "Amount " + "\u{20B9} :" + self.paymentParam.amount!
    self.lblTxnID.text = "Txn ID: " + self.paymentParam.txnId!
    
    tblPaymentOptions.reloadData()
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    return paymentOptinonsArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell  = tableView.dequeueReusableCell(withIdentifier: "SimpleCell")
    
    let rect = CGRect(origin: CGPoint(x: 10,y :0), size: CGSize(width: 42, height: 36))
    var img = UIImageView.init(frame: rect)
    
    
    // let imageView = UIImageView(image : UIImage(named: "credit-card.png"))
    cell?.textLabel?.text = paymentOptinonsArray[(indexPath.row)] as? String
    cell?.accessoryType = .disclosureIndicator
    
    
    // set images to table
    if (cell?.textLabel?.text == "Credit Card/Debit Card")
    {
      img.image = UIImage(named: "credit-card.png")
      cell?.contentView.addSubview(img)
    }
    if (cell?.textLabel?.text == "Stored Card")
    {
      img.image = UIImage(named: "Saved Card.png")
      cell?.contentView.addSubview(img)
    }
    if (cell?.textLabel?.text == "NetBanking")
    {
      img.image = UIImage(named: "netBanking.png")
      cell?.contentView.addSubview(img)
    }
    if (cell?.textLabel?.text == "EMI")
    {
      img.image = UIImage(named: "EMI.png")
      cell?.contentView.addSubview(img)
    }
    if (cell?.textLabel?.text == "Cash Card")
    {
      img.image = UIImage(named: "CashCard.png")
      cell?.contentView.addSubview(img)
    }
    if (cell?.textLabel?.text == "PayU Money")
    {
      img.image = UIImage(named: "PayUmoney.png")
      cell?.contentView.addSubview(img)
      
    }
    if (cell?.textLabel?.text == "Sodexo")
    {
      img.image = UIImage(named: "Sodexo.png")
      cell?.contentView.addSubview(img)
      
    }
    if (cell?.textLabel?.text == "UPI")
    {
      img.image = UIImage(named: "UPI.png")
      cell?.contentView.addSubview(img)
      
    }
    
    
    //    if (cell?.textLabel?.text == "Credit Card/Debit Card")
    //    {
    //
    //      cell?.imageView?.image = UIImage(named: "card.png")
    //
    //
    return cell!
    
    
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
  {
    
    return 46
    
  }
  
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    //([[actualPaymentOption objectAtIndex:index] isEqual:PAYMENT_PG_CCDC])
    
    let indexPath = tableView.indexPathForSelectedRow //optional, to get from any UIButton for example
    
    let currentCell = tableView.cellForRow(at: indexPath!)!
    
    //print(currentCell.textLabel!.text)
    
    if (currentCell.textLabel!.text == PAYMENT_PG_CCDC)
    {
      let strBrd = UIStoryboard(name: "Main", bundle: nil)
      let ccdcVC = strBrd.instantiateViewController(withIdentifier: "PUSACCDCVC") as! PUSACCDCVC
      ccdcVC.params = paymentParam
      self.navigationController?.pushViewController(ccdcVC, animated: true)
    }
    else if (currentCell.textLabel!.text == PAYMENT_PG_STOREDCARD)
    {
      let strBrd = UIStoryboard(name: "Main", bundle: nil)
      let savedCardVC = strBrd.instantiateViewController(withIdentifier: "PUSASavedCardVC") as! PUSASavedCardVC
      
      savedCardVC.paymentParams = paymentParam
      savedCardVC.savedCardArray = savedCardArray
      
      self.navigationController?.pushViewController(savedCardVC, animated: true)
    }
    else if (currentCell.textLabel!.text == PAYMENT_PG_NET_BANKING)
    {
      let strBrd = UIStoryboard(name: "Main", bundle: nil)
      let netBankingVC = strBrd.instantiateViewController(withIdentifier: "PUSANetbankingVC") as! PUSANetbankingVC
      netBankingVC.netBankingArray = netBankingSwiftArray
      netBankingVC.paymentParams = paymentParam
      self.navigationController?.pushViewController(netBankingVC, animated: true)
    }
    else if (currentCell.textLabel!.text == PAYMENT_PG_CASHCARD)
    {
      let strBrd = UIStoryboard(name: "Main", bundle: nil)
      let cashCardVC = strBrd.instantiateViewController(withIdentifier: "PUSACashcardVC") as! PUSACashcardVC
      
      cashCardVC.cashCardArray = cashCardArray
      
      
      cashCardVC.paymentParams = paymentParam
      self.navigationController?.pushViewController(cashCardVC, animated: true)
    }
    else if (currentCell.textLabel!.text == PAYMENT_PG_EMI)
    {
      let strBrd = UIStoryboard(name: "Main", bundle: nil)
      let emiVC = strBrd.instantiateViewController(withIdentifier: "PUSAEMIVC") as! PUSAEMIVC
      emiVC.emiBanks = emiArray
      emiVC.paymentParams = paymentParam
      
      self.navigationController?.pushViewController(emiVC, animated: true)
    }
    else if (currentCell.textLabel!.text == PAYMENT_PG_PAYU_MONEY)
    {
      //        let strBrd = UIStoryboard(name: "Main", bundle: nil)
      //        let PayUmoneyVC = strBrd.instantiateViewController(withIdentifier: "PUSAPayUmoneyVC") as! PUSAPayUmoneyVC
      //        PayUmoneyVC.paymentParams = paymentParam
      //        self.navigationController?.pushViewController(PayUmoneyVC, animated: true)
      //      }
      
      let createRequest = PayUCreateRequest()
      
      createRequest.createRequest(withPaymentParam: paymentParam, forPaymentType: PAYMENT_PG_PAYU_MONEY) { (request, error) in
        
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
      
    else if (currentCell.textLabel!.text == PAYMENT_PG_SODEXO)
    {
      
      let createRequest = PayUCreateRequest()
      
      createRequest.createRequest(withPaymentParam: paymentParam, forPaymentType: PAYMENT_PG_SODEXO) { (request, error) in
        
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
      
    else if (currentCell.textLabel!.text == PAYMENT_PG_UPI)
    {
      
      let strBrd = UIStoryboard(name: "Main", bundle: nil)
      let upiVC = strBrd.instantiateViewController(withIdentifier: "PUSAUPI") as! PUSAUPI
      upiVC.paymentParams = paymentParam
      self.navigationController?.pushViewController(upiVC, animated: true)
    }
    
    
    
  }
  
  
  
  
}

