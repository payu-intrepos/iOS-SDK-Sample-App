//
//  PUSACCDCVC.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift

class PUSACCDCVC: UIViewController,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate {
  
  @IBOutlet weak var containerAmountTxnID: UIView!
  @IBOutlet weak var imageMonth: UIImageView!
  var params = PayUModelPaymentParams()
  
  let createRequest = PayUCreateRequest()
  
  @IBOutlet weak var txtCardNameToSave: UITextField!
  
  @IBOutlet weak var lblTxnID: UILabel!
  @IBOutlet weak var lblAmount: UILabel!
  
  
  
  @IBOutlet weak var switchSavedCard: UISwitch!
  @IBOutlet weak var ccdcContainer1: UIView!
  @IBOutlet weak var ccdcContainer2: UIView!
  @IBOutlet weak var lblExpiryMonth: UIButton!
  
  @IBOutlet weak var lblExpiryYear: UIButton!
  @IBOutlet weak var lblEnterCardNumber: UILabel!
  @IBOutlet weak var lblExpiryDate: UILabel!
  @IBOutlet weak var txtEnterCardNumber: UITextField!
  
  @IBOutlet weak var imageYear: UIImageView!
  @IBOutlet weak var txtCVV: UITextField!
  private var tblExpiryMonth: UITableView!
  
  private var tblExpiryYear : UITableView!
  
  @IBAction func switchAction(_ sender: Any) {
    
    if (switchSavedCard.isOn == true)
    {
      txtCardNameToSave.isHidden = false
    }
    else
    {
      txtCardNameToSave.isHidden = true
    }
    
  }
  
  var expiryMonthArray = ["01","02","03","04","05","06","07","08","09","10","11","12"]
  var expiryYearArray = Array<String>()

  override func viewDidLoad() {
    
    txtEnterCardNumber.delegate = self
    txtCardNameToSave.delegate = self
    txtCVV.delegate = self
    txtCardNameToSave.isHidden = true
    switchSavedCard.isOn = false
    
    self.createTables()
    self.assignValueToYearArray()
    tblExpiryMonth.isHidden = true
    tblExpiryYear.isHidden = true
    
    self.lblAmount.text = "Amount " + "\u{20B9} :" + self.params.amount!
    self.lblTxnID.text = "Txn ID: " + self.params.txnId!
    
    // to remove keyboard on touching anywhere on screen
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PUSACCDCVC.dismissKeyboard))
    
    //comment the line below if you want the tap to interfere and cancel other interactions.
    tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
    
        let webService = PayUWebService()
        webService.getCardTypeDetails(cardBin:params ) { (details, error) in
    
          if (error == "")
          {
            print(details)
          }
          else
          {
            print(error)
          }
    
        }
    
    
  }
  
  //Calls this function when the tap is recognized.
  func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if (switchSavedCard.isOn == true)
    {
      txtCardNameToSave.isHidden = false
    }
  }
  
  func assignValueToYearArray () ->()
  {
    let currentDate = DateFormatter()
    currentDate.dateFormat = "yyyy"
    let date = NSDate()
    let currentYear = currentDate.string(from : date as Date)
    
    
    for i in 0 ..< 100
    {
      var result = getCalculatedIntegerFrom(strings: [currentYear])
      result = result + i
      
      let resultHere = "\(result)"
      
      expiryYearArray.append(resultHere)
      
    }
  }
  
  
  func getCalculatedIntegerFrom(strings: [String]) -> Int {
    
    var result = Int()
    
    for element in strings {
      
      guard let int = Int(element) else {
        break // or return nil
        // break instead of return, returns Integer of all
        // the values it was able to turn into Integer
        // so even if there is a String f.e. "123S", it would
        // still return an Integer instead of nil
        // if you want to use return, you have to set "-> Int?" as optional
      }
      
      result = result + int
      
    }
    
    return result
    
  }
  
  func createTables()
  {
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    var displayWidth: CGFloat = self.lblExpiryMonth.frame.width
    var displayHeight: CGFloat = self.ccdcContainer1.frame.height + self.ccdcContainer2.frame.height - 64
    
    //  tblExpiryMonth = UITableView(frame: CGRect(x : lblExpiryMonth.frame.width , y : lblExpiryMonth.frame.height, displayWidth = displayWidth, displayHeight = displayHeight - barHeight))
    
    tblExpiryMonth = UITableView(frame: CGRect(x: self.lblExpiryMonth.frame.origin.x + self.ccdcContainer1.frame.origin.x      , y: self.view.frame.height - (self.ccdcContainer1.frame.height + self.ccdcContainer2.frame.height) + self.lblEnterCardNumber.frame.height + self.txtEnterCardNumber.frame.height + self.lblExpiryMonth.frame.height + self.lblExpiryMonth.frame.height   , width: self.lblExpiryMonth.frame.width
      , height: (displayHeight - barHeight) - 64))
    
    tblExpiryMonth.register(UITableViewCell.self, forCellReuseIdentifier: "expiryMonthCell")
    let myColor : UIColor = UIColor( red: 0.0, green: 0.0, blue:0.0, alpha: 1.0 )
    
    
    tblExpiryMonth.delegate = self
    tblExpiryMonth.dataSource = self
    
    
    tblExpiryYear = UITableView(frame: CGRect(x: self.ccdcContainer1.frame.origin.x + self.lblExpiryYear.frame.origin.x, y: self.view.frame.height - (self.ccdcContainer1.frame.height + self.ccdcContainer2.frame.height) + self.lblEnterCardNumber.frame.height + self.txtEnterCardNumber.frame.height + self.lblExpiryYear.frame.height + self.lblExpiryYear.frame.height  , width: self.lblExpiryYear.frame.width, height: (displayHeight - barHeight) - 64))
    
    tblExpiryYear.register(UITableViewCell.self, forCellReuseIdentifier: "expiryYearCell")
    
    
    tblExpiryYear.delegate = self
    tblExpiryYear.dataSource = self
    tblExpiryMonth.layer.borderColor = myColor.cgColor
    tblExpiryYear.layer.borderColor = myColor.cgColor
    tblExpiryMonth.layer.borderWidth = 0.4
    tblExpiryYear.layer.borderWidth = 0.4
    
    
    self.view.addSubview(tblExpiryMonth)
    self.view.addSubview(tblExpiryYear)
    
  }
  

  @IBAction func btnPayNow(_ sender: UIButton) {
    
    self.params.cardNumber = self.txtEnterCardNumber.text
    
    if ( switchSavedCard.isOn == true)
    {
      self.params.storeCardName = self.txtCardNameToSave.text
    }
    
    self.params.CVV = self.txtCVV.text
    
    createRequest.createRequest(withPaymentParam: params, forPaymentType: PAYMENT_PG_CCDC) { (request, error) in
      
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
  
  // MARK: Table View Data Source & Delegate Methods
  
  func numberOfSections(in tabPleView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if (tableView == tblExpiryMonth)
    {
      return expiryMonthArray.count
      
    }
    return expiryYearArray.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    var cell = UITableViewCell ()
    
    if (tableView == tblExpiryMonth)
    {
      cell = tableView.dequeueReusableCell(withIdentifier: "expiryMonthCell" , for : indexPath)
      
      cell.textLabel?.font = UIFont(name:"Avenir", size:16)
      
      cell.textLabel?.text = expiryMonthArray[indexPath.row]
    }
    
    
    if (tableView == tblExpiryYear)
    {
      cell = tableView.dequeueReusableCell(withIdentifier: "expiryYearCell" , for : indexPath)
      
      cell.textLabel?.font = UIFont(name:"Avenir", size:16)
      
      cell.textLabel?.text = expiryYearArray[indexPath.row]
    }
    
    return cell
    
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let cell = tableView.cellForRow(at: indexPath)
    
    if (tableView == tblExpiryMonth)
    {
      self.imageMonth.isHidden = true
      lblExpiryMonth.setTitle(cell?.textLabel?.text, for: UIControlState.normal)
      
      // set payment params
      self.params.expiryMonth = cell?.textLabel?.text
      
      
      tblExpiryMonth.isHidden = true
    }
    
    if (tableView == tblExpiryYear)
    {
      self.imageYear.isHidden = true
      lblExpiryYear.setTitle(cell?.textLabel?.text, for: UIControlState.normal)
      self.params.expiryYear = cell?.textLabel?.text
      tblExpiryYear.isHidden = true
    }
    
    
    
  }
  
  @IBAction func btnExpiryMonth(_ sender: Any) {
    
    tblExpiryMonth.isHidden = !self.tblExpiryMonth.isHidden
    
    
  }
  
  @IBAction func btnExpiryYear(_ sender: Any) {
    
    tblExpiryYear.isHidden = !self.tblExpiryYear.isHidden
    
  }
  
  // MARK: TextField's delegate methods
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
  {
    
    txtEnterCardNumber.keyboardType = .numberPad
    txtCVV.keyboardType = .numberPad
    addDoneButtonOnKeyboard()
    
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
    txtEnterCardNumber.resignFirstResponder()
    txtCVV.resignFirstResponder()
    txtCardNameToSave.resignFirstResponder()
    
    
    return true
    
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
    
    let currentCharacterCount = textField.text?.characters.count ?? 0
    if (range.length + range.location > currentCharacterCount){
      return false
    }
    let newLength = currentCharacterCount + string.characters.count - range.length
    
    //    if (newLength > 6)
    //    {
    //      // Just in case you are calling offer API, so need to pass card Bin
    ////       self.params.cardNumber = textField.text
    ////         self.callOfferAPI()
    //
    //      
    ////      }
    //    }
    
    
    return newLength <= 19
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
    
    self.txtEnterCardNumber.inputAccessoryView = doneToolbar
    self.txtCVV.inputAccessoryView = doneToolbar
  }
  
  func doneButtonAction() {
    self.txtEnterCardNumber.resignFirstResponder()
    self.txtCVV.resignFirstResponder()
    
    
  }
  func callOfferAPI()
  {
    
  
    let webservice = PayUWebService()
    webservice.getOfferStatus(paymentParamsForOfferAPI: self.params) { (offerStatus, error) in
      // write your logic to show up offer
      
      
      DispatchQueue.main.async {
        
        if (error == "")
        {
          var offerMessage = String()
          
          offerMessage.append("Offer Type = ")
          offerMessage.append(offerStatus.OfferType)
          offerMessage.append(", Offer Discount = ")
          offerMessage.append(offerStatus.discount)
          
          
          // add toast to UI
          let offerStatatusError = offerStatus.errorCode
          if (offerStatatusError == "")
          {
            let toastLabel =
              UILabel(frame:
                CGRect(x: self.view.frame.origin.x ,
                       y: self.view.frame.size.height-150,
                       width: self.view.frame.size.width ,
                       height: 64))
            toastLabel.backgroundColor = UIColor.yellow
            toastLabel.textColor = UIColor.blue
            toastLabel.font = toastLabel.font.withSize(14)
            toastLabel.textAlignment = NSTextAlignment.center
            
            self.view.addSubview(toastLabel)
            toastLabel.text = offerMessage
            toastLabel.alpha = 0.6
            toastLabel.layer.cornerRadius = 10;
            toastLabel.clipsToBounds  =  true
            UIView.animate(withDuration: 10.0, animations: {
              toastLabel.alpha = 0.0
            })
            
          }
        }
        else
        {
          let alert = UIAlertController(title: "Oops!", message: error, preferredStyle: UIAlertControllerStyle.alert)
          alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
        }
        
      }
    }
    
  }
  
}
