//
//  PUSAGenerateHashes.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit

import PayU_coreSDK_Swift


let URLGetHash = "https://payu.herokuapp.com/get_hash"
let URLGetMerchantHash = "https://payu.herokuapp.com/get_merchant_hashes"
let URLStoreMerchantHash = "https://payu.herokuapp.com/store_merchant_hash"

class PUSAGenerateHashes : UIViewController
{
 
  var errorMessage = String()
  
  public  typealias hashesAfterCompletionBlock =  (PayUModelHashes, String) -> Void
  public typealias responseAfterSavedMerchantData = ( String, String) -> Void
  
  // MARK: function to generate hashes from server
  
  func generateHashesFromServer (withPaymentParams paymentParams : PayUModelPaymentParams, withCompletion blockAfterCompletion :@escaping hashesAfterCompletionBlock )
  {
    
    
    
    let callBackForCreateHashesWithParams: ((_ hashes: PayUModelHashes, _ error: String) -> Void) = blockAfterCompletion
    
    // test URL to get hash values, you shoud pass your own Server URL here
    // further info pls visit : https://github.com/payu-intrepos/Documentations/wiki/4.-Server-Side
    
    let urlString = URLGetHash
    
    let url = URL(string: urlString)
    
    let hashRequest = NSMutableURLRequest(url: url! as URL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60)
    
    hashRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    hashRequest.httpMethod = "POST"
    
    let postParams  = NSMutableString()
    
    postParams.appendFormat("offer_key=%@&key=%@&email=%@&amount=%@&firstname=%@&txnid=%@&user_credentials=%@&udf1=%@&udf2=%@&udf3=%@&udf4=%@&udf5=%@&productinfo=%@", self.checkParameterForNil(parameter: paymentParams.offerKey!),self.checkParameterForNil(parameter: paymentParams.key!),self.checkParameterForNil(parameter: paymentParams.email!),self.checkParameterForNil(parameter: paymentParams.amount!), self.checkParameterForNil(parameter: paymentParams.firstName!), self.checkParameterForNil(parameter: paymentParams.txnId!),self.checkParameterForNil(parameter: paymentParams.userCredentials!),self.checkParameterForNil(parameter: paymentParams.udf1!),self.checkParameterForNil(parameter: paymentParams.udf2!),self.checkParameterForNil(parameter: paymentParams.udf3!),self.checkParameterForNil(parameter: paymentParams.udf4!),self.checkParameterForNil(parameter: paymentParams.udf5!),self.checkParameterForNil(parameter: paymentParams.productInfo!))
    
    
    
    
    var postParamsForRequest = postParams as String
    
    hashRequest.httpBody = (postParams.data(using:String.Encoding.utf8.rawValue))
    
    
    let session = URLSession.shared
    
    
    session.dataTask(with: hashRequest as URLRequest) { (data, response, error) in
      
      
     
      
      if let data = data
      {
        
        
        do
        {
          
          let PUHashes = PayUModelHashes()
          var jsonResult  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
          
          var statusString = "\(jsonResult.value(forKey: "message")!)"
          if statusString != "successfully generated hash"
          {
            let alert = UIAlertController(title: "oops !", message: (jsonResult.value(forKey: "message")! as! String), preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
          //  print(jsonResult.value(forKey: "message")! as! String)
            callBackForCreateHashesWithParams(PUHashes, (jsonResult.value(forKey: "message")! as! String))
            
          }
          else
          {
      
        PUHashes.paymentHash = jsonResult.value(forKey: "payment_hash") as! Optional<String>
        PUHashes.paymentRelatedDetailsHash = jsonResult.value(forKey: "payment_related_details_for_mobile_sdk_hash") as! Optional<String>
        PUHashes.VASForMobileSDKHash = jsonResult.value(forKey: "vas_for_mobile_sdk_hash") as! Optional<String>
        PUHashes.deleteUserCardHash = jsonResult.value(forKey: "delete_user_card_hash") as! Optional<String>
        PUHashes.editUserCardHash = jsonResult.value(forKey: "edit_user_card_hash") as! Optional<String>
        PUHashes.saveUserCardHash = jsonResult.value(forKey: "save_user_card_hash") as! Optional<String>
        PUHashes.getUserCardHash = jsonResult.value(forKey: "get_user_cards_hash") as! Optional<String>
        PUHashes.offerHash = jsonResult.value(forKey: "check_offer_status_hash") as! Optional<String>
        
        callBackForCreateHashesWithParams(PUHashes,"")

          }
//          callBackForCreateHashesWithParams(PUHashes,"")

        }
        catch
        {
//          let obHashes = PayUModelHashes()
//          callBackForCreateHashesWithParams(obHashes,error.localizedDescription)
        }
      }
      else
      {
        print("data is not true")
      }
      }.resume()
    
    
    
  }
  
  
 // MARK: Function to fetch one tap token from server
  
  public typealias oneTapDataFromServer =  (NSDictionary , _ error : String) -> Void
  
  func fetchOneTapTokenFromServer (withParams paymentParams : PayUModelPaymentParams,  withCompletion blockAfterCompletion : @escaping oneTapDataFromServer  )
  {
  
    var dictCardTokenMerchantHash = NSMutableDictionary()

    let callBackForOneTapData : ((NSDictionary , _ error : String) -> Void ) = blockAfterCompletion
    let urlString = URLGetMerchantHash
    
    let url = URL(string: urlString)
    
    let hashRequest = NSMutableURLRequest(url: url! as URL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60)
    
    hashRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    hashRequest.httpMethod = "POST"
    
    var postParams  = NSMutableString()
    
    postParams.appendFormat("merchant_key=%@&user_credentials=%@",paymentParams.key!,paymentParams.userCredentials!)


    
    
    var postParamsForRequest = postParams as String
    
    hashRequest.httpBody = (postParams.data(using:String.Encoding.utf8.rawValue))
    
    
    let session = URLSession.shared
    
    
    session.dataTask(with: hashRequest as URLRequest) { (data, response, error) in
      

      if let data = data
      {
        
        
        do
        {
          
         
          var jsonResult  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
          
          
          print(jsonResult)
          
          if (jsonResult.object(forKey: "message") as! String == "Merchant hash fetched successfully")
          {
            
            let arrayData : NSArray = jsonResult.object(forKey: "data") as! NSArray
            
            var tempArray = NSArray()

            for eachToken in arrayData  {
            
             // tempArray = arrayData[0] as! NSArray
              
              tempArray = eachToken as! NSArray
              
             
               dictCardTokenMerchantHash.setValue(tempArray[1], forKey: tempArray[0] as! String)

              
            //  print(tempArray)
              
              
            }
            
            
            

            
            
          }
          
          
        //  callBackForCreateHashesWithParams(PUHashes,"")
          
          
          callBackForOneTapData(dictCardTokenMerchantHash ,"")
          
          
          
        }
        catch
        {
//          let obHashes = PayUModelHashes()
//          callBackForCreateHashesWithParams(obHashes,error.localizedDescription)
        }
        
      }
      }.resume()
    
    
   // return  ["cardToken": "Merchant_Hash"]
    
  }
  
  
  
  
// MARK: Function to save Merchant Token Hash
  
  
  func saveOneTapDataAtMerchantServer (Key : String, withCardToken cardToken:String, forUserCredentials userCredentials : String, withMerchantHash merchantHash:String , withCompletionBlock  blockAfterCompletion : @escaping  responseAfterSavedMerchantData )
  {
    
    var postParam = NSMutableString()
    
    
    let callBackForOneTapToken : (( _ message : String, _ errorMessage : String) -> Void) = blockAfterCompletion
    postParam.appendFormat("merchant_key=%@&user_credentials=%@&card_token=%@&merchant_hash=%@",Key,userCredentials,cardToken,merchantHash)
  
    let urlString = URLStoreMerchantHash

    let url = URL(string: urlString)
    
    let hashRequest = NSMutableURLRequest(url: url! as URL, cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 60)
    
    hashRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
    
    hashRequest.httpMethod = "POST"
        
    var postParamsForRequest = postParam as String
    
    hashRequest.httpBody = (postParam.data(using:String.Encoding.utf8.rawValue))
    
    let session = URLSession.shared
    session.dataTask(with: hashRequest as URLRequest) { (data, response, error) in
      
      if let data = data
      {
        
        do
        {
          
          var jsonResult  = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
          
   
          
          callBackForOneTapToken("\(jsonResult)" ,"")
          
        }
        catch
        {
          //          let obHashes = PayUModelHashes()
          //          callBackForCreateHashesWithParams(obHashes,error.localizedDescription)
        }
        
      }
      }.resume()
    
  }
  
  // check if parameters passed is nil
  
  func checkParameterForNil (parameter : String)-> String
  {
    if (parameter == "")
    {
      return ""
    }
    else
    {
      return parameter
    }
  }
  
  
  // generating hash internally in SDK, not recommanded as it is not safe to generate internal hash
  
 
  
  
  
  
}
