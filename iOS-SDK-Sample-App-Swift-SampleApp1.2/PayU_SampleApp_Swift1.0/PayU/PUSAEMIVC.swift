//
//  PUSAEMIVC.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift

class PUSAEMIVC: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
  
  @IBOutlet weak var lblSelectMonth: UIButton!
  @IBOutlet weak var lblSelectYear: UIButton!
  @IBOutlet weak var lblAmount: UILabel!
  @IBOutlet weak var lblTxnID: UILabel!
  @IBOutlet weak var lblExpiryMonth: UIButton!
  
  @IBOutlet weak var lblExpiryYear: UIButton!
  var emiBanks = Array<AnyObject>()
  var paymentParams = PayUModelPaymentParams()
  
  @IBOutlet weak var containerView1: UIView!
  @IBOutlet weak var txtCardNumber: UITextField!
  @IBOutlet weak var txtExpiryMonth: UITextField!
  
  @IBOutlet weak var container1: UIView!
  @IBOutlet weak var txtExpiryYear: UITextField!
  @IBOutlet weak var txtCVV: UITextField!
  
  var tblBankName = UITableView ()
  var tblBankDuration = UITableView ()
  var emiDictionary = [(String , String)]()
  var emiDictionarySorted = [(String , String)]()
  
  var emiBankNameArray = Array<String>()
  var emiDurationArray = Array<String>()
  var finalDict = Dictionary < String, [String] >()
  var finalDictArrayOfDuration = Array<[String]>()
  
  var tempArray = Array<String>()
  
  
  // Arrays used in Table to show Bank names and duration
  
  var tblBankNamesArray = Array<String>()
  var tblDurationArray = Array <[String]>()
  var arrayOfIndexForSelectedBank = Array<String>()
  var selectedBankAtIndex = String()
  
  private var tblExpiryMonth: UITableView!
  
  private var tblExpiryYear : UITableView!
  
  
  
  var expiryMonthArray = ["01","02","03","04","05","06","07","08","09","10","11","12"]
  var expiryYearArray = Array<String>()
  
  
  
  override func viewDidLoad() {
    
    
    // set payment params to pay through EMI
    
    //    paymentParams.cardNumber = "5123456789012346"
    //    paymentParams.expiryMonth = txtExpiryMonth.text
    //    paymentParams.expiryYear = txtExpiryYear.text
    //    paymentParams.CVV = txtCVV.text
    //    
    
    self.lblAmount.text = "Amount " + "\u{20B9} :" + self.paymentParams.amount!
    self.lblTxnID.text = "Txn ID: " + self.paymentParams.txnId!
    
    createTableForEMI()
    self.tblBankName.isHidden = true
    self.tblBankDuration.isHidden = true
    
    self.txtCardNumber.delegate = self
    self.txtCVV.delegate = self
    txtCVV.delegate = self
    self.createTables()
    
    
    // to remove keyboard on touching anywhere on screen
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PUSAEMIVC.dismissKeyboard))
    
    //comment the line below if you want the tap to interfere and cancel other interactions.
    tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
    
  }
  
  //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  override func viewDidAppear(_ animated: Bool) {
    
    
    tblExpiryYear.isHidden = true
    tblExpiryMonth.isHidden = true
    
    tblBankDuration.reloadData()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    
    self.tblExpiryYear.isHidden = true
    self.tblExpiryMonth.isHidden = true
    
    self.assignValueToYearArray()
    
    self.sortEMIDictionary()
    
    for keyInDict in finalDict
    {
      
      
      tblBankNamesArray.append(keyInDict.key)
      tblDurationArray.append(keyInDict.value)
      
      //      print(tblBankNamesArray)
      //      print(tblDurationArray)
    }
    
    
    
  }
  
  
  // MARK: Talbe View Delegate Methods
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
    if (tableView == tblBankName)
    {
      return finalDict.keys.count
    }
    if (tableView == tblBankDuration)
    {
      //     let temp = Array<AnyObject>()
      //
      //
      //
      //      return temp.count
      
      
      
      
      
      
      if let count = finalDict[selectedBankAtIndex]?.count
      {
        return count
        
      }
      
      
    }
    
    if (tableView == tblExpiryMonth)
    {
      return expiryMonthArray.count
    }
    
    if (tableView == tblExpiryYear)
    {
      return expiryYearArray.count
    }
    
    
    return finalDict.keys.count
    
  }
  
  
  
  
  
  
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
  {
    var emi = PUExtended()
    emi = emiBanks[indexPath.row] as! PUExtended
    
    
    var cell = UITableViewCell ()
    if (tableView == tblBankName)
    {
      cell = tableView.dequeueReusableCell(withIdentifier: "bankCell")!
      
      //cell.textLabel?.text = finalDict.keys[indexPath.row]
      
      cell.textLabel?.text = tblBankNamesArray[indexPath.row]
      // selectedBankAtIndex = tblBankNamesArray[indexPath.row]
      // selectedBankAtIndex = (cell.textLabel?.text)!
      
      
      
      
      
      // arrayOfIndexForSelectedBank = [tblBankNamesArray[indexPath.row]]
      //cell.textLabel?.text = finalDict[indexPath.row]
      
      //  print(selectedBankAtIndex)
      
    }
    if (tableView == tblBankDuration)
    {
      
      //      if (selectedBankAtIndex == "ICICIP")
      //      {
      //        for finalDictValues in finalDict
      //        {
      //         
      //          finalDictArrayOfDuration.append(finalDict[selectedBankAtIndex]! )
      //
      //          print(finalDictArrayOfDuration)
      //          
      //        }
      
      
      
      
      cell = tableView.dequeueReusableCell(withIdentifier: "bankDurationCell")!
      
      
      cell.textLabel?.text = finalDict[selectedBankAtIndex]?[indexPath.row]
      
      
      
      //  }
      
    }
    
    
    // table View for expiry month & expiry year
    
    
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
    
    let currentCell = tableView.cellForRow(at: indexPath)! as UITableViewCell
    
    
    if (tableView == tblBankName)
    {
      
      
      selectedBankAtIndex = (currentCell.textLabel?.text)!
      tblBankDuration.reloadData()
      tblBankDuration.isHidden = false
      
      
    }
    if (tableView == tblBankDuration)
    {
      if let bankCodeTitle = currentCell.textLabel?.text
      {
        
        var emiBank = PUExtended()
        
        for currentBank in emiBanks
          
        {
          emiBank = currentBank as! PUExtended
          
          // print(currentBank)
          //print(emiBank.emiBankName)
          
          if (emiBank.emiBankName == selectedBankAtIndex  && emiBank.title == bankCodeTitle)
          {
            paymentParams.bankCode = emiBank.bankCode
          }
          
        }
        self.lblSelectMonth.setTitle(selectedBankAtIndex, for: UIControl.State.normal)
        self.lblSelectYear.setTitle(bankCodeTitle, for: UIControl.State.normal)
        
        self.tblBankName.isHidden = true
        self.tblBankDuration.isHidden = true
        
      }
    }
    
    
    if (tableView == tblExpiryMonth){
      
      let selectedIndexForExpiryMonth = currentCell.textLabel?.text
      self.paymentParams.expiryMonth = selectedIndexForExpiryMonth
      
        self.lblExpiryMonth.setTitle(selectedIndexForExpiryMonth, for: UIControl.State.normal)
      
      
    }
    if (tableView == tblExpiryYear)
      
    {
      let selectedIndexForExpiryYear = currentCell.textLabel?.text
      
      self.paymentParams.expiryYear = selectedIndexForExpiryYear
      
        self.lblExpiryYear.setTitle(selectedIndexForExpiryYear, for: UIControl.State.normal)
      
      
    }
    
    tblExpiryMonth.isHidden = true
    tblExpiryYear.isHidden = true
    
  }
  
  
  @IBAction func btnPayNow(_ sender: UIButton) {
    
    self.paymentParams.cardNumber = self.txtCardNumber.text
    
    self.paymentParams.CVV = self.txtCVV.text
    self.paymentParams.total_subventionAmount = "10000"
    
    let createRequest = PayUCreateRequest()
    self.paymentParams.enableVerbose = true
    createRequest.createRequest(withPaymentParam: self.paymentParams, forPaymentType: PAYMENT_PG_EMI) { (request, error) in
      
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
  
  
  
  
  
  
  
  // function to sort dictionary
  
  
  func sortEMIDictionary () -> ()
  {
    
    for emiBankOne in emiBanks
    {
      var object = PUExtended()
      object = emiBankOne as! PUExtended
      
      emiDictionary.append((object.emiBankName , object.title))
      emiBankNameArray.append(object.emiBankName)
      emiDurationArray.append(object.title)
    }
    
    // function to sort elements of Array
    func uniq<S : Sequence, T : Hashable>(source: S) -> [T] where S.Iterator.Element == T {
      var buffer = [T]()
      var added = Set<T>()
      for elem in source {
        if !added.contains(elem) {
          buffer.append(elem)
          added.insert(elem)
        }
      }
      return buffer
    }
    
    let emiArraySorted = uniq(source: emiBankNameArray)
    
    emiDictionarySorted = emiDictionary.flatMap({$0}).sorted { $0.0 < $1.0 }
    
    var nwArray = Array<String>()
    
    for emiBankName in emiArraySorted
    {
      
      nwArray = Array<String>()
      
      for index in 0...(emiDictionarySorted.count-1)
      {
        
        
        if (emiDictionarySorted[index].0 == emiBankName)
        {
          nwArray.append(emiDictionarySorted[index].1)
          finalDict[emiDictionarySorted[index].0] = nwArray
          
        }
        
      }
    }
    
  }
  
  
  @IBAction func btnSelectMonth(_ sender: UIButton) {
    
    
    self.tblBankName.isHidden = false
    self.tblBankName.reloadData()
    
  }
  
  
  @IBAction func btnSelectYear(_ sender: Any) {
    self.tblBankDuration.isHidden = false
    self.tblBankDuration.reloadData()
    
    
    
  }
  
  func createTableForEMI () -> ()
  {
    //let screenSize: CGRect = UIScreen.main.bounds
    
    let screenWidthBankName = self.lblSelectMonth.frame.width
    
    let screenHeightBankName = self.containerView1.frame.height * 4
    
    let xOriginBankName = self.lblSelectMonth.frame.origin.x + self.containerView1.frame.origin.x
    let yOriginBankName = self.containerView1.frame.maxY
    
    let rect = CGRect(origin:CGPoint(x: xOriginBankName,y :yOriginBankName), size: CGSize(width: screenWidthBankName, height: screenHeightBankName))
    
    tblBankName = UITableView(frame: rect)
    tblBankName.dataSource = self
    tblBankName.delegate = self
    
    tblBankName.register(UITableViewCell.self, forCellReuseIdentifier: "bankCell")
    
    let screenWidthBankDuration = self.lblSelectYear.frame.width
    let screenHeightBankDuration = self.containerView1.frame.height * 4
    let xOriginBankDuration = self.lblSelectYear.frame.origin.x + self.containerView1.frame.origin.x
    let yOriginBankDuration = self.containerView1.frame.maxY
    
    let rectBankDuration = CGRect (origin: CGPoint(x: xOriginBankDuration, y: yOriginBankDuration), size: CGSize(width: screenWidthBankDuration, height: screenHeightBankDuration))
    tblBankDuration = UITableView (frame: rectBankDuration)
    
    
    tblBankDuration.dataSource = self
    tblBankDuration.delegate = self
    
    tblBankDuration.register(UITableViewCell.self, forCellReuseIdentifier: "bankDurationCell")
    
    
    
    self.view.addSubview(tblBankName)
    self.view.addSubview(tblBankDuration)
    
    
  }
  
  
  
  func createTables()
  {
    let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
    var displayWidth: CGFloat = self.lblExpiryMonth.frame.width
    var displayHeight: CGFloat = self.container1.frame.height
    
    //  tblExpiryMonth = UITableView(frame: CGRect(x : lblExpiryMonth.frame.width , y : lblExpiryMonth.frame.height, displayWidth = displayWidth, displayHeight = displayHeight - barHeight))
    
    tblExpiryMonth = UITableView(frame: CGRect(x: self.lblExpiryMonth.frame.origin.x, y: self.container1.frame.maxY  , width: self.lblExpiryMonth.frame.width, height: self.containerView1.frame.height * 2))
    
    tblExpiryMonth.register(UITableViewCell.self, forCellReuseIdentifier: "expiryMonthCell")
    let myColor : UIColor = UIColor( red: 0.0, green: 0.0, blue:0.0, alpha: 1.0 )
    
    
    
    tblExpiryMonth.delegate = self
    tblExpiryMonth.dataSource = self
    
    
    tblExpiryYear = UITableView(frame: CGRect(x: self.lblExpiryYear.frame.origin.x, y: self.container1.frame.maxY  , width: self.lblExpiryYear.frame.width, height: self.containerView1.frame.height * 2))
    
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
  
  @IBAction func btnExpiryMonth(_ sender: UIButton) {
    
    tblExpiryMonth.isHidden = !self.tblExpiryMonth.isHidden
    
    
    
  }
  
  @IBAction func btnExpiryYear(_ sender: UIButton) {
    
    tblExpiryYear.isHidden = !self.tblExpiryYear.isHidden
    
    
  }
  
  // MARK: TextField's delegate methods
  
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
  {
    
    self.txtCardNumber.keyboardType = .numberPad
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
    
    
    
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool
  {
    self.txtCardNumber.resignFirstResponder()
    self.txtCVV.resignFirstResponder()
    
    return true
    
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {
    
    let currentCharacterCount = textField.text?.count ?? 0
    if (range.length + range.location > currentCharacterCount){
      return false
    }
    let newLength = currentCharacterCount + string.count - range.length
    return newLength <= 19
  }
  
  // MARK: Done button functionality on number pad
  
  func addDoneButtonOnKeyboard() {
    let doneToolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
    doneToolbar.barStyle       = UIBarStyle.default
    let flexSpace              = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
    let done: UIBarButtonItem  = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.doneButtonAction))
    
    var items = [UIBarButtonItem]()
    items.append(flexSpace)
    items.append(done)
    
    doneToolbar.items = items
    doneToolbar.sizeToFit()
    
    self.txtCardNumber.inputAccessoryView = doneToolbar
    self.txtCVV.inputAccessoryView = doneToolbar
  }
  
    @objc func doneButtonAction() {
    self.txtCardNumber.resignFirstResponder()
    self.txtCVV.resignFirstResponder()
    
    
  }
  
}
