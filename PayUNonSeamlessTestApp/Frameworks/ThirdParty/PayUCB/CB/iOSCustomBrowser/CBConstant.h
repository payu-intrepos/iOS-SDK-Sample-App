//
//  CBConstant.h
//  iOSCustomeBrowser
//
//  Created by Suryakant Sharma on 15/04/15.
//  Copyright (c) 2015 PayU, India. All rights reserved.
//

#ifndef iOSCustomeBrowser_CBConstant_h
#define iOSCustomeBrowser_CBConstant_h

#define iOS_MANUFACTURER         @"apple"
//#define CB_CODE                  @"10.0"
#define MERCHANT_ID              @"gtKFFx"
//#define SDK_CODE                 @"20.0"

#define CB_PRODUCTION_URL_WKWEBVIEW        @"https://secure.payu.in/js/sdk_js/v3/"
#define CB_PRODUCTION_URL_UIWEBVIEW        @"https://secure.payu.in/js/sdk_js/v4/"
#define CB_MOBILE_DEV_URL_WKWEBVIEW        @"https://mobiledev.payu.in/js/sdk_js/v3/"
#define CB_MOBILE_DEV_URL_UIWEBVIEW        @"https://mobiledev.payu.in/js/sdk_js/v4/"
#define CB_TEST_URL_WKWEBVIEW              @"https://test.payu.in/js/sdk_js/v3/"
#define CB_TEST_URL_UIWEBVIEW              @"https://test.payu.in/js/sdk_js/v4/"
#define CB_MOBILE_TEST_URL_WKWEBVIEW       @"https://mobiletest.payu.in/js/sdk_js/v3/"
#define CB_MOBILE_TEST_URL_UIWEBVIEW       @"https://mobiletest.payu.in/js/sdk_js/v4/"
#define CB_SDK_TEST_URL_WKWEBVIEW          @"https://sdktest.payu.in/js/sdk_js/v3/"
#define CB_SDK_TEST_URL_UIWEBVIEW          @"https://sdktest.payu.in/js/sdk_js/v4/"
#define CB_CB_TEST_URL_WKWEBVIEW           @"https://cbtest.payu.in/js/sdk_js/v3/"
#define CB_CB_TEST_URL_UIWEBVIEW           @"https://cbtest.payu.in/js/sdk_js/v4/"
#define CB_DEMO_TEST_URL_WKWEBVIEW         @"https://demotest.payu.in/js/sdk_js/v3/"
#define CB_DEMO_TEST_URL_UIWEBVIEW         @"https://demotest.payu.in/js/sdk_js/v4/"

#define CB_RETRY_PAYMENT_OPTION_URL        @"https://secure.payu.in/_payment_options"

#define CB_ANALYTICS_TEST_URL              @"https://test.payu.in/merchant/"
#define CB_ANALYTICS_PRODUCTION_URL        @"https://secure.payu.in/merchant/"
#define CB_ANALYTICS_MOBILE_DEV_URL        @"https://mobiledev.payu.in/merchant/"
#define CB_ANALYTICS_MOBILE_TEST_URL       @"https://mobiletest.payu.in/merchant/"
#define CB_ANALYTICS_SDK_TEST_URL          @"https://sdktest.payu.in/merchant/"
#define CB_ANALYTICS_CB_TEST_URL           @"https://cbtest.payu.in/merchant/"
#define CB_ANALYTICS_DEMO_TEST_URL         @"https://demotest.payu.in/merchant/"

//#define CB_MOBILE_TEST_URL(msg)  [CBConnectionHandler getBaseUrl:(msg)]

#define SCREEN_WIDTH  [[ UIScreen mainScreen ] bounds ].size.width

#define ENTER_OTP                   @"enterOTP"
#define CHOOSE                      @"choose"
#define OTP                         @"otp"
#define PIN                         @"pin"
#define INCORRECT_PIN               @"incorrectPIN"
#define INCORRECT_OTP               @"incorrectOTP"
#define CLOSE                       @"close"
#define CLOSE_LOADER                @"closeLoader"
#define REGISTER_OPTION             @"registerOption"

#define RETRY_OTP                   @"retryOTP"
#define REGERERATE                  @"regenerate"
#define REGERERATE_OTP              @"regenerate_otp"
#define OTP_LENGTH                  @"otp_length"
#define OTP_REGENERATE_TIMER        @"regen_timer"


#define DETECT_BANK_KEY @"detectBank"
#define INIT  @"init"

//Device Analytics Keys
#define KEY_SDK_VERSION_NAME @"sdk_version"
#define KEY_CB_VERSION_NAME @"cb_version"
#define KEY_IOS_VERSION @"os_version"
#define KEY_NETWORK_INFO @"network_info"
#define KEY_NETWORK_STRENGTH @"network_strength"
#define KEY_DEVICE_RESOLUTION @"resolution"
#define KEY_DEVICE_MANUFACTURER @"device_manufacturer"
#define KEY_DEVICE_MODEL @"device_model"
#define KEY_MERCHANT_ID @"merchant_key"
#define KEY_TXNID @"txnid"

//#define     PARAM_TXID                      @"txnid"

#define DEVICE_ANALYTICS @"DeviceAnalytics"
#define EVENT_ANALYTICS @"EventAnalytics"
#define ANALYTICS_TIMEOUT_INTERVAL 5
#define DA_URL_PATH @"mobileWebService.php"
#define EA_URL_PATH @"postservice.php?form=2"
#define KEY_DADATA_SENT @"deviceAnalyticsDataSent"

//Event Analytics Keys
#define KEY_USER_INPUT @"user_input"
#define KEY_CB_STATUS @"cb_status"
#define KEY_OTP_RECEIVED @"otp_received"
#define KEY_TRXN_STATUS @"trxn_status"
#define KEY_LAST_URL @"last_url"

#define KEY_M_EURL @"m_retry_error"
//#define KEY_MAGIC_RETRY @"magic_retry"
#define KEY_MR_USER_INPUT @"m_retry_input"

#define KEY_DETECT_OTP @"detect_otp"

#define KEY_BANK_NAME @"bank"
#define KEY_PACKAGE_NAME @"package_name"
#define KEY_NAME @"key"
#define KEY_VALUE_NAME @"value"

//Event Analytics Values
#define VAL_PAYMENT_INITIATED @"payment_initiated"
#define VAL_CUSTOM_BROWSER @"custom_browser"
#define VAL_NON_CUSTOM_BROWSER @"non_custom_browser"
#define VAL_PASSWORD @"password_click"
#define VAL_OTP @"otp_click"
#define VAL_OTP_DIRECT @"received_otp_direct"
#define VAL_OTP_SELECTED @"received_otp_selected" // Auto read OTP
#define VAL_OTP_REGENERATE @"received_otp_regenerate" // Received OTP after regenerating and auto reading
#define VAL_OTP_WEB @"otp_web" // This is for receiving OTP after interacting with webpage
#define VAL_AUTOMATIC_OTP_SELECT @"auto_otp_select"
//#define VAL_AUTOMATIC_APPROVE_CLICK @"auto_approve"
#define VAL_SUCCESS_TRANSACTION @"success_transaction"
#define VAL_FAILURE_TRANSACTION @"failure_transaction"
#define VAL_TERMINATE_TRANSACTION @"terminate_transaction"

#define VAL_ENTER_MANUALLY @"enter_manually_click" // When OTP is entered manually
#define VAL_APPROVED @"approved_otp"
#define VAL_ALL_OPTION_VIEW @"all_option_view"
#define VAL_REGENERATE_CLICKED @"regenerate_click"

#define VAL_SHOW_M_RETRY @"show_m_retry"
#define VAL_CLICK_M_RETRY @"click_m_retry"

//CB_SERVER_ID Constants
#define CB_ENVIRONMENT_PRODUCTION              @"Production"
#define CB_ENVIRONMENT_MOBILETEST              @"MobileTest"
#define CB_ENVIRONMENT_MOBILEDEV               @"MobileDev"
#define CB_ENVIRONMENT_TEST                    @"Test"
#define CB_ENVIRONMENT_SDKTEST                 @"SDKTest"
#define CB_ENVIRONMENT_CBTEST                  @"CBTest"
#define CB_ENVIRONMENT_DEMOTEST                @"DemoTest"

// logging on/off
#ifdef DEBUG
#define PayULog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define PayULog(...)
#endif


// constants for CBConnection
#define  PG_URL_LIST            @"pgUrlList"
#define INFO_DICT_RESPONSE      @"response"

//Constants for Magic Retry
#define IS_MR_ENABLED @"isMREnabled"
#define IS_MR_WINDOW_SHOWN @"isMRWindowShown"
#define MR_ERROR_CODE @"mrErrorCode"

/*
 
 load custome view
 
 */

#define loadView() \
NSBundle *mainBundle = [NSBundle mainBundle]; \
NSArray *views = [mainBundle loadNibNamed:NSStringFromClass([self class]) owner:self options:nil]; \
[self addSubview:views[0]];

#define loadViewWithName(name) \
NSBundle *mainBundle = [NSBundle mainBundle]; \
NSArray *views = [mainBundle loadNibNamed:name owner:self options:nil]; \
[self addSubview:views[0]];


#define     IPHONE_3_5    480
#define     IPHONE_4      568
#define     IPHONE_4_7    667
#define     IPHONE_5_5    736

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#endif
