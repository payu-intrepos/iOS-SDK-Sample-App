//
//  PUSAUPI.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 1/10/18.
//  Copyright © 2018 PayU Payments Private Limited. All rights reserved.
//

import UIKit
import PayU_coreSDK_Swift
class PUSAUPI: UIViewController,UITextFieldDelegate {
  
  @IBOutlet weak var txtEnterVPA: UITextField!
  var paymentParams = PayUModelPaymentParams()
  let createRequest = PayUCreateRequest()
  
  override func viewDidLoad() {
    
    self.txtEnterVPA.delegate = self
    self.txtEnterVPA.placeholder = "yourVPA@mybank"
    
    // to remove keyboard on touching anywhere on screen
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PUSAUPI.dismissKeyboard))
    
    //comment the line below if you want the tap to interfere and cancel other interactions.
    tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
  }
  //Calls this function when the tap is recognized.
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  
  @IBAction func btnPayNow(_ sender: Any) {
    
    self.paymentParams.vpa = self.txtEnterVPA.text
    self.paymentParams.enableVerbose = true
    createRequest.createRequest(withPaymentParam: paymentParams, forPaymentType: PAYMENT_PG_UPI) { (request, error) in
      
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
  
  
  // MARK: TextField's delegate methods
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
  {
    
    
    
    return true
    
    
  }
  
  
  func textFieldDidBeginEditing(_ textField: UITextField)
  {
    
    
  }
  
  func textFieldShouldEndEditing(_ textField: UITextField) -> Bool
    
  {
    
    
    return true
  }
  
  func textFieldDidEndEditing(_ textField: UITextField)
  {
    
    //    if (textField == txtEnterCardNumber)
    //    {
    //      self.params.cardNumber = textField.text
    //      callOfferAPI()
    //    }
    
    
    
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    self.txtEnterVPA.resignFirstResponder()
    
    
    return true
    
  }
  

}
