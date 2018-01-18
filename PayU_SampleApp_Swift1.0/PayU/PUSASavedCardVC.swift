//
//  PUSASavedCardVC.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift


class PUSASavedCardVC: UIViewController,UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate {
  
  
  // weak var cvvTextField = UITextField!
  @IBOutlet weak var containerAmountTxnID: UIView!
  @IBOutlet weak var tblSavedCard: UITableView!
  var paymentParams = PayUModelPaymentParams()
  var savedCardArray = Array<AnyObject>()
  var cvvTextField = UITextField()
  var cvvTextFieldCell = UITextField()
  let webService = PayUWebService()
  @IBOutlet weak var lblTxnID: UILabel!
  @IBOutlet weak var lblAmount: UILabel!
  
  var existingOneCardDict = NSDictionary()
  override func viewDidLoad() {
    self.cvvTextField.delegate = self
    
    
    self.lblAmount.text = "Amount " + "\u{20B9} :" + self.paymentParams.amount!
    self.lblTxnID.text = "Txn ID: " + self.paymentParams.txnId!
    
    
    // to remove keyboard on touching anywhere on screen
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PUSASavedCardVC.dismissKeyboard))
    
    //comment the line below if you want the tap to interfere and cancel other interactions.
    tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
  }
  
  //Calls this function when the tap is recognized.
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    callOneTapToken()
    
  }
  
  
  // MARK: Table View's delegate methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    
    
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    
    return savedCardArray.count
    
  }
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellSavedCard")
    
    cell?.layer.cornerRadius = 4.0
    cell?.layer.masksToBounds = true
    cell?.layer.borderWidth = 0.4
    
    var savedCard  = PUExtended ()
    
    savedCard = savedCardArray[indexPath.row] as! PUExtended
    
    //  print(savedCard.card_cvv)
    
    
    // set Image to Saved Card UI Part
    if (savedCard.cardBrand == "MASTERCARD")
    {
      let imageName = "master.png"
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image: image!)
      
      imageView.frame = CGRect(x: 300, y: 30, width: 40, height: 40)
      // view.addSubview(imageView)
      cell?.contentView.addSubview(imageView)
    }
    if (savedCard.cardBrand == "MAESTRO")
    {
      let imageName = "maestro.png"
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image: image!)
      
      imageView.frame = CGRect(x: 300, y: 30, width: 40, height: 40)
      // view.addSubview(imageView)
      cell?.contentView.addSubview(imageView)
    }
    if (savedCard.cardBrand == "VISA")
    {
      let imageName = "visa.png"
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image: image!)
      
      imageView.frame = CGRect(x: 300, y: 30, width: 40, height: 40)
      // view.addSubview(imageView)
      cell?.contentView.addSubview(imageView)
    }
    if (savedCard.cardBrand == "AMEX")
    {
      let imageName = "amex.png"
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image: image!)
      
      imageView.frame = CGRect(x: 300, y: 30, width: 40, height: 40)
      // view.addSubview(imageView)
      cell?.contentView.addSubview(imageView)
    }
    if (savedCard.cardBrand == "DINER")
    {
      let imageName = "diner.png"
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image: image!)
      
      imageView.frame = CGRect(x: 300, y: 30, width: 40, height: 40)
      // view.addSubview(imageView)
      cell?.contentView.addSubview(imageView)
    }
    if (savedCard.cardBrand == "RUPAY")
    {
      let imageName = "rupay.png"
      let image = UIImage(named: imageName)
      let imageView = UIImageView(image: image!)
      
      imageView.frame = CGRect(x: 300, y: 30, width: 40, height: 40)
      // view.addSubview(imageView)
      cell?.contentView.addSubview(imageView)
    }
    
    // set card token for deleting card
    
    self.paymentParams.cardToken = savedCard.cardToken
    
    if (savedCard.card_cvv == "0")
    {
      
      createCvvTextField()
      addDoneButtonOnKeyboard()
      createCvvTextFieldForCell()
      
      cell?.textLabel?.text = savedCard.cardNo
      cell?.detailTextLabel?.text = savedCard.cardName
      cell?.contentView.addSubview(cvvTextFieldCell)
      
    }
    
    cell?.textLabel?.text = savedCard.cardNo
    cell?.detailTextLabel?.text = savedCard.cardName
    
    return cell!
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    
    if editingStyle == .delete
    {
      
      webService.deleteSavedCard(paymentParamsForDeletingSavedCard: paymentParams, completionBlockForDeletingSavedCard: { (status, error) in
        
        if (error == "")
        {
          
          let alert = UIAlertController(title: "Message", message: status as String, preferredStyle: UIAlertControllerStyle.alert)
          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
        else
        {
          let alert = UIAlertController(title: "oops !", message: error as String, preferredStyle: UIAlertControllerStyle.alert)
          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
      })
      savedCardArray.remove(at: indexPath.row)
      tableView.beginUpdates()
      tableView.deleteRows(at: [indexPath], with: .automatic)
      tableView.endUpdates()
    }
    
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? // fixed font style. use custom view (UILabel) if you want something different
  {
    return "Select your Card"
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    
    
    cvvTextField.removeFromSuperview()
    //  cvvTextFieldCell.removeFromSuperview()
    let currentCell = tableView.cellForRow(at: indexPath)
    createCvvTextField()
    addDoneButtonOnKeyboard()
    currentCell?.contentView.addSubview(cvvTextField)
    self.cvvTextField.becomeFirstResponder()
    
    
    var savedCard  = PUExtended ()
    
    savedCard = savedCardArray[indexPath.row] as! PUExtended
    paymentParams.cardToken = savedCard.cardToken
    paymentParams.cardBin = savedCard.cardBin
    
    
    if (savedCard.card_cvv == "1")
    {
      if( existingOneCardDict.value(forKey: paymentParams.cardToken!) != nil)
      {
        
        paymentParams.payThroughOneTap = true
        
        
        paymentParams.OneTapTokenDictionary = existingOneCardDict as! Dictionary<String, String>
        
        //      print("This is one tap Card")
        
        cvvTextField.removeFromSuperview()
        
      }
    }
    else
    {
      //      print("This is not one tap card")
      paymentParams.payThroughOneTap = false
      
      //     let currentCell = tableView.cellForRow(at: indexPath)
      ////     
      //      createCvvTextField()
      //      addDoneButtonOnKeyboard()
      //      currentCell?.contentView.addSubview(cvvTextField)
      
      
    }
    
    
  }
  
  
  func createCvvTextField () -> ()
  {
    
    cvvTextField = UITextField(frame: CGRect(x: 300, y: 10, width: 185, height: 30))
    cvvTextField.adjustsFontSizeToFitWidth = true
    cvvTextField.textColor = UIColor.black
    cvvTextField.isSecureTextEntry = true
    
    cvvTextField.placeholder = "cvv"
    cvvTextField.keyboardType = .numberPad
    
    
    
  }
  
  func createCvvTextFieldForCell () -> ()
  {
    
    cvvTextFieldCell = UITextField(frame: CGRect(x: 300, y: 10, width: 185, height: 30))
    cvvTextFieldCell.adjustsFontSizeToFitWidth = true
    cvvTextFieldCell.textColor = UIColor.black
    cvvTextFieldCell.isSecureTextEntry = true
    cvvTextFieldCell.isEnabled = false
    
    cvvTextFieldCell.placeholder = "cvv"
    // cvvTextField.keyboardType = .numberPad
    
  }
  
  
  
  @IBAction func btnPayNow(_ sender: Any) {
    
    
    paymentParams.CVV = cvvTextField.text
    
    let webRequest = PayUCreateRequest()
    webRequest.createRequest(withPaymentParam: paymentParams, forPaymentType: PAYMENT_PG_STOREDCARD) { (request, error) in
      
      
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
  
  
  
  // MARK: UIText Field Delegate Methods
  
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
  {
    //cvvTextField.keyboardType = .numberPad
    
    
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
    
    
    
  }
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    self.cvvTextField.resignFirstResponder()
    return true
  }
  
  
  func textFieldShouldClear(_ textField: UITextField) -> Bool
  {
    return true
  }
  
  
  // MARK: Done button functionality on number pad
  
  func addDoneButtonOnKeyboard() {
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
    doneToolbar.barStyle       = UIBarStyle.default
    let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(self.doneButtonAction))
    
    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)
    
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    self.cvvTextField.inputAccessoryView = doneToolbar
  }
  
  func doneButtonAction() {
    self.cvvTextField.becomeFirstResponder()
    self.cvvTextField.resignFirstResponder()
  }
  
  
  
  // function to call one tap token
  
  func callOneTapToken () -> () {
    
    
    let object = PUSAGenerateHashes()
    object.fetchOneTapTokenFromServer(withParams: paymentParams) { (oneTapDictionary, error) in
      
      if(error == "")
      {
        
        self.existingOneCardDict = oneTapDictionary
        
      }
      
    }
  }
  
  
  
  
}
