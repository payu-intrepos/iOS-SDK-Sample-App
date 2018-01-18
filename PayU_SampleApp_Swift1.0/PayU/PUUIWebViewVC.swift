//
//  PUUIWebViewVC.swift
//  PayU_SampleApp_Swift1.0
//
//  Created by Ashish Kumar on 8/15/17.
//  Copyright © 2017 PayU Payments Private Limited. All rights reserved.
//

import Foundation
import UIKit
import PayU_coreSDK_Swift

class PUUIWebViewVC : UIViewController,UIWebViewDelegate {
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  var request = NSMutableURLRequest()
  @IBOutlet weak var webView: UIWebView!
  
  
  override func viewDidLoad() {
    
    
    self.webView.delegate = self
    
    webView.loadRequest(request as URLRequest)
    
    activityIndicator.startAnimating()
    
    self.navigationItem.hidesBackButton = true
    let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(PUUIWebViewVC.back(sender:)))
    self.navigationItem.leftBarButtonItem = newBackButton
    
  }
  
  func back(sender: UIBarButtonItem) {
    
    
    let alert = UIAlertController(title: "Cancel !", message: "Do you really want to cancel the transaction ?", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.default, handler: cancelTransaction))
    alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.default, handler: nil))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  func cancelTransaction( action : UIAlertAction)
  {
    _ = navigationController?.popToRootViewController(animated: true)
    
  }
  
  func webViewDidFinishLoad(_ webView: UIWebView) {
    
    activityIndicator.stopAnimating()
    activityIndicator.isHidden = true
    let response =  webView.stringByEvaluatingJavaScript(from: "PayU()")
    
    
    // [webView performSelectorOnMainThread:@selector(stringByEvaluatingJavaScriptFromString:) withObject:js waitUntilDone:NO]
    
    
    //    webView.performSelector(onMainThread: #selector(self.stringByEvaluatingJavaScriptFromString), with: "js", waitUntilDone: false)
    //    {
    //      
    //    }
    
    
    //    if (PayU.status == 1) {
    //      //success
    //    } else {
    //      //failure
    //    }
    //    
    
    
    if (response != "")
    {
      
      
      
      NotificationCenter.default.post(name: Notification.Name("PayUResponse"), object: response)
      
    }
    
  
    
  }
  
  
}
