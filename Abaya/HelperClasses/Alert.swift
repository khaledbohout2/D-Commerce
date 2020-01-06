

import UIKit

class Alert: NSObject {

class func Show(title:String,mesage:String,viewcontroller:UIViewController)  {
        let alert = UIAlertController.init(title: title, message: mesage, preferredStyle: .alert)
        let defaultaction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultaction)
        viewcontroller.present(alert, animated: true, completion: nil)
        
    }
    
    class func ShowAction(title:String,mesage:String,viewcontroller:UIViewController)  {
        let alert = UIAlertController.init(title: title, message: mesage, preferredStyle: .actionSheet)
        let defaultaction = UIAlertAction.init(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultaction)
        viewcontroller.present(alert, animated: true, completion: nil)
        
    }
    
    class func dropShadowWithCornor(color: UIColor, opacity: Float , offSet: CGSize, shadowRadius: Float, view:UIView)
    {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offSet
        view.layer.shadowRadius = CGFloat(shadowRadius)
        //view.layer.cornerRadius   = CGFloat(cornorRadius)
    }
    class func dropShadowWithCornorTable(color: UIColor, opacity: Float , offSet: CGSize, shadowRadius: Float, view:UITableView)
    {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowOffset = offSet
        view.layer.shadowRadius = CGFloat(shadowRadius)
        //view.layer.cornerRadius   = CGFloat(cornorRadius)
    }

}
