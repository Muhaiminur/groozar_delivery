class ApiUrl {
  static String baseUrl = "https://inventory.grozaarbd.com/api/v1/";

  //static String baseUrl = "https://grozaar.heizoelscout.com/api/v1/";
  static const String homepageUrl = "user/get-homepage?is_home_page=1";
  static const String categoryUrl = "user/get-categories?page=1&par_page=20";
  static const String categoryProductUrl = "user/get-products";
  static const String productDetailsUrl = "user/get-product-details/";
  static const String signUpUrl = "register";
  static const String signInUrl = "login";
  static const String userDetailsUrl = "delivery-man/get-profile-details";
  static const String userUpdateUrl = "user/update-profile";
  static const String cartAddUrl = "user/cart/plus";
  static const String cartDeductUrl = "user/cart/minus";
  static const String cartUrl = "user/cart";
  static const String cartDeleteUrl = "/remove";
  static const String checkOutUrl = "user/checkout-confirm";
  static const String ongoingOrderUrl = "user/ongoing-orders";
  static const String completeOrderUrl = "user/completed-orders";
  static const String orderReceiveUrl = "/status-change";

  static const String notificationUrl = "delivery-man/get-notifications";
  static const String acceptedOrderUrl = "delivery-man/get-current-orders";
  static const String completeOrderListUrl = "delivery-man/get-previous-orders";
  static const String currentOrderListUrl = "delivery-man/get-order-request";
  static const String orderUpdateUrl = "delivery-man/order/";

}
