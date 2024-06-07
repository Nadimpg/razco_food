class ApiConstant {

  static const baseUrl = "http://146.190.130.172:5000";
 // static const baseUrl = "http://146.190.130.172:5000";


  ///<=================================== For Auth section ====================>
  static const register = "/api/v1/user/create-user";
  static const verified = "/api/v1/user/verify-email";
  static const forgotOtp = "/api/v1/auth/otp-verify";
  static const signUpResendOtp = "/api/v1/user/resend-otp";
  static const login = "/api/v1/auth/login";
  static const forgetPass = "/api/v1/auth/forget-password";
  static const resetPass = "/api/v1/auth/reset-password";


  ///<========================= profile section =============================>
  static const getProfile = "/api/v1/user/profile";
  static const profileUpdate = "/api/v1/user/profile-update";
  static const updatePassword = "/api/v1/auth/change-password";

  ///<========================= setting section =============================>
  static const feedback = "/api/v1/feedback";
  static const about = "/api/v1/rules/about";
  static const privacy = "/api/v1/rules/privacy-policy";
  static const terms = "/api/v1/rules/terms-and-conditions";
  static const faq = "/api/v1/faq";
  static const deleteAccount = "/api/v1/user/account-delete";

  ///<========================= home section =============================>
  static const banner = "/api/v1/banner";
  static const product = "/api/v1/product";
  static const subcategory = "/api/v1/subcategory";
  static const category = "/api/v1/category";
  static const categoryWise = "/api/v1/category/all-subcategories";
  static const offer = "/api/v1/offer";
  static const wishlist = "/api/v1/wishlist/products";
  static const wishlistToggle = "/api/v1/wishlist";
  static const relatedProduct = "/api/v1/product/related-product";
  static const barcode = "/api/v1/product/barcode";
  static const cartProduct = "/api/v1/cart/products";
  static const addCard = "/api/v1/cart/add-to-cart";
  static const cart = "/api/v1/cart";
  static const coupon = "/api/v1/coupon";
  static const claimCoupon = "/api/v1/coupon/claim-coupon";
  static const couponStore = "/api/v1/user/my-coupons";
  static const totalPoints = "/api/v1/user/my-points";
  static const orderHistory = "/api/v1/order/history";
  static const scanHistoryList = "/api/v1/scan-history/products";
  static const scanHistoryBarcode = "/api/v1/scan-history/barcode";
  static const editAddress = "/api/v1/user/edit-address";
  static const promoCodeApply = "/api/v1/cart/apply-promo-code";

  ///<============================= payment ====================================>
  static const paymentIntent = "/api/v1/order/create-payment-intent";
  static const order = "/api/v1/order";
  static const notifications = "/api/v1/notifications";
  static const readNotification = "/api/v1/notifications/read";
  static const callPick = "/api/v1/order/call-for-pickup";
  static const socketUrl = "http://146.190.130.172:5000";
}
