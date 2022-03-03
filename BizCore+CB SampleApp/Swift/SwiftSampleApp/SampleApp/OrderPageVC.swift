//
//  OrderPageVC.swift
//  SwiftSampleApp
//
//  Created by Vipin Aggarwal on 18/04/19.
//  Copyright © 2019 Vipin Aggarwal. All rights reserved.
//

import UIKit

class OrderPageVC: UIViewController {

    @IBOutlet weak var saltSwitch: UISwitch!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var checkout: UIButton!
    @IBOutlet weak var checkoutBottom: NSLayoutConstraint!
    @IBOutlet weak var saltTfToSuperViewBottom: NSLayoutConstraint!

    //Text Fields
    @IBOutlet weak var merchantKey: UITextField!
    @IBOutlet weak var transactionId: UITextField!
    @IBOutlet weak var amount: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var environment: UITextField!
    @IBOutlet weak var userCredential: UITextField!
    @IBOutlet weak var surepayCount: UITextField!
    @IBOutlet weak var salt: UITextField!
    @IBOutlet weak var beneficiaryDetails: UITextField!
    

    //Properties
    var isKeyboardVisible = false
    let paymentParams = PayUModelPaymentParams()
    let activityIndicator = ActivityIndicator()

    let checkoutStoryboardID = "PUUIMainStoryBoard"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupGestureOnContentView()
        setupKeyboardHandlers()
        addPaymentResponseNotification()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupInitialValues()
    }

    func setupInitialValues() {
        merchantKey.text = "gtKFFx"
        email.text = "email@example.com"
        transactionId.text = randomString(length: 6)
        amount.text = "1"
        environment.text = ENVIRONMENT_TEST
        userCredential.text = "merchantKey:uniqueUserIDAtMerchantEnd"
        surepayCount.text = "2"
        salt.text = "<Please_add_test_salt_here>"
        beneficiaryDetails.text = ""
    }



    @IBAction func checkoutButtonClicked(_ sender: Any) {

        //Dismiss keyboard
        contentView.endEditing(true)

        // MARK: - Step 1 -- Set Payment Parameters -
        setPaymentParams()

        weak var weakSelf = self

        // MARK:  Step 2 -- Generate hashes -
        if saltSwitch.isOn {
            //You must never calculate hash locally. It is a big secruity risk. Below code is for demonstration purpose only.
            let vulnerableClass = PayUDontUseThisClass()
            activityIndicator.startActivityIndicatorOn(self.view)

            vulnerableClass.getPayUHashes(withPaymentParam: paymentParams, merchantSalt: salt.text) { (allHashes, hashString, errorMessage) in
                weakSelf?.activityIndicator.stopActivityIndicator()
                hashGenerated(hashes: allHashes, withError: errorMessage)
            }
        } else {
            activityIndicator.startActivityIndicatorOn(self.view)
            //Calculate hash on your server
            PUSAHelperClass.generateHash(fromServer: paymentParams) { (allHashes, errorString) in
                weakSelf?.activityIndicator.stopActivityIndicator()
                hashGenerated(hashes: allHashes, withError: errorString)
            }
        }

        func hashGenerated(hashes: PayUModelHashes?, withError error:String?) {
            if let err = error {
                print("Error occured in generating hash: \(err)")
            } else {
                DispatchQueue.main.async {
                    weakSelf?.saveHashesAndProceedToFetchPaymentRelatedDetails(hashes)
                }
            }
        }
    }

    //Set Payment Parameters
    func setPaymentParams() {
        paymentParams.key = merchantKey.text
        paymentParams.transactionID = transactionId.text
        paymentParams.amount = amount.text
        paymentParams.firstName = "John"
        paymentParams.email = email.text
        paymentParams.phoneNumber = "9999900000"
        paymentParams.environment = environment.text
        paymentParams.udf1 = ""
        paymentParams.udf2 = ""
        paymentParams.udf3 = ""
        paymentParams.udf4 = ""
        paymentParams.udf5 = ""
        paymentParams.userCredentials = userCredential.text
        paymentParams.surl = "https://payu.herokuapp.com/ios_success"
        paymentParams.furl = "https://payu.herokuapp.com/ios_failure"
        self.paymentParams.checkAdditionalCharges = true;
        self.paymentParams.checkDownStatus = true;
        self.paymentParams.checkTaxSpecification = true;
        self.paymentParams.checkCustomerEligibility = true;
        paymentParams.beneficiaryAccountNumbers = beneficiaryDetails.text
        paymentParams.productInfo = "iPhoneXS" //Add information about the production for which transaction is being initiated
    }

    // MARK: - Step 3 -- Fetch available payment methods -
    func saveHashesAndProceedToFetchPaymentRelatedDetails(_ hashes: PayUModelHashes?) {
        paymentParams.hashes = hashes
        let webserviceResposne = PayUWebServiceResponse()
        weak var weakSelf = self
        activityIndicator.startActivityIndicatorOn(self.view)

        webserviceResposne?.getPayUPaymentRelatedDetail(forMobileSDK: paymentParams) { (paymentRelatedDetails, errorMessage, extraParam) in
            weakSelf?.activityIndicator.stopActivityIndicator()
            if let wself = weakSelf {
                if let error = errorMessage {
                    print("Error occured in fetching payment related details: \(error)")
                    return
                } else {

                    // MARK: - Step 4 -- Show PayU's checkout UI -
                    let checkoutStoryBoard = UIStoryboard.init(name: wself.checkoutStoryboardID, bundle: nil)
                    let checkoutInitialVC = checkoutStoryBoard.instantiateViewController(withIdentifier: VC_IDENTIFIER_PAYMENT_OPTION) as! PUUIPaymentOptionVC
                    checkoutInitialVC.paymentParam = wself.paymentParams
                    if let spCount = wself.surepayCount.text {
                        checkoutInitialVC.surePayCount = Int(spCount)!
                    }
                    checkoutInitialVC.paymentRelatedDetail = paymentRelatedDetails
                    wself.navigationController?.pushViewController(checkoutInitialVC, animated: true)
                }
            }
        }
    }

    // MARK: Response handling -

    @objc func responseReceived(notification: NSNotification) {

        let notificationObj = notification.object as? Dictionary<String, AnyObject>
        if let dict = notificationObj {
            if let merchantResponse = dict["merchantResponse"] {
                print("Merchant Response :\n \(merchantResponse)")
            }
            if let payuResponse = dict["payUResponse"] {
                print("PayU Response :\n \(payuResponse)")
            }
        } else {
            print("Response not received")
        }
    }

    // MARK: Helper methods -

    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }

    func addPaymentResponseNotification() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.responseReceived),
            name: NSNotification.Name(rawValue: kPUUINotiPaymentResponse),
            object: nil)
    }














    // MARK: - UI Stuff -

    @IBAction func saltToggled(_ sender: UISwitch) {
        salt.isHidden = sender.isOn ? false : true
        beneficiaryDetails.isHidden = sender.isOn ? false : true
        beneficiaryDetails.text = ""
    }

    func setupKeyboardHandlers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidHide(notification:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if navigationController?.topViewController?.isKind(of: OrderPageVC.self) == false {
            return
        }

        if isKeyboardVisible {
            return
        }

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            weak var weakSelf = self
            UIView.animate(withDuration: notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double) {
                weakSelf?.scrollViewHeight.constant -= keyboardSize.size.height
                weakSelf?.checkoutBottom.constant += keyboardSize.size.height
                weakSelf?.saltTfToSuperViewBottom.priority = UILayoutPriority(999)
                weakSelf?.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification)  {
        if navigationController?.topViewController?.isKind(of: OrderPageVC.self) == false {
            return
        }

        if isKeyboardVisible == false {
            return
        }

        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            weak var weakSelf = self
            UIView.animate(withDuration: notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double) {
                weakSelf?.scrollViewHeight.constant += keyboardSize.size.height
                weakSelf?.checkoutBottom.constant -= keyboardSize.size.height
                weakSelf?.saltTfToSuperViewBottom.priority = UILayoutPriority(700)
                weakSelf?.view.layoutIfNeeded()
            }
        }
    }

    @objc func keyboardDidShow(notification: NSNotification)  {
        isKeyboardVisible = true
    }

    @objc func keyboardDidHide(notification: NSNotification)  {
        isKeyboardVisible = false
    }

    func setupGestureOnContentView () {
        let tapGesture = UITapGestureRecognizer(target: self, action:  #selector (self.contentViewTapped (_:)))

        contentView.addGestureRecognizer(tapGesture)
    }

    @objc func contentViewTapped(_ sender:UITapGestureRecognizer) {
        contentView.endEditing(true)
    }
}

