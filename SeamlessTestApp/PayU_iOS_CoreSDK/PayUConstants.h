//
//  PayUConstants.h
//  PayU_iOS_CoreSDK
//
//  Created by Umang Arya on 30/09/15.
//  Copyright © 2015 PayU. All rights reserved.
//

#ifndef PayUConstants_h
#define PayUConstants_h

//Device Analytics constants
#define DEVICE_ANALYTICS @"DeviceAnalytics"
#define ANALYTICS_TIMEOUT_INTERVAL 5
#define KEY_DADATA_SENT @"deviceAnalyticsDataSent"
#define DA_URL_PATH @"mobileWebService.php"
#define iOS_MANUFACTURER         @"apple"

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

//SERVER_ID Constants
#define ENVIRONMENT_PRODUCTION              @"Production"
#define ENVIRONMENT_MOBILETEST              @"MobileTest"
#define ENVIRONMENT_MOBILEDEV               @"MobileDev"

// 0 for production server, 1 for Mobile Test server, 2 for Dev server
#define CB_ANALYTICS_SERVER_ID ENVIRONMENT_MOBILETEST

// 0 if pointing to payu production server, 1 for test server
#define TEST_SERVER 0

#define ANALYTICS_PRODUCTION_URL                @"https://secure.payu.in/merchant/"
#define ANALYTICS_MOBILE_DEV_URL                @"https://mobiledev.payu.in/merchant/"
#define ANALYTICS_MOBILE_TEST_URL               @"https://mobiletest.payu.in/merchant/"

#define PAYU_PAYMENT_PRODUCTION_URL                             @"https://secure.payu.in/_payment"
#define PAYU_PAYMENT_MOBILETEST_URL                             @"https://mobiletest.payu.in/_payment"

#define PAYU_WEBSERVICE_PRODUCTION_URL                          @"https://info.payu.in/merchant/postservice.php?form=2"
#define PAYU_WEBSERVICE_MOBILETEST_URL                          @"https://mobiletest.payu.in/merchant/postservice?form=2"

#define ENVIRONMENT_PRODUCTION                                  @"Production"
#define ENVIRONMENT_MOBILETEST                                  @"MobileTest"


//Errors
//Mandatory params error list
#define ERROR_KEY_IS_MISSING                                    @"Key is missing, "

#define ERROR_TRANSACTIONID_IS_MISSING                          @"Transaction ID is missing, "
#define ERROR_TRANSACTIONID_GREATER_THAN_25                     @"Transaction ID greater than 25 character, "

#define ERROR_AMOUNT_IS_MISSING                                 @"Amount is missing, "
#define ERROR_AMOUNT_IS_NONNUMERIC                              @"Amount is non-numeric, "
#define ERROR_AMOUNT_CONTAIN_MORE_THAN_ONE_DECIMAL              @"Amount contain more than one decimal, "
#define ERROR_AMOUNT_IS_LESS_THAN_MINIMUM_AMOUNT                @"Amount is less than minimum amount"


#define ERROR_PRODUCTINFO_IS_MISSING                            @"Product Info is missing, "
#define ERROR_PRODUCTINFO_GREATER_THAN_100                      @"Product Info greater than 100 character, "

#define ERROR_FIRSTNAME_IS_MISSING                              @"First name is missing, "
#define ERROR_FIRSTNAME_GREATER_THAN_60                         @"First name greater than 60 character, "

#define ERROR_EMAIL_IS_MISSING                                  @"email ID is missing, "
#define ERROR_EMAIL_INVALID                                     @"email ID is invalid, "

#define ERROR_PHONENUMBER_IS_MISSING                            @"Phone number is missing, "
#define ERROR_PHONENUMBER_GREATER_THAN_50                       @"Phone number greater than 50 character, "

#define ERROR_SURL_IS_MISSING                                   @"SURL is missing, "

#define ERROR_FURL_IS_MISSING                                   @"FURL is missing, "

#define ERROR_HASH_IS_MISSING                                   @"hash is missing, "

#define ERROR_EXPIRY_MONTH_IS_MISSING                           @"Expiry month is missing, "
#define ERROR_EXPIRY_MONTH_IS_NONNUMERIC                        @"Expiry month is non-numeric, "
#define ERROR_EXPIRY_MONTH_IS_OUT_OF_RANGE                      @"Expiry month is not between 1-12, "
#define ERROR_EXPIRY_MONTH_IS_LESS_THAN_CURRENT_MONTH           @"Expiry month is less than current month, "

#define ERROR_EXPIRY_YEAR_IS_MISSING                            @"Expiry year is missing, "
#define ERROR_EXPIRY_YEAR_IS_NONNUMERIC                         @"Expiry year is non-numeric, "
#define ERROR_EXPIRY_YEAR_LESSER_THAN_CURRENT_YEAR              @"Expiry year can't be less than current year, "

#define ERROR_EXPIRY_YEAR_LENGTH_GREATER_THAN_5                 @"Expiry year length greater than 5 digit, "

#define ERROR_NAME_ON_CARD_IS_MISSING                           @"Name on card is missing, "

#define ERROR_CARD_NUMBER_IS_MISSING                            @"Card number is missing, "
#define ERROR_CARD_NUMBER_LENGTH_LESS_THAN_12                   @"Card number length is less than 12 digit, "
#define ERROR_CARD_NUMBER_IS_INVALID                            @"Card number or CardBin is Invalid, "
#define ERROR_CARD_NUMBER_IS_NON_NUMERIC                        @"Card number is non-numeric, "

#define ERROR_CVV_IS_MISSING                                    @"CVV is missing, "
#define ERROR_CVV_LENGTH_SHOULD_BE_4_FOR_AMEX                   @"CVV length should be 4 for AMEX, "
#define ERROR_CVV_LENGTH_SHOULD_BE_3_FOR_NON_AMEX               @"CVV length should be 3 for NON-AMEX, "
#define ERROR_CVV_IS_NON_NUMERIC                                @"CVV is non-numeric, "

#define ERROR_SAVE_STORECARD_FLAG_IS_INVALID                    @"Save StoredCard flag is invalid, "

#define ERROR_ENVIRONMENT_IS_MISSING                            @"Production or test environment is missing, "
#define ERROR_ENVIRONMENT_INVALID                               @"Environment Should be 0 or 1, "

#define ERROR_BANK_CODE_IS_MISSING                              @"Bank Code is missing, "

#define ERROR_COMMAND_IS_MISSING                                @"Command is missing, "

#define ERROR_OFFER_KEY_IS_MISSING                              @"Offer Key is missing, "

#define ERROR_STORED_CARD_TOKEN_IS_MISSING                      @"Stored card token is missing, "
#define ERROR_STORED_CARD_TYPE_IS_MISSING                       @"Stored card type is missing, "
#define ERROR_STORED_CARD_MODE_IS_MISSING                       @"Stored card mode is missing, "

#define ERROR_USER_CREDENTIAL_IS_MISSING                        @"User credentials is missing, "

#define ERROR_VAS_INVALID_CARDBIN_OR_BANKCODE                   @"Invalid cardbin or bank code"
#define ERROR_VAS_API_NOT_CALLED                                @"VAS API not called"

#define VAS_DOWN_TIME_MESSAGE_FOR_NETBANKING                    @" Oops! %@ seems to be down. We recommend you to pay using any other means of payment."
#define VAS_DOWN_TIME_MESSAGE_FOR_CARD                          @"We are experiencing high failures for %@ card at this time. We recommend you to pay using any other means of payment."
#define ERROR_EMI_MODE_IS_MISSING                               @"EMI mode is missing, "

#define ERROR_CASH_CARD_IS_MISSING                              @"Cash Card is missing, "

//#define ERROR_FREE                                            @"Error free"


// Regex

#define EMAIL_REGEX                                             @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"


// Payment Type

#define     PAYMENT_PG_NET_BANKING                              @"NB"
#define     PAYMENT_PG_CCDC                                     @"CC"
#define     PAYMENT_PG_STOREDCARD                               @"SC"
#define     PAYMENT_PG_EMI                                      @"EMI"
#define     PAYMENT_PG_CASHCARD                                 @"CASH"
#define     PAYMENT_PG_PAYU_MONEY                               @"wallet"

#define     PAYMENT_PG_INVALID                                  @"Invalid payment method, "



// Set values

#define MINIMUM_AMOUNT                                          @"0.1"
#define MAXIMUM_YEAR_LIMIT                                      @"100"



// Commands for webservice

#define COMMAND_PAYMENT_RELATED_DETAILS_FOR_MOBILE_SDK          @"payment_related_details_for_mobile_sdk"
#define COMMAND_CHECK_OFFER_STATUS                              @"check_offer_status"
#define COMMAND_DELETE_USER_CARD                                @"delete_user_card"
#define COMMAND_VAS_FOR_MOBILE_SDK                              @"vas_for_mobile_sdk"
#define COMMAND_EDIT_USER_CARD                                  @"edit_user_card"
#define COMMAND_SAVE_USER_CARD                                  @"save_user_card"
#define COMMAND_GET_USER_CARD                                   @"get_user_cards"




#define     PARAM_COMMAND                                       @"command"
#define     PARAM_VAR1                                          @"var1"
#define     PARAM_VAR2                                          @"var2"
#define     PARAM_VAR3                                          @"var3"
#define     PARAM_VAR4                                          @"var4"
#define     PARAM_VAR5                                          @"var5"
#define     PARAM_VAR6                                          @"var6"
#define     PARAM_VAR7                                          @"var7"
#define     PARAM_VAR8                                          @"var8"
#define     PARAM_VAR9                                          @"var9"
#define     PARAM_VAR10                                         @"var10"
#define     PARAM_VAR11                                         @"var11"
#define     PARAM_VAR12                                         @"var12"
#define     PARAM_VAR13                                         @"var13"
#define     PARAM_VAR14                                         @"var14"
#define     PARAM_VAR15                                         @"var15"
#define     PARAM_DEFAULT                                       @"default"

// payment params
#define     PARAM_KEY                                           @"key"
#define     PARAM_TXNID                                         @"txnid"
#define     PARAM_AMOUNT                                        @"amount"
#define     PARAM_PRODUCT_INFO                                  @"productinfo"
#define     PARAM_FIRST_NAME                                    @"firstname"
#define     PARAM_LAST_NAME                                     @"lastname"
#define     PARAM_EMAIL                                         @"email"
#define     PARAM_PHONE                                         @"phone"
#define     PARAM_ADDRESS_1                                     @"address1"
#define     PARAM_ADDRESS_2                                     @"address2"
#define     PARAM_CITY                                          @"city"
#define     PARAM_STATE                                         @"state"
#define     PARAM_COUNTRY                                       @"country"
#define     PARAM_ZIPCODE                                       @"zipcode"
#define     PARAM_UDF_1                                         @"udf1"
#define     PARAM_UDF_2                                         @"udf2"
#define     PARAM_UDF_3                                         @"udf3"
#define     PARAM_UDF_4                                         @"udf4"
#define     PARAM_UDF_5                                         @"udf5"
#define     PARAM_SURL                                          @"surl"
#define     PARAM_FURL                                          @"furl"
#define     PARAM_CURL                                          @"curl"
#define     PARAM_HASH                                          @"hash"
#define     PARAM_CODURL                                        @"codurl"
#define     PARAM_DROP_CATEGORY                                 @"drop_category"
#define     PARAM_ENFORCE_PAY_METHOD                            @"enforce_paymethod"
#define     PARAM_CUSTOM_NOTE                                   @"custom_note"
#define     PARAM_NOTE_CATEGORY                                 @"note_category"
#define     PARAM_API_VERSION                                   @"api_version"
#define     PARAM_SHIPPING_FIRSTNAME                            @"shipping_firstname"
#define     PARAM_SHIPPING_LASTNAME                             @"shipping_lastname"
#define     PARAM_SHIPPING_ADDRESS_1                            @"shipping_address1"
#define     PARAM_SHIPPING_ADDRESS_2                            @"shipping_address2"
#define     PARAM_SHIPPING_CITY                                 @"shipping_city"
#define     PARAM_SHIPPING_STATE                                @"shipping_state"
#define     PARAM_SHIPPING_COUNTRY                              @"shipping_country"
#define     PARAM_SHIPPING_ZIPCODE                              @"shipping_zipcode"
#define     PARAM_SHIPPING_PHONE                                @"shipping_phone"
#define     PARAM_OFFER_KEY                                     @"offer_key"
#define     PARAM_USER_CREDENTIALS                              @"user_credentials"

#define     PARAM_DEVICE_TYPE                                   @"device_type"
#define     PARAM_INSTRUMENT_TYPE                               @"instrument_type"
#define     PARAM_INSTRUMENT_ID                                 @"instrument_id"
#define     INSTRUMENT_TYPE                                     @"iOS"
#define     DEVICE_TYPE_IOS                                     @"2"



#define     PARAM_PG                                            @"pg"
#define     PARAM_BANK_CODE                                     @"bankcode"

#define     PARAM_CCNUM                                         @"ccnum"
#define     PARAM_CCNAME                                        @"ccname"
#define     PARAM_CCVV                                          @"ccvv"
#define     PARAM_CC_EXP_MON                                    @"ccexpmon"
#define     PARAM_CC_EXP_YR                                     @"ccexpyr"
#define     PARAM_STORE_CARD                                    @"store_card"
#define     PARAM_STORE_CARD_NAME                               @"card_name"
#define     PARAM_BANK_CODE_CCDC                                @"CC"


#define     KEY_IBIBOCODES                                      @"ibiboCodes"
#define     KEY_USERCARDS                                       @"userCards"
#define     KEY_NETBANKING                                      @"netbanking"
#define     KEY_CASHCARD                                        @"cashcard"
#define     KEY_EMI                                             @"emi"
#define     KEY_DEBITCARD                                       @"debitcard"
#define     KEY_CREDITCARD                                      @"creditcard"
#define     KEY_PAISAWALLET                                     @"paisawallet"
//NetBanking parsing elements
#define     KEY_BANK_ID                                         @"bank_id"
#define     KEY_PGID                                            @"pgId"
#define     KEY_PT_PRIORITY                                     @"pt_priority"
#define     KEY_SHOW_FORM                                       @"show_form"
#define     KEY_TITLE                                           @"title"

//EMI parsing elements
#define     KEY_BANK                                            @"bank"

//Stored Card parsing elements
#define     KEY_USER_CARDS                                      @"user_cards"
#define     KEY_CARD_BIN                                        @"card_bin"
#define     KEY_CARD_BRAND                                      @"card_brand"
#define     KEY_CARD_CVV                                        @"card_cvv"
#define     KEY_CARD_MODE                                       @"card_mode"
#define     KEY_CARD_NAME                                       @"card_name"
#define     KEY_CARD_NO                                         @"card_no"
#define     KEY_CARD_TOKEN                                      @"card_token"
#define     KEY_CARD_TYPE                                       @"card_type"
#define     KEY_EXPIRY_MONTH                                    @"expiry_month"
#define     KEY_EXPIRY_YEAR                                     @"expiry_year"
#define     KEY_ISDOMESTIC                                      @"isDomestic"
#define     KEY_IS_EXPIRED                                      @"is_expired"
#define     KEY_ISSUINGBANK                                     @"issuingBank"
#define     KEY_NAME_ON_CARD                                    @"name_on_card"

// OfferStatus parsing elements
#define     KEY_CATEGORY                                        @"category"
#define     KEY_DISCOUNT                                        @"discount"
#define     KEY_ERROR_CODE                                      @"error_code"
#define     KEY_MSG                                             @"msg"
#define     KEY_OFFER_AVAILED_COUNT                             @"offer_availed_count"
#define     KEY_OFFER_KEY                                       @"offer_key"
#define     KEY_OFFER_REMAINING_COUNT                           @"offer_remaining_count"
#define     KEY_OFFER_TYPE                                      @"offer_type"
#define     KEY_STATUS                                          @"status"

// Payment Param for Stored Card
#define     KEY_STORE_CARD_TOKEN                                @"store_card_token"

// Payment Param for PayUMoney
#define     PARAM_BANK_CODE_PAYU_MONEY                          @"payuw"


#define     NO_NETBANKING                                       @"NetBanking is unavailable"
#define     NO_STORED_CARDS                                     @"No Stored cards available"
#define     NO_CASH_CARDS                                       @"No cash cards available"
#define     NO_EMI                                              @"No EMI available"


// Keys for VAS Parsing

#define     KEY_NETBANKINGSTATUS                                @"netBankingStatus"
#define     KEY_UP_STATUS                                       @"up_status"
#define     KEY_ISSUINGBANKDOWNBINS                             @"issuingBankDownBins"
#define     KEY_bins_arr                                        @"bins_arr"

// Available Payment Option

#define     PAYMENT_OPTION_STOREDCARD                           @"Stored Card"
#define     PAYMENT_OPTION_CCDC                                 @"Credit Card/Debit Card"
#define     PAYMENT_OPTION_NETBANKING                           @"NetBanking"
#define     PAYMENT_OPTION_CASHCARD                             @"Cash Card"
#define     PAYMENT_OPTION_EMI                                  @"EMI"
#define     PAYMENT_OPTION_PAYUMONEY                            @"PayU Money"

// Issuer Collections
#define     ISSUER_LASER                                        @"LASER"
#define     ISSUER_DISCOVER                                     @"DISCOVER"

#define     ISSUER_SMAE                                         @"SMAE"
#define     ISSUER_RUPAY                                        @"RUPAY"
#define     ISSUER_VISA                                         @"VISA"
#define     ISSUER_MAST                                         @"MAST"
#define     ISSUER_MAES                                         @"MAES"
#define     ISSUER_DINR                                         @"DINR"
#define     ISSUER_AMEX                                         @"AMEX"
#define     ISSUER_JCB                                          @"JCB"

#define     DEFAULT_CARD_NAME                                   @"PayUUser"

#ifdef DEBUG
#   define NSLog(...) NSLog(__VA_ARGS__)
#else
#   define NSLog(...)
#endif


#endif /* PayUConstants_h */
