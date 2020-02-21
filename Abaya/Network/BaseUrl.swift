
import UIKit

class BaseUrl {
    

   
//private static let baseUrl = "http://127.0.0.1:8000/api/"
   private static let baseUrl = "http://theblocksapp.com/api/"
   private static let store = "stores"
   private static let deleteAddresses = "deleteUserAddress/"
   private static let deleteCart = "deleteItemFromCart/"
    private static let deleteWish = "deleteItemFromWishlist/"
   private static let addresses = "getUserAddress"
   private static let cart = "getCart"
    private static let updateCart = "updateCart"
   private static let getCategory = "getAllCategoriesOfStore/"
   private static let newStores = "getAllNewProducts/"
    private static let recommendedProductsStr = "getRelatedProducts/"
   private static let getbanners = "getBanners"
   private static let wishlist = "getWishlist"
   private static let countrylist = "getAllCountries"
   private static let statelist = "getAllStates/"
   private static let getproductlistapi = "getAllNewProducts/"
    private static let editeProfile = "updateUserProfile"
   private static let addAddress = "saveUserAddress"
   private static let productdetail = "getProductInfo/"
   private static let addtocart = "addToCart"
    private static let saveOreder = "saveOrder"
    private static let usersOrder = "getUsersOrder"
    private static let usersActiveOrders = "getUsersOrder/active"
    private static let usersCompletedOrders = "getUsersOrder/completed"
    private static let userCards = "getUsersCreditCards"
    private static let addCard = "addCreditCard"
    private static let autoComplete = "getProductAutoComplete/"
    private static let usersOrderById = "getUsersOrderById/"
    private static let filter = "searchProducts"
    static let forgotpassword = "forgotPassword"
    static let change_password = "changePassword"
    static let signUpApi = "register"
    static let loginApi = "login"
    static let PreVisitor = "preApprovedVisitor"
    static let UnknowVisitors = "unknownVisitor"
    static let visitorTypes = "purposeOfVisitType"
    static let dashboardtag = "dashboard"
    static let personmeet = "getUsersFloorList"
    static let addPreApprove = "addPreApproveVisitor"
    static let ApproveReject = "visitorApproval"
    static let logoutApp = "logout"
    static let inoutStatus = "visitorInOut"
    static let notificationparametere = "notification"
    static let otpstatus = "checkOTPstatus"
    static let otp = "updateOTPsetting"
    static let notificatioReadStatus = "updateNotificationStatus"
    static let updateVinfo = "updateVisitorInfo"
    static let useraddress = "myAddressList"
    static let sendotpRequest = "sendOTP"
    static let apidirectory = "myDirectoryList"
    static let morelist = "roleMenuList"
    static let contacts = "contactlist"
    static let attendance = "attendanceList"
    static let getnews = "newsList"
    static let inOutAttendance = "staffInOut"
    static let event = "eventsList"
    static let notice = "noticeList"
    static let complexList = "shopList"
    static let showHide = "showHideDetail"
    static let complelist = "shopType"
    static let getprofie = "myProfile"
    static let addWishList = "addToWishlist"
    static let resetpassword = "resetPassword"
    static let cancelorder = "cancelOrder"
    
    public static func addNewCard() ->String
    {
        return baseUrl + addCard
        
    }
    
    public static func addToWishList() ->String
    {
        return baseUrl + addWishList
        
    }

    public static func addNewAddress() ->String
    {
        return baseUrl + addAddress
        
    }
    
    public static func getShopProductDetail() ->String
    {
        return baseUrl + productdetail + (strProductId as String)
        
    }
    
    
    
    public static func getProductList() ->String
    {
        print(categpryID)
        return baseUrl + getproductlistapi + categpryID
    }
    
    public static func editProfileUrl() ->String
    {
        return baseUrl + editeProfile
    }
    
    
    public static func getStateList() ->String
    {
        return baseUrl + statelist + (strCountryID as String)
        
    }
    
    public static func getCountryList() ->String
    {
        return baseUrl + countrylist
    }
    
    public static func deleteUserAddresses() ->String
    {
        return baseUrl + deleteAddresses + (strDeleteId as String)
    }
    
    public static func deleteCartApi() ->String
    {
        return baseUrl + deleteCart + (strDeleteId as String)
    }
    
    public static func deletefromWishList() ->String
    {
        return baseUrl + deleteWish + strProductId
    }
    
    public static func getCartList() ->String
    {
        return baseUrl + cart
    }
    
    public static func UpdateCartList() ->String
    {
        return baseUrl + updateCart
    }
    
    
    public static func getUserAddresses() ->String
    {
        return baseUrl + addresses
    }
    
    public static func getWishlist() ->String
    {
        return baseUrl + wishlist
    }

   public static func stores() ->String
      {
      return baseUrl + store
      }
    
   public static func category() ->String
    {
        return baseUrl + getCategory
    }
    
   public static func newStoresonBlocks() ->String
    {
        return baseUrl + newStores
    }
    
    public static func recommendedProducts() ->String
     {
         return baseUrl + recommendedProductsStr + strProductId
     }
    
    public static func logOutFromApp() ->String
     {
         return baseUrl + logoutApp
     }
    
    public static func getbannerapi() ->String
        
    {
        return baseUrl + getbanners
    }
    
    
    public static func addtocartapi() ->String
        
    {
        return baseUrl + addtocart
    }
    
    public static func saveOrder() -> String {
        
        return baseUrl + saveOreder
    }
    
    public static func getUsersOrders() -> String {
        
        return baseUrl + usersOrder
    }
    
    public static func getUsersActiveOrders() -> String {
        
        return baseUrl + usersActiveOrders
    }
    
    public static func getUsersCompletedOrders() -> String {
        
        return baseUrl + usersCompletedOrders
    }
    
    public static func getUserCards() -> String {
        
        return baseUrl + userCards
    }
    
    public static func getOrderToTrack() ->String
    {
        return baseUrl + usersOrderById + (orderToTrack as String)
        
    }
    
    public static func searchAutoComplete() -> String {
        
        return baseUrl + autoComplete + textTosearch
    }
    
    public static func filterProduct() -> String {
        
        return baseUrl + filter
    }
    
    public static func forgotPassword() -> String {
        
        return baseUrl + forgotpassword
    }
    
    public static func resetPassword() -> String {
        
        return baseUrl + resetpassword
    }
    
    public static func cancelOrder() -> String {
        
        return baseUrl + cancelorder
    }
    
    
  

    
  }
