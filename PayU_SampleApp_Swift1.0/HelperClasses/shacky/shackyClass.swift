//
//  File.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 11/6/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift


// Please do not use this class as generating hash internally in SDK is risky & not recommanded, the app can be hacked as well

class shackyClass: UIViewController {
 
  
  func generateHashesFromShackyClass(paymentParams : PayUModelPaymentParams , withSalt : String) {
  
    
    let postParams_payment_related_details_hash = "\(paymentParams.key!)" + "|" + "payment_related_details_for_mobile_sdk" + "|" + "\(paymentParams.userCredentials!)" + "|" + "\(withSalt)"
    
    let payment_related_details_hash = sha512(string: postParams_payment_related_details_hash)
    
    let postParams_VAS = "\(paymentParams.key!)" + "|" + "vas_for_mobile_sdk" + "|" + "\("default")" + "|" + "\(withSalt)"
    
    let VAS_Hash = sha512(string: postParams_VAS)
    
    let postParams_deleteCard = "\(paymentParams.key!)" + "|" + "delete_user_card" + "|" + "\(paymentParams.userCredentials!)" + "|" + "\(withSalt)"
    
    let deleteCard_Hash = sha512(string: postParams_deleteCard)
    let postParams_edit_user_card =  "\(paymentParams.key!)" + "|" + "edit_user_card_hash" + "|" + "\(paymentParams.userCredentials!)" + "|" + "\(withSalt)"
    let editCard_Hash = sha512(string: postParams_edit_user_card)
    
    let postParams_save_user_card = "\(paymentParams.key!)" + "|" + "save_user_card" + "|" + "\(paymentParams.userCredentials!)" + "|" + "\(withSalt)"
    
    let saveUserCard_Hash = sha512(string: postParams_save_user_card)
    
    let postParams_get_user_card = "\(paymentParams.key!)" + "|" + "get_user_card" + "|" + "\(paymentParams.userCredentials!)" + "|" + "\(withSalt)"
    
    let getUserCard_Hash = sha512(string: postParams_get_user_card)
    
    let postParams_check_offer_status = "\(paymentParams.key!)" + "|" + "check_offer_status" + "|" + "\(paymentParams.userCredentials!)" + "|" + "\(withSalt)"
    
    let offerStatus_Hash = sha512(string: postParams_check_offer_status)
    
    //  key|txnid|amount|productinfo|firstname|email|udf1|udf2|udf3|udf4|udf5||||||salt
    
    let postParams_payment_hash = "\(paymentParams.key!)" + "|" + "\(paymentParams.txnId!)" + "|" + "\(paymentParams.amount!)" + "|" + "\(paymentParams.productInfo!)" + "|" + "\(paymentParams.firstName!)" + "|" + (paymentParams.email!) + "|" + (paymentParams.udf1!) + "|" + (paymentParams.udf2!) + "|" + (paymentParams.udf3!) + "|" + (paymentParams.udf4!) + "|" + (paymentParams.udf5!) + "|" + "|" + "|" + "|" + "|" + "|" + "\(withSalt)"
    
    let paymentHash = sha512(string: postParams_payment_hash)
    
    
    paymentParams.hashes.paymentRelatedDetailsHash = payment_related_details_hash
    paymentParams.hashes.VASForMobileSDKHash = VAS_Hash
    paymentParams.hashes.deleteUserCardHash = deleteCard_Hash
    paymentParams.hashes.editUserCardHash = editCard_Hash
    paymentParams.hashes.saveUserCardHash = saveUserCard_Hash
    paymentParams.hashes.getUserCardHash = getUserCard_Hash
    paymentParams.hashes.offerHash = offerStatus_Hash
    paymentParams.hashes.paymentHash = paymentHash
    
  }
  
  
  func sha512( string: String) -> String {
    var digest = [UInt8](repeating: 0, count: Int(CC_SHA512_DIGEST_LENGTH))
    if let data = string.data(using: String.Encoding.utf8) {
      let value =  data as NSData
      CC_SHA512(value.bytes, CC_LONG(data.count), &digest)
      
    }
    var digestHex = ""
    for index in 0..<Int(CC_SHA512_DIGEST_LENGTH) {
      digestHex += String(format: "%02x", digest[index])
    }
    
    return digestHex
  }
  
  
  
}
