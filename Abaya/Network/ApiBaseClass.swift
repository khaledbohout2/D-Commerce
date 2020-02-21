


import UIKit
import Alamofire
//import GoogleMaps
//import GooglePlaces

class ApiBaseClass: BaseUrl {

    typealias FailureCase = (_ errorValue:Any) -> Void
    typealias response = (_ response:[String:AnyObject]) ->Void
    typealias responseDelete = (_ response: Int) -> Void

    
    static func apiCallingMethode(url:String,parameter:[String:String],completion: @escaping response,failure:@escaping FailureCase)
        
{
    
    var str = String()
    str = "Bearer " + (loginAccessToken as String)
    Authorization = ["Authorization": str, "Accept":"application/json","Content-Language" : NSLocalizedString("lang", comment: "")]
    
    AF.request(url, method: .post, parameters:parameter, headers:Authorization ).responseJSON{ (response)
        in
        print("url is \(url)")
        
        print("parameter is \(parameter)")
        
        print(response.result)
          
            switch response.result {
              
            case .success(let json):
                
                if let dict = json as? [String: AnyObject] {
                    
                 completion(dict)
                    
                print(dict)
                }

            case .failure(let error): 

                print(error)
            }

        }
 }
        static func apiCallingMethodeca(url:String,parameter:[String:Any],completion: @escaping response,failure:@escaping FailureCase)
            
    {
        
        var str = String()
        str = "Bearer " + (loginAccessToken as String)
        Authorization = ["Authorization": str, "Accept":"application/json","Content-Language" : NSLocalizedString("lang", comment: "")]
        
        AF.request(url, method: .post, parameters:parameter, headers:Authorization ).responseJSON{ (response)
            in
            print("url is \(url)")
            
            print("parameter is \(parameter)")
            
            print(response.result)
              
                switch response.result {
                  
                case .success(let json):
                    
                    if let dict = json as? [String: AnyObject] {
                        
                     completion(dict)
                        
                    print(dict)
                    }

                case .failure(let error):

                    print(error)
                }

            }
     }

static func apiCallingWithGetMethode(url:String,completion: @escaping response,failure:@escaping FailureCase)
{

    var str = String()
    str = "Bearer " + (loginAccessToken as String)
   // print(str)
    Authorization = ["Authorization": str, "Accept":"application/json","Content-Language" : NSLocalizedString("lang", comment: "")]
    
    
    
    AF.request(url, method: .get, parameters:DicParameters, headers:Authorization ).responseJSON{ (response)
        in
          
            print(url)
        print(DicParameters)
        
            switch response.result {
                
              
            case .success(let json):

                
                if let dict = json as? [String: AnyObject] {
                    
                 completion(dict)
                    
               //  print(dict)
                }

            case .failure(let error):

                print(error)
            }

        }
}
    
    static func apiCallingWithGetProMethode(url:String,completion: @escaping response,failure:@escaping FailureCase)
    {

        var str = String()
        str = "Bearer " + (loginAccessToken as String)
       // print(str)
        Authorization = ["Authorization": str, "Accept":"application/json", "Content-Language" : NSLocalizedString("lang", comment: "") ]
        
        
        
        AF.request(url, method: .get, parameters:DicParameters, headers:Authorization ).responseJSON{ (response)
            in
              
                print(url)
            print(DicParameters)
            
                switch response.result {
                    
                  
                case .success(let json):

                    
                    if let dict = json as? [String: AnyObject] {
                        
                     completion(dict)
                        
                   //  print(dict)
                    }

                case .failure(let error):

                    print(error)
                }

            }
    }

    
 
    static func apiCallingWithGetMethodeWithoutParameter(url:String,completion: @escaping response,failure:@escaping FailureCase)
    {
        AF.request(url, method: .get).responseJSON { (response)
        in
          
            switch response.result {
              
            case .success(let json):
                
                let dict = json as? [String: Any]
                
                print(dict!)

            case .failure(let error):

                print(error)
            }

        }

    }
    
    static func apiCallingWithDeleteMethode(url:String,completion: @escaping responseDelete,failure:@escaping FailureCase)
    {
        var str = String()
        str = "Bearer " + (loginAccessToken as String)
        Authorization = ["Authorization": str, "Accept":"application/json","Content-Language" : NSLocalizedString("lang", comment: "")]
        
        
        
        AF.request(url, method: .delete, headers:Authorization).responseJSON{ (response)
            in
              
                print(url)
                switch response.result {
                    
                  
                case .success(let json):

                    
                    if let dict = json as? Int {
                        //print(dict)
                        
                     completion(dict)
                        
                     print(dict)
                    }

                case .failure(let error):

                    print(error)
                }

            }
    }
    
    static func apiCallingWithPutMethode(url:String,completion: @escaping response,failure:@escaping FailureCase)
    {

        var str = String()
        str = "Bearer " + (loginAccessToken as String)
       // print(str)
        Authorization = ["Authorization": str, "Accept":"application/json","Content-Language" : NSLocalizedString("lang", comment: "")]
        
        
        
        AF.request(url, method: .put, parameters:DicParameters, headers:Authorization ).responseJSON{ (response)
            in
              
                print(url)
               print(DicParameters)
            
                switch response.result {
                    
                  
                case .success(let json):

                    
                    if let dict = json as? [String: AnyObject] {
                        
                     completion(dict)
                        
                   //  print(dict)
                    }

                case .failure(let error):

                    print(error)
                }

            }
    }
    
    
    func translate(params:String, callback:@escaping (_ translatedText:String) -> ())
      {
    
        
      }
    
}
