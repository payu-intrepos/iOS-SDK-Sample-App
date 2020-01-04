#if 0
#elif defined(__arm64__) && __arm64__
// Generated by Apple Swift version 5.1.3 (swiftlang-1100.0.282.1 clang-1100.0.33.15)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="PayU_coreSDK_Swift",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift10PUExtended")
@interface PUExtended : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift7PUOffer")
@interface PUOffer : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift23PUPaymentRelatedDetails")
@interface PUPaymentRelatedDetails : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class PayUModelPaymentParams;
@class NSMutableURLRequest;
@class NSString;

SWIFT_CLASS("_TtC18PayU_coreSDK_Swift17PayUCreateRequest")
@interface PayUCreateRequest : NSObject
- (void)createRequestWithPaymentParam:(PayUModelPaymentParams * _Nonnull)paymentParam forPaymentType:(NSString * _Nonnull)paymentType withCompletionBlock:(void (^ _Nonnull)(NSMutableURLRequest * _Nonnull, NSString * _Nonnull))paramCompletionBlock;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift15PayUModelHashes")
@interface PayUModelHashes : NSObject
@property (nonatomic, copy) NSString * _Nullable paymentHash;
@property (nonatomic, copy) NSString * _Nullable paymentRelatedDetailsHash;
@property (nonatomic, copy) NSString * _Nullable VASForMobileSDKHash;
@property (nonatomic, copy) NSString * _Nullable deleteUserCardHash;
@property (nonatomic, copy) NSString * _Nullable editUserCardHash;
@property (nonatomic, copy) NSString * _Nullable saveUserCardHash;
@property (nonatomic, copy) NSString * _Nullable getUserCardHash;
@property (nonatomic, copy) NSString * _Nullable offerHash;
@property (nonatomic, copy) NSString * _Nullable checkIsDomesticHash;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift22PayUModelPaymentParams")
@interface PayUModelPaymentParams : NSObject
@property (nonatomic, copy) NSString * _Nullable key;
@property (nonatomic, copy) NSString * _Nullable amount;
@property (nonatomic, copy) NSString * _Nullable txnId;
@property (nonatomic, copy) NSString * _Nullable firstName;
@property (nonatomic, copy) NSString * _Nullable email;
@property (nonatomic, copy) NSString * _Nullable productInfo;
@property (nonatomic, copy) NSString * _Nullable surl;
@property (nonatomic, copy) NSString * _Nullable furl;
@property (nonatomic, copy) NSString * _Nullable environment;
@property (nonatomic, copy) NSString * _Nullable userCredentials;
@property (nonatomic, copy) NSString * _Nullable cardNumber;
@property (nonatomic, copy) NSString * _Nullable expiryMonth;
@property (nonatomic, copy) NSString * _Nullable expiryYear;
@property (nonatomic, copy) NSString * _Nullable CVV;
@property (nonatomic, copy) NSString * _Nullable nameOnCard;
@property (nonatomic, copy) NSString * _Nullable storeCardName;
@property (nonatomic, copy) NSString * _Nullable bankCode;
@property (nonatomic, copy) NSString * _Nullable cardBin;
@property (nonatomic, copy) NSString * _Nullable cardBrand;
@property (nonatomic, copy) NSString * _Nullable cardCVV;
@property (nonatomic, copy) NSString * _Nullable cardMode;
@property (nonatomic, copy) NSString * _Nullable cardName;
@property (nonatomic, copy) NSString * _Nullable cardNo;
@property (nonatomic, copy) NSString * _Nullable cardToken;
@property (nonatomic, copy) NSString * _Nullable cardType;
@property (nonatomic, copy) NSString * _Nullable isDomestic;
@property (nonatomic, copy) NSString * _Nullable isExpired;
@property (nonatomic, copy) NSString * _Nullable issueingBank;
@property (nonatomic) BOOL enableVerbose;
@property (nonatomic, copy) NSString * _Nullable phoneNumber;
@property (nonatomic, copy) NSString * _Nullable address1;
@property (nonatomic, copy) NSString * _Nullable address2;
@property (nonatomic, copy) NSString * _Nullable city;
@property (nonatomic, copy) NSString * _Nullable state;
@property (nonatomic, copy) NSString * _Nullable country;
@property (nonatomic, copy) NSString * _Nullable zipcode;
@property (nonatomic, copy) NSString * _Nullable udf1;
@property (nonatomic, copy) NSString * _Nullable udf2;
@property (nonatomic, copy) NSString * _Nullable udf3;
@property (nonatomic, copy) NSString * _Nullable udf4;
@property (nonatomic, copy) NSString * _Nullable udf5;
@property (nonatomic, copy) NSString * _Nullable CURL;
@property (nonatomic, copy) NSString * _Nullable CODURL;
@property (nonatomic, copy) NSString * _Nullable dropCategory;
@property (nonatomic, copy) NSString * _Nullable enforcePayMethod;
@property (nonatomic, copy) NSString * _Nullable customNote;
@property (nonatomic, copy) NSString * _Nullable noteCategory;
@property (nonatomic, copy) NSString * _Nullable apiVersion;
@property (nonatomic, copy) NSString * _Nullable shippingFirstname;
@property (nonatomic, copy) NSString * _Nullable shippingLastname;
@property (nonatomic, copy) NSString * _Nullable shippingAddress1;
@property (nonatomic, copy) NSString * _Nullable shippingAddress2;
@property (nonatomic, copy) NSString * _Nullable shippingCity;
@property (nonatomic, copy) NSString * _Nullable shippingState;
@property (nonatomic, copy) NSString * _Nullable shippingCountry;
@property (nonatomic, copy) NSString * _Nullable shippingZipcode;
@property (nonatomic, copy) NSString * _Nullable shippingPhone;
@property (nonatomic, copy) NSString * _Nullable total_subventionAmount;
@property (nonatomic, copy) NSString * _Nullable total_subventionEligibility;
@property (nonatomic) BOOL isOneTap;
@property (nonatomic) BOOL payThroughOneTap;
@property (nonatomic, copy) NSString * _Nullable enforcedCashCardParam;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nonnull OneTapTokenDictionary;
@property (nonatomic) BOOL standingInstruction;
@property (nonatomic, copy) NSString * _Nullable vpa;
@property (nonatomic, copy) NSString * _Nullable sodexo_sourceId;
@property (nonatomic, copy) NSString * _Nullable offerKey;
@property (nonatomic, strong) PayUModelHashes * _Nonnull hashes;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift14PayUWebService")
@interface PayUWebService : NSObject
- (void)fetchPayUPaymentOptionsWithPaymentParamsToFetchPaymentOptions:(PayUModelPaymentParams * _Nonnull)paymentParamsToFetchPaymentOptions completionBlockForPaymentOptions:(void (^ _Nonnull)(PUPaymentRelatedDetails * _Nonnull, NSString * _Nonnull))completionBlockForPaymentOptions;
- (void)callVASWithPaymentParamsforVas:(PayUModelPaymentParams * _Nonnull)paymentParamsforVas;
- (void)getVASStatusWithBankCodeOrCardBin:(NSString * _Nonnull)bankCodeOrCardBin completionBlockForVAS:(void (^ _Nonnull)(id _Nonnull, NSString * _Nonnull))completionBlockForVAS;
- (void)getOfferStatusWithPaymentParamsForOfferAPI:(PayUModelPaymentParams * _Nonnull)paymentParamsForOfferAPI completionBlockForOfferStatus:(void (^ _Nonnull)(PUOffer * _Nonnull, NSString * _Nonnull))completionBlockForOfferStatus;
- (void)deleteSavedCardWithPaymentParamsForDeletingSavedCard:(PayUModelPaymentParams * _Nonnull)paymentParamsForDeletingSavedCard completionBlockForDeletingSavedCard:(void (^ _Nonnull)(NSString * _Nonnull, NSString * _Nonnull))completionBlockForDeletingSavedCard;
- (void)getCardTypeDetailsWithCardBin:(PayUModelPaymentParams * _Nonnull)cardBin completionBlockForGettingCardData:(void (^ _Nonnull)(NSDictionary<NSString *, NSString *> * _Nonnull, NSString * _Nonnull))completionBlockForGettingCardData;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop

#elif defined(__ARM_ARCH_7A__) && __ARM_ARCH_7A__
// Generated by Apple Swift version 5.1.3 (swiftlang-1100.0.282.1 clang-1100.0.33.15)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgcc-compat"

#if !defined(__has_include)
# define __has_include(x) 0
#endif
#if !defined(__has_attribute)
# define __has_attribute(x) 0
#endif
#if !defined(__has_feature)
# define __has_feature(x) 0
#endif
#if !defined(__has_warning)
# define __has_warning(x) 0
#endif

#if __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <Foundation/Foundation.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus)
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
typedef unsigned int swift_uint2  __attribute__((__ext_vector_type__(2)));
typedef unsigned int swift_uint3  __attribute__((__ext_vector_type__(3)));
typedef unsigned int swift_uint4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif
#if !defined(SWIFT_CLASS_PROPERTY)
# if __has_feature(objc_class_property)
#  define SWIFT_CLASS_PROPERTY(...) __VA_ARGS__
# else
#  define SWIFT_CLASS_PROPERTY(...)
# endif
#endif

#if __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if __has_attribute(objc_method_family)
# define SWIFT_METHOD_FAMILY(X) __attribute__((objc_method_family(X)))
#else
# define SWIFT_METHOD_FAMILY(X)
#endif
#if __has_attribute(noescape)
# define SWIFT_NOESCAPE __attribute__((noescape))
#else
# define SWIFT_NOESCAPE
#endif
#if __has_attribute(warn_unused_result)
# define SWIFT_WARN_UNUSED_RESULT __attribute__((warn_unused_result))
#else
# define SWIFT_WARN_UNUSED_RESULT
#endif
#if __has_attribute(noreturn)
# define SWIFT_NORETURN __attribute__((noreturn))
#else
# define SWIFT_NORETURN
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif
#if !defined(SWIFT_RESILIENT_CLASS)
# if __has_attribute(objc_class_stub)
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME) __attribute__((objc_class_stub))
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_class_stub)) SWIFT_CLASS_NAMED(SWIFT_NAME)
# else
#  define SWIFT_RESILIENT_CLASS(SWIFT_NAME) SWIFT_CLASS(SWIFT_NAME)
#  define SWIFT_RESILIENT_CLASS_NAMED(SWIFT_NAME) SWIFT_CLASS_NAMED(SWIFT_NAME)
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM_ATTR)
# if defined(__has_attribute) && __has_attribute(enum_extensibility)
#  define SWIFT_ENUM_ATTR(_extensibility) __attribute__((enum_extensibility(_extensibility)))
# else
#  define SWIFT_ENUM_ATTR(_extensibility)
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name, _extensibility) enum _name : _type _name; enum SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# if __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_ATTR(_extensibility) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME, _extensibility) SWIFT_ENUM(_type, _name, _extensibility)
# endif
#endif
#if !defined(SWIFT_UNAVAILABLE)
# define SWIFT_UNAVAILABLE __attribute__((unavailable))
#endif
#if !defined(SWIFT_UNAVAILABLE_MSG)
# define SWIFT_UNAVAILABLE_MSG(msg) __attribute__((unavailable(msg)))
#endif
#if !defined(SWIFT_AVAILABILITY)
# define SWIFT_AVAILABILITY(plat, ...) __attribute__((availability(plat, __VA_ARGS__)))
#endif
#if !defined(SWIFT_WEAK_IMPORT)
# define SWIFT_WEAK_IMPORT __attribute__((weak_import))
#endif
#if !defined(SWIFT_DEPRECATED)
# define SWIFT_DEPRECATED __attribute__((deprecated))
#endif
#if !defined(SWIFT_DEPRECATED_MSG)
# define SWIFT_DEPRECATED_MSG(...) __attribute__((deprecated(__VA_ARGS__)))
#endif
#if __has_feature(attribute_diagnose_if_objc)
# define SWIFT_DEPRECATED_OBJC(Msg) __attribute__((diagnose_if(1, Msg, "warning")))
#else
# define SWIFT_DEPRECATED_OBJC(Msg) SWIFT_DEPRECATED_MSG(Msg)
#endif
#if !defined(IBSegueAction)
# define IBSegueAction
#endif
#if __has_feature(modules)
#if __has_warning("-Watimport-in-framework-header")
#pragma clang diagnostic ignored "-Watimport-in-framework-header"
#endif
@import ObjectiveC;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
#if __has_warning("-Wpragma-clang-attribute")
# pragma clang diagnostic ignored "-Wpragma-clang-attribute"
#endif
#pragma clang diagnostic ignored "-Wunknown-pragmas"
#pragma clang diagnostic ignored "-Wnullability"

#if __has_attribute(external_source_symbol)
# pragma push_macro("any")
# undef any
# pragma clang attribute push(__attribute__((external_source_symbol(language="Swift", defined_in="PayU_coreSDK_Swift",generated_declaration))), apply_to=any(function,enum,objc_interface,objc_category,objc_protocol))
# pragma pop_macro("any")
#endif


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift10PUExtended")
@interface PUExtended : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift7PUOffer")
@interface PUOffer : NSObject
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift23PUPaymentRelatedDetails")
@interface PUPaymentRelatedDetails : NSObject
- (nonnull instancetype)init SWIFT_UNAVAILABLE;
+ (nonnull instancetype)new SWIFT_UNAVAILABLE_MSG("-init is unavailable");
@end

@class PayUModelPaymentParams;
@class NSMutableURLRequest;
@class NSString;

SWIFT_CLASS("_TtC18PayU_coreSDK_Swift17PayUCreateRequest")
@interface PayUCreateRequest : NSObject
- (void)createRequestWithPaymentParam:(PayUModelPaymentParams * _Nonnull)paymentParam forPaymentType:(NSString * _Nonnull)paymentType withCompletionBlock:(void (^ _Nonnull)(NSMutableURLRequest * _Nonnull, NSString * _Nonnull))paramCompletionBlock;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift15PayUModelHashes")
@interface PayUModelHashes : NSObject
@property (nonatomic, copy) NSString * _Nullable paymentHash;
@property (nonatomic, copy) NSString * _Nullable paymentRelatedDetailsHash;
@property (nonatomic, copy) NSString * _Nullable VASForMobileSDKHash;
@property (nonatomic, copy) NSString * _Nullable deleteUserCardHash;
@property (nonatomic, copy) NSString * _Nullable editUserCardHash;
@property (nonatomic, copy) NSString * _Nullable saveUserCardHash;
@property (nonatomic, copy) NSString * _Nullable getUserCardHash;
@property (nonatomic, copy) NSString * _Nullable offerHash;
@property (nonatomic, copy) NSString * _Nullable checkIsDomesticHash;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift22PayUModelPaymentParams")
@interface PayUModelPaymentParams : NSObject
@property (nonatomic, copy) NSString * _Nullable key;
@property (nonatomic, copy) NSString * _Nullable amount;
@property (nonatomic, copy) NSString * _Nullable txnId;
@property (nonatomic, copy) NSString * _Nullable firstName;
@property (nonatomic, copy) NSString * _Nullable email;
@property (nonatomic, copy) NSString * _Nullable productInfo;
@property (nonatomic, copy) NSString * _Nullable surl;
@property (nonatomic, copy) NSString * _Nullable furl;
@property (nonatomic, copy) NSString * _Nullable environment;
@property (nonatomic, copy) NSString * _Nullable userCredentials;
@property (nonatomic, copy) NSString * _Nullable cardNumber;
@property (nonatomic, copy) NSString * _Nullable expiryMonth;
@property (nonatomic, copy) NSString * _Nullable expiryYear;
@property (nonatomic, copy) NSString * _Nullable CVV;
@property (nonatomic, copy) NSString * _Nullable nameOnCard;
@property (nonatomic, copy) NSString * _Nullable storeCardName;
@property (nonatomic, copy) NSString * _Nullable bankCode;
@property (nonatomic, copy) NSString * _Nullable cardBin;
@property (nonatomic, copy) NSString * _Nullable cardBrand;
@property (nonatomic, copy) NSString * _Nullable cardCVV;
@property (nonatomic, copy) NSString * _Nullable cardMode;
@property (nonatomic, copy) NSString * _Nullable cardName;
@property (nonatomic, copy) NSString * _Nullable cardNo;
@property (nonatomic, copy) NSString * _Nullable cardToken;
@property (nonatomic, copy) NSString * _Nullable cardType;
@property (nonatomic, copy) NSString * _Nullable isDomestic;
@property (nonatomic, copy) NSString * _Nullable isExpired;
@property (nonatomic, copy) NSString * _Nullable issueingBank;
@property (nonatomic) BOOL enableVerbose;
@property (nonatomic, copy) NSString * _Nullable phoneNumber;
@property (nonatomic, copy) NSString * _Nullable address1;
@property (nonatomic, copy) NSString * _Nullable address2;
@property (nonatomic, copy) NSString * _Nullable city;
@property (nonatomic, copy) NSString * _Nullable state;
@property (nonatomic, copy) NSString * _Nullable country;
@property (nonatomic, copy) NSString * _Nullable zipcode;
@property (nonatomic, copy) NSString * _Nullable udf1;
@property (nonatomic, copy) NSString * _Nullable udf2;
@property (nonatomic, copy) NSString * _Nullable udf3;
@property (nonatomic, copy) NSString * _Nullable udf4;
@property (nonatomic, copy) NSString * _Nullable udf5;
@property (nonatomic, copy) NSString * _Nullable CURL;
@property (nonatomic, copy) NSString * _Nullable CODURL;
@property (nonatomic, copy) NSString * _Nullable dropCategory;
@property (nonatomic, copy) NSString * _Nullable enforcePayMethod;
@property (nonatomic, copy) NSString * _Nullable customNote;
@property (nonatomic, copy) NSString * _Nullable noteCategory;
@property (nonatomic, copy) NSString * _Nullable apiVersion;
@property (nonatomic, copy) NSString * _Nullable shippingFirstname;
@property (nonatomic, copy) NSString * _Nullable shippingLastname;
@property (nonatomic, copy) NSString * _Nullable shippingAddress1;
@property (nonatomic, copy) NSString * _Nullable shippingAddress2;
@property (nonatomic, copy) NSString * _Nullable shippingCity;
@property (nonatomic, copy) NSString * _Nullable shippingState;
@property (nonatomic, copy) NSString * _Nullable shippingCountry;
@property (nonatomic, copy) NSString * _Nullable shippingZipcode;
@property (nonatomic, copy) NSString * _Nullable shippingPhone;
@property (nonatomic, copy) NSString * _Nullable total_subventionAmount;
@property (nonatomic, copy) NSString * _Nullable total_subventionEligibility;
@property (nonatomic) BOOL isOneTap;
@property (nonatomic) BOOL payThroughOneTap;
@property (nonatomic, copy) NSString * _Nullable enforcedCashCardParam;
@property (nonatomic, copy) NSDictionary<NSString *, NSString *> * _Nonnull OneTapTokenDictionary;
@property (nonatomic) BOOL standingInstruction;
@property (nonatomic, copy) NSString * _Nullable vpa;
@property (nonatomic, copy) NSString * _Nullable sodexo_sourceId;
@property (nonatomic, copy) NSString * _Nullable offerKey;
@property (nonatomic, strong) PayUModelHashes * _Nonnull hashes;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC18PayU_coreSDK_Swift14PayUWebService")
@interface PayUWebService : NSObject
- (void)fetchPayUPaymentOptionsWithPaymentParamsToFetchPaymentOptions:(PayUModelPaymentParams * _Nonnull)paymentParamsToFetchPaymentOptions completionBlockForPaymentOptions:(void (^ _Nonnull)(PUPaymentRelatedDetails * _Nonnull, NSString * _Nonnull))completionBlockForPaymentOptions;
- (void)callVASWithPaymentParamsforVas:(PayUModelPaymentParams * _Nonnull)paymentParamsforVas;
- (void)getVASStatusWithBankCodeOrCardBin:(NSString * _Nonnull)bankCodeOrCardBin completionBlockForVAS:(void (^ _Nonnull)(id _Nonnull, NSString * _Nonnull))completionBlockForVAS;
- (void)getOfferStatusWithPaymentParamsForOfferAPI:(PayUModelPaymentParams * _Nonnull)paymentParamsForOfferAPI completionBlockForOfferStatus:(void (^ _Nonnull)(PUOffer * _Nonnull, NSString * _Nonnull))completionBlockForOfferStatus;
- (void)deleteSavedCardWithPaymentParamsForDeletingSavedCard:(PayUModelPaymentParams * _Nonnull)paymentParamsForDeletingSavedCard completionBlockForDeletingSavedCard:(void (^ _Nonnull)(NSString * _Nonnull, NSString * _Nonnull))completionBlockForDeletingSavedCard;
- (void)getCardTypeDetailsWithCardBin:(PayUModelPaymentParams * _Nonnull)cardBin completionBlockForGettingCardData:(void (^ _Nonnull)(NSDictionary<NSString *, NSString *> * _Nonnull, NSString * _Nonnull))completionBlockForGettingCardData;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#if __has_attribute(external_source_symbol)
# pragma clang attribute pop
#endif
#pragma clang diagnostic pop

#endif