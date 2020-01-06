//
//  EditProfileVC.swift
//  Abaya
//
//  Created by Chandar on 17/03/19.
//  Copyright © 2019 Kareem Mohammed. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import Alamofire


class EditProfileVC: UIViewController {
    
    
    @IBOutlet var tftFirstName: UITextField!
    @IBOutlet var tftLastName: UITextField!
    @IBOutlet var tftEmail: UITextField!
    @IBOutlet var tftPhone: UITextField!
    
    @IBOutlet weak var imgProfile: UIImageView!
    private let cropper = UIImageCropper(cropRatio: 3/2)
    private let picker = UIImagePickerController()
     var isprofile = Bool()
    
    var strFirstName = NSString()
    var strLastName = NSString()
    var strEmail = NSString()
    var strMobile = NSString()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cropper.delegate = self
        cropper.cropButtonText = "Crop"
       
        setupNavButtons()
        

    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {

      
    }

    override func viewDidAppear(_ animated: Bool)
    {

                dicLoginUserData = (UserDefaults.standard.object(forKey: "dictionaryKey") as? NSDictionary)!
                dicUserProfile =  dicLoginUserData .object(forKey: "user") as! NSDictionary
                strFirstName =  dicUserProfile["first_name"] as! NSString
                strLastName =  dicUserProfile["last_name"] as! NSString
                tftFirstName.text = (strFirstName as String)
                tftLastName.text = (strLastName as String)
                tftEmail.text =  dicUserProfile["email"] as! NSString as String
                tftPhone.text =  dicUserProfile["mobile"] as! NSString as String
        
    }
    
//    func submitUpdateProfile() {
//        var strApiname = String()
//        strApiname = "updateUserProfile"
//
//
//        let myUrl =  .appbaseURL + strApiname;
//        hud.textLabel.text = "Loading"
//        hud.show(in: self.view)
//        let strFirstName:String = tftFirstName.text!
//        let strLastName:String = tftLastName.text!
//        let strEmail:String = tftEmail.text!
//        let strPhone:String = tftPhone.text!
//
//
//        var str = String()
//        str =  (loginAccessToken as String)
//
//
//
//        DicParameters = ["Authorization": str, "Accept":"application/json", "Content-Type":"application/x-www-form-urlencoded", "Fcm-Token":strDeviceToken, "Device-Type": "iOS","Device-Token":strDeviceid]
//
//
//        let  parameters = ["first_name":strFirstName, "last_name":strLastName, "email":strEmail, "mobile":strPhone]
//
//
//        AF.upload(multipartFormData:{ multipartFormData in
//            if self.imgProfile.image == nil
//            {
//
//            }
//            else{
//                multipartFormData.append(UIImageJPEGRepresentation(self.imgProfile.image!, 0.5)!, withName: "profile_image", fileName: "user.jpeg", mimeType: "image/jpeg")
//            }
//
//            for (key, value) in parameters {
//                multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
//            }
//        },  usingThreshold:UInt64.init(),
//            to:myUrl,
//            method:.post,
//            headers:DicParameters,
//            encodingCompletion: { encodingResult in
//                switch encodingResult {
//                case .success(let upload, _, _):
//                    upload.responseJSON { response in
//                        debugPrint(response)
//
//                       hud.dismiss()
//                        let alert = UIAlertController(title: "", message: "Profile updated successfully.", preferredStyle: .alert)
//
//                        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
//
//                            self.navigationController?.popViewController(animated:true)
//
//                        }))
//
//
//
//                        self.present(alert, animated: true)
//
//                    }
//                case .failure(let encodingError):
//                    //print(encodingError)
//                    hud.dismiss()
//                    Alert.Show(title:"", mesage:encodingError as! String, viewcontroller:self)
//                }
//        })
//
//    }
    
    func editProfile() {
        
                let strFirstName:String = tftFirstName.text!
                let strLastName:String = tftLastName.text!
                let strEmail:String = tftEmail.text!
                let strPhone:String = tftPhone.text!
        
        DicParameters = ["first_name":strFirstName, "last_name":strLastName, "email":strEmail, "mobile": strPhone]
        
        hud.textLabel.text = "Loading"
        
        hud.show(in: self.view)
        
        ApiBaseClass.apiCallingWithPutMethode(url:ApiBaseClass.editProfileUrl(), completion: { [weak self] response in
            
                            let errorCheck = response["success"] as! Bool
                
                            if errorCheck
                              
                            {
                                print("khaled success editing profile \(response)")
                                
                              hud.dismiss()
                                let obj = self!.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileVC
                                self?.navigationController?.pushViewController(obj, animated: true)

                            }
                                
                            else
                                
                            {
                                hud.dismiss()
                                     Alert.Show(title:NSLocalizedString("something wrong", comment: ""), mesage: NSLocalizedString("Please try again.", comment: ""), viewcontroller:self!)
                                      
                                  }
                                  }, failure: { [weak self] failResponse in
                                      hud.dismiss()
                                      Alert.Show(title: NSLocalizedString("network error", comment: ""), mesage:NSLocalizedString("Please try again.", comment: "") , viewcontroller:self!)
                        })
    }
    
    @IBAction func btnUploadImage(_ sender: Any) {
        //isprofile = false
        cropper.picker = picker
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        cropper.cancelButtonText = "Retake"
        
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Camera", comment: ""), style: .default) { _ in
            self.picker.sourceType = .camera
            self.present(self.picker, animated: true, completion: nil)
        })
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Gallery", comment: ""), style: .default) { _ in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
        })
        alertController.addAction(UIAlertAction(title: NSLocalizedString("Cancel", comment: ""), style: .cancel, handler: { _ in
        }))
        self.present(alertController, animated: true, completion: nil)
    }
}
// MARK:- Navigation
extension EditProfileVC {
    
    func setupNavButtons() {
        
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.lightGray
        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.title = "Edit Profile"
        
        let backButton = UIBarButtonItem(image: #imageLiteral(resourceName: "backIcon"), style: .plain, target: self, action: #selector(backAction))
        navigationItem.leftBarButtonItem = backButton
        let btnSave = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = btnSave
        navigationController?.navigationBar.setNeedsLayout()
    }
    
    @objc func backAction()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func saveAction()
    {
      editProfile()
    }
}


extension EditProfileVC: UIImageCropperProtocol {
    func didCropImage(originalImage: UIImage?, croppedImage: UIImage?)
    {
//        if isprofile {
            self.imgProfile.image = croppedImage
            imgProfile.roundedImage()
//        }
//        else{
//        }
    }
    
    //optional
    func didCancel() {
        //ispic = true
        picker.dismiss(animated: true, completion: nil)
        //print("did cancel")
    }
    
    
}
