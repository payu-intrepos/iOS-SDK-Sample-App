//
//  HomeViewController.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift

class HomeViewController : UIViewController
{
  
  // outlets for HomeViewController UI
  @IBOutlet weak var txtTxnID: UITextField!
  @IBOutlet weak var txtKey: UITextField!
  @IBOutlet weak var txtAmount: UITextField!
  @IBOutlet weak var txtProductInfo: UITextField!
  @IBOutlet weak var txtFirstName: UITextField!
  @IBOutlet weak var txtEmailID: UITextField!
  @IBOutlet weak var txtEnvironment: UITextField!
  @IBOutlet weak var oneTapSwitch: UISwitch!
  @IBOutlet weak var switchSalt: UISwitch!
  
  @IBAction func switchAction(_ sender: Any) {
    
    if (switchSalt.isOn == true)
    {
      txtSalt.isHidden = false
    }
    else
    {
      txtSalt.isHidden = true
    }
    
    
  }
  @IBOutlet weak var txtSalt: UITextField!
  let paymentParams = PayUModelPaymentParams()
  let webService = PayUWebService()
  
  var boolForSalt = true
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  
    @objc func methodOfReceivedNotification(notification: Notification){
    //Take Action on Notification
    
    print(notification)
    
    let alert = UIAlertController(title: "Response", message: "\(notification.object!)" , preferredStyle: UIAlertController.Style.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    
    var merchantHash = String()
    var strConvertedRespone = "\(notification.object!)"
    
    // var jsonResult  = try JSONSerialization.jsonObject(with: notification.object!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
    
    
    var JSON : NSDictionary = try! JSONSerialization.jsonObject(with: strConvertedRespone.data(using: String.Encoding.utf8)!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
    
    if ((JSON.object(forKey: "status") as! String == "success"))
    {
      var cardToken = String()
      print("The transaction is successful")
      if (JSON.object(forKey: "cardToken")  != nil)
      {
        cardToken =  JSON.object(forKey: "cardToken") as! String
        
        if (JSON.object(forKey: "card_merchant_param") != nil)
        {
          merchantHash = JSON.object(forKey: "card_merchant_param") as! String
          
        }
      }
      
      
      let obj = PUSAGenerateHashes()
      
      obj.saveOneTapDataAtMerchantServer(Key: paymentParams.key!, withCardToken: cardToken, forUserCredentials: paymentParams.userCredentials!, withMerchantHash: merchantHash, withCompletionBlock: { (message, error) in
        
        
        print(message)
        
      })
    }
    self.present(alert, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    
    self.activityIndicator.isHidden = true
    self.txtSalt.isHidden = true
    NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("PayUResponse"), object: nil)
    
    
    // to remove keyboard on touching anywhere on screen
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dismissKeyboard))
    
    //comment the line below if you want the tap to interfere and cancel other interactions.
    tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
    
  }
  
  //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    // set Payment Params here
    
    //    let paymentParams = PayUModelPaymentParams()
    paymentParams.key = "gtKFFx"
    paymentParams.txnId = generateTxnID()
    paymentParams.amount = "10"
    paymentParams.productInfo = "iPhone"
    paymentParams.firstName = "Ashish"
    paymentParams.email = "ashish.25@mailinator.com"
    paymentParams.environment = ENVIRONMENT_TEST
    
    
    
    paymentParams.surl = "https://guarded-atoll-92892.herokuapp.com/"
    paymentParams.furl = "https://guarded-atoll-92892.herokuapp.com/"
    
    
    // optional params for payment
    
    //    paymentParams.udf1 = "u1"
    //    paymentParams.udf2 = "u2"
    //    paymentParams.udf3 = "u3"
    //    paymentParams.udf4 = "u4"
    //    paymentParams.udf5 = "u5"
    
    // params for specific user (optional)
    // user credentials are about how you recognize your user, general format is key:someUniqueID you pass to PayU Server
    
    paymentParams.userCredentials = "hey:ur decision?"
    paymentParams.phoneNumber = "9876543210"
    
    //offer key if some offer is enabled
    paymentParams.offerKey = "Sample@7279"
    
    // set params to text fields 
    
    self.txtTxnID.text = paymentParams.txnId
    self.txtKey.text = paymentParams.key
    self.txtAmount.text = paymentParams.amount
    self.txtProductInfo.text = paymentParams.productInfo
    self.txtFirstName.text = paymentParams.firstName
    
    self.txtEmailID.text = paymentParams.email
    self.txtEnvironment.text = paymentParams.environment
    
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
    
    
    // setting params from text field to generate hashes accordingly or you can send above params directly
    paymentParams.txnId = self.txtTxnID.text
    paymentParams.key = self.txtKey.text
    paymentParams.amount = self.txtAmount.text
    paymentParams.productInfo = self.txtProductInfo.text
    paymentParams.email = self.txtEmailID.text
    paymentParams.firstName = self.txtFirstName.text
    paymentParams.environment = self.txtEnvironment.text
    
    
    // call function to generate hashes, you should always generate hashes from your own server, pls refer out doc : https://github.com/payu-intrepos/Documentations/wiki/4.-Server-Side
    
    
    
    let genHashes = PUSAGenerateHashes()
    
    genHashes.generateHashesFromServer(withPaymentParams: paymentParams) { (hashes, error) in
      
      
      if (hashes.isEqual("") == false)
      {
        self.activityIndicator.stopAnimating()
        self.activityIndicator.isHidden = true
        
        self.paymentParams.hashes.paymentRelatedDetailsHash = hashes.paymentRelatedDetailsHash
        self.paymentParams.hashes.deleteUserCardHash = hashes.deleteUserCardHash
        self.paymentParams.hashes.offerHash  = hashes.offerHash
        self.paymentParams.hashes.VASForMobileSDKHash = hashes.VASForMobileSDKHash
        self.paymentParams.hashes.saveUserCardHash = hashes.saveUserCardHash
        
        self.paymentParams.hashes.paymentHash = hashes.paymentHash
        
      }
      else
      {
        print(error)
      }
      
      
    }
    self.activityIndicator.isHidden = true
    
  }
  
  
  override func viewDidAppear(_ animated: Bool) {
    
    self.activityIndicator.stopAnimating()
    self.activityIndicator.isHidden = true
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    
    
  }
  
  // Button to navigate to next Screen
  
  @IBAction func btnStart(_ sender: Any) {
    // temporary bool for UI updation
    var updateUITempBool = false
    
    self.activityIndicator.isHidden = false
    self.activityIndicator.startAnimating()
    
    // check for one tap
    
    
    if (oneTapSwitch.isOn)
    {
      self.paymentParams.isOneTap = true
    }
    else
    {
      self.paymentParams.isOneTap = false
    }
    // if some changes at text field input data
    // setting params from text field to generate hashes accordingly or you can send above params directly
    paymentParams.txnId = self.txtTxnID.text
    paymentParams.key = self.txtKey.text
    paymentParams.amount = self.txtAmount.text
    paymentParams.productInfo = self.txtProductInfo.text
    paymentParams.email = self.txtEmailID.text
    paymentParams.firstName = self.txtFirstName.text
    paymentParams.environment = self.txtEnvironment.text
    // call function to generate hashes
    
    
    // Please do not use this class as generating hash internally in SDK is risky & not recommanded, the app can be hacked as well, the below method should be used for testing purposes only
    
    if (switchSalt.isOn == true)
    {
      let shackyClassObject = shackyClass()
      shackyClassObject.generateHashesFromShackyClass(paymentParams: paymentParams, withSalt: txtSalt.text!)
      
      self.activityIndicator.stopAnimating()
      self.activityIndicator.isHidden = true
      
      
      self.activityIndicator.startAnimating()
      
      let webService = PayUWebService()
      
      webService.callVAS(paymentParamsforVas: self.paymentParams)
      
      
      // call PayU's fetchPaymentOptions method to get payment options available for your account
      
      self.webService.fetchPayUPaymentOptions(paymentParamsToFetchPaymentOptions: self.paymentParams) { (array, errorHere) in
        
        DispatchQueue.main.async {
          // Update UI
          
          if (errorHere == "")
          {
            if (updateUITempBool == false)
            {
              updateUITempBool = true
              
              self.activityIndicator.isHidden = true
              self.activityIndicator.stopAnimating()
              let strBrd = UIStoryboard (name: "Main", bundle: nil)
              
              let paymentOptionsVC = strBrd.instantiateViewController(withIdentifier: "PUSAPaymentOptionsVC") as! PUSAPaymentOptionsVC
              
              paymentOptionsVC.paymentOptinonsArray = array.availablePaymentOptions
              paymentOptionsVC.netBankingSwiftArray = array.availableNetBanking
              paymentOptionsVC.cashCardArray = array.availableCashCard
              paymentOptionsVC.emiArray = array.availableEMI
              paymentOptionsVC.savedCardArray = array.availableSavedCards
              
              paymentOptionsVC.paymentParam = self.paymentParams
              self.navigationController?.pushViewController(paymentOptionsVC, animated: true)
              
            }
          }
            
          else
          {
            
            let alert = UIAlertController(title: "oops !", message: errorHere as String, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
          }
        }
      }
      
      
    }
      
    else
    {
      let genHashes = PUSAGenerateHashes()
      
      genHashes.generateHashesFromServer(withPaymentParams: paymentParams) { (hashes, error) in
        
        if (error == "")
        {
          self.activityIndicator.stopAnimating()
          self.activityIndicator.isHidden = true
          
          self.paymentParams.hashes.paymentRelatedDetailsHash = hashes.paymentRelatedDetailsHash
          self.paymentParams.hashes.deleteUserCardHash = hashes.deleteUserCardHash
          self.paymentParams.hashes.offerHash  = hashes.offerHash
          self.paymentParams.hashes.VASForMobileSDKHash = hashes.VASForMobileSDKHash
          self.paymentParams.hashes.saveUserCardHash = hashes.saveUserCardHash
          
          self.paymentParams.hashes.paymentHash = hashes.paymentHash
          
          // check for activity indicator
          self.activityIndicator.isHidden = false
          
          self.activityIndicator.startAnimating()
          
          let webService = PayUWebService()
          
          webService.callVAS(paymentParamsforVas: self.paymentParams)
          
          // call PayU's fetchPaymentOptions method to get payment options available for your account
          
          self.webService.fetchPayUPaymentOptions(paymentParamsToFetchPaymentOptions: self.paymentParams) { (array, errorHere) in
            
            DispatchQueue.main.async {
              // Update UI
              
              if (errorHere == "")
              {
                if (updateUITempBool == false)
                {
                  updateUITempBool = true
                  
                  self.activityIndicator.isHidden = true
                  self.activityIndicator.stopAnimating()
                  let strBrd = UIStoryboard (name: "Main", bundle: nil)
                  
                  let paymentOptionsVC = strBrd.instantiateViewController(withIdentifier: "PUSAPaymentOptionsVC") as! PUSAPaymentOptionsVC
                  
                  paymentOptionsVC.paymentOptinonsArray = array.availablePaymentOptions 
                  paymentOptionsVC.netBankingSwiftArray = array.availableNetBanking
                  paymentOptionsVC.cashCardArray = array.availableCashCard
                  paymentOptionsVC.emiArray = array.availableEMI
                  paymentOptionsVC.savedCardArray = array.availableSavedCards
                  
                  paymentOptionsVC.paymentParam = self.paymentParams
                  self.navigationController?.pushViewController(paymentOptionsVC, animated: true)
                  
                }
              }
                
              else
              {
                
                let alert = UIAlertController(title: "oops !", message: errorHere as String, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
              }
            }
          }
        }
        else
        {
          DispatchQueue.main.async {
            
            
            let alert = UIAlertController(title: "oops !", message: error, preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
          }
        }
      }
    }
  }
  
  // function to generate unique transaction ID
  
  func generateTxnID() -> String {
    
    let currentDate = DateFormatter()
    currentDate.dateFormat = "yyyyMMddHHmmss"
    let date = NSDate()
    let dateString = currentDate.string(from : date as Date)
    return dateString
  
  }
  
}


