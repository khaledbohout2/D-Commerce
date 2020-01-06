//
//  Requests.swift
//  Abaya
//
//  Created by Khaled Bohout on 10/27/19.
//  Copyright © 2019 Khaled Bohout. All rights reserved.
//

import Foundation

class Requests {
    
    static let forgotPassword = "forgotPassword"
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
    static let logoutApp = "signOut"
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
    
    
    //MARK: - Registration Api's
    
    class func registrationApi(handler: @escaping ResultHandler) {
        
       // strDeviceToken = "75bfd3a611aada805536279b32771c271e57fc2e0285abf6b5d22987ad663760"
        Network.commonRequest(url: signUpApi, method: .post, parameters:registerPram as? [String : Any], headers: ["Accept": "application/json",]) { (success, jsonValue, error) in
            if success
            {
                let list = jsonValue as! [String:AnyObject]
                handler(success, list, nil)
            } else
            {
                handler(success, nil, error)
            }
        }
    }
    
    //MARK: - Login Api's
    
      class func LoginApi(handler: @escaping ResultHandler) {
          
              strDeviceToken = "75bfd3a611aada805536279b32771c271e57fc2e0285abf6b5d22987ad663760"
          Network.commonRequest(url: loginApi, method: .post, parameters:registerPram as? [String : Any], headers: ["Accept": "application/json",]) { (success, jsonValue, error) in
              if success
              {
                   let list = jsonValue as! [String:AnyObject]
                  //let JSONString = Mapper().toJSONString(user, prettyPrint: true)
                 // let list = Mapper<CountryModel>().mapDictionary(JSONObject: jsonDict ))
             
                  
                  handler(success, list, nil)
              } else
              {
                  handler(success, nil, error)
              }
          }
      }
    
    //MARK: - Forgotpassword Api's
    
    class func ForgotpasswordApi(handler: @escaping ResultHandler) {


        Network.commonRequest(url: forgotPassword, method: .post, parameters:registerPram as? [String : Any], headers: ["Content-Type": "application/json", "deviceToken": "1234343423","fcmToken": "1234455566",]) { (success, jsonValue, error) in
            if success
            {
                let list = jsonValue! as! NSDictionary


                handler(success, list, nil)
            } else
            {
                handler(success, nil, error)
            }
        }
    }
    
    //MARK: - changepassword Api's
    
    class func changepasswordApi(handler: @escaping ResultHandler) {
        
       
        Network.commonRequest(url: change_password, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
            if success
            {
                let list = jsonValue! as! NSDictionary
                
                
                handler(success, list, nil)
            } else
            {
                handler(success, nil, error)
            }
        }
    }
    
        class func proveapproveVisitorApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: PreVisitor, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }

        class func UnknownVisitorApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: UnknowVisitors, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }


    class func PerposeofVisitApi(handler: @escaping ResultHandler)
    {
        var str = String()
        str = "Bearer " + (loginAccessToken as String)
        
        registerPram = [:]
        changpasswordParam = ["Authorization": str,]
        
        
        Network.commonRequest(url: visitorTypes, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
            if success
            {
                let list = jsonValue! as! NSDictionary
                
                
                handler(success, list, nil)
            } else
            {
                handler(success, nil, error)
            }
        }
    }
        //ApiForDashboard
        class func dashboardApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: dashboardtag, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //ApiPerson
        class func personlistApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: personmeet, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //ApiComplextype
        class func complexlistApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: complelist, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //ApiAddPre
        class func preApproveAddApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: addPreApprove, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //ApiSignout
        class func SignoutApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
           
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: logoutApp, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //Approve/Reject
        class func proveapproveRejectVisitorApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
           
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: ApproveReject, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //In/Out
        class func InOutApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: inoutStatus, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //notification
        class func notificationApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: notificationparametere, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //showHide
        
        class func showHide(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: showHide, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //OTPUpdate
        
        class func OtpApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: otp, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //OTPstatus
        class func OtpStatusApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: otpstatus, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //notificationUpdateStatus
        class func notificationReadUnreadApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: notificationparametere, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
          class func addressapi(handler: @escaping ResultHandler)
        {
        var str = String()
        str = "Bearer " + (loginAccessToken as String)
        
        //registerPram = [:]
        changpasswordParam = ["Authorization": str,]
        
        
        Network.commonRequest(url: useraddress, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
        if success
        {
        let list = jsonValue! as! NSDictionary
        
        
        handler(success, list, nil)
        } else
        {
        handler(success, nil, error)
        }
        }
        }
        
        //otp
        class func sendotp(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: sendotpRequest, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //directory
        class func directoryApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: apidirectory, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //ApiMoreelse
        class func moreApi(handler: @escaping ResultHandler)
        {
        var str = String()
        str = "Bearer " + (loginAccessToken as String)
        
        registerPram = [:]
        changpasswordParam = ["Authorization": str,]
        
        
        Network.commonRequest(url: morelist, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
        if success
        {
        let list = jsonValue! as! NSDictionary
        
        
        handler(success, list, nil)
        } else
        {
        handler(success, nil, error)
        }
        }
        }
        
        //Contact
        class func contactApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: contacts, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //help
        class func helpDeskApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: getnews, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //Attendance
        class func AttendanceApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: attendance, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //In/OutAttendance
        class func InOutApiForAttendance(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: inOutAttendance, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //Events
        class func EventListApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: event, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        
        //notice
        class func NoticeListApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: notice, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
        //Complex
        class func ComplexApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            //registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: complexList, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }
       //profile
        class func myprofileApi(handler: @escaping ResultHandler)
        {
            var str = String()
            str = "Bearer " + (loginAccessToken as String)
            
            registerPram = [:]
            changpasswordParam = ["Authorization": str,]
            
            
            Network.commonRequest(url: getprofie, method: .post, parameters:registerPram as? [String : Any], headers: changpasswordParam) { (success, jsonValue, error) in
                if success
                {
                    let list = jsonValue! as! NSDictionary
                    
                    
                    handler(success, list, nil)
                } else
                {
                    handler(success, nil, error)
                }
            }
        }





}


