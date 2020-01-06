//
//  ViewExtension.swift
//  Abaya
//
//  Created by Kareem Mohammed on 2/9/18.
//  Copyright © 2018 Kareem Mohammed. All rights reserved.
//

import UIKit

private var kAssociationKeyMaxLength: Int = 0
extension UIView {
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
    @IBInspectable var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        
        get {
            
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            
            layer.borderColor = newValue?.cgColor
        }
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UIApplication {
    
    /// Returns the status bar UIView
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        //self.layer.borderWidth = 2
        //self.layer.borderColor = UIColor.imageborder.cgColor
        self.clipsToBounds = true
    }
    
}

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension String {
    
    static let appbaseURL = NSLocalizedString("http://theblocksapp.com/api/", comment: "")
    
    static let no_internet = NSLocalizedString("The Internet connection appears to be offline.", comment: "")
    static let signout_text = NSLocalizedString("Are sure you want to sign out?", comment: "")
    static let enter_username = NSLocalizedString("Enter first name", comment: "")
    static let enter_email = NSLocalizedString("Enter email", comment: "")
    static let enter_mobile = NSLocalizedString("Enter mobile number", comment: "")
    static let oldPassword = NSLocalizedString("Enter old password", comment: "")
    static let newPassword = NSLocalizedString("Enter new password", comment: "")
    static let enter_password = NSLocalizedString("Enter password", comment: "")
    static let confirmPassword = NSLocalizedString("Enter confirm password", comment: "")
    
    static let confirmPasswordmatch = NSLocalizedString("New password and Confirm Password should be same", comment: "")
    static let address1 = NSLocalizedString("Enter address1", comment: "")
    static let address2 = NSLocalizedString("Enter address2", comment: "")
    static let enter_postelcode = NSLocalizedString("Enter postelcode", comment: "")
    static let enter_country = NSLocalizedString("Select country", comment: "")
    static let enter_state = NSLocalizedString("Select State", comment: "")
    static let enter_city = NSLocalizedString("Enter city", comment: "")
    
    static let validEmail = NSLocalizedString("Enter a valid email", comment: "")
    static let emptyMomileNumber = NSLocalizedString("Enter mobile number", comment: "")
    static let validmobile = NSLocalizedString("nValidMobilNumber", comment: "")
    static let enter_firstname = NSLocalizedString("Enter first name", comment: "")
    static let enter_lastname = NSLocalizedString("Enter last name", comment: "")
    static let server_error = NSLocalizedString("Oops! Something went wrong!", comment: "")
    static let Unsubscrib = NSLocalizedString("You are Unsubscribe for this Facility", comment: "")
    static let imagebaseURL = NSLocalizedString("http://theblocksapp.com/", comment: "")
    
    
    
    
}
@IBDesignable class UITextViewFixed: UITextView {
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    func setup() {
        textContainerInset = UIEdgeInsets.zero
        textContainer.lineFragmentPadding = 0
    }
}
extension UITextView {
    func setBottomBorder() {
        //self.borderStyle = .none
        self.layer.backgroundColor = UIColor.white.cgColor
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        self.layer.shadowOpacity = 1.0
        self.layer.shadowRadius = 0.0
    }
}
extension UIColor {
    class var textGray: UIColor {
        return UIColor(red: 102.0 / 255.0, green: 102.0 / 255.0, blue: 102.0 / 255.0, alpha: 1.0)
    }
    class var defaultBlue: UIColor {
        return UIColor(red: 41.0 / 255.0, green: 92.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
    }
    class var defaultPurple: UIColor {
        return UIColor(red: 103.0 / 255.0, green: 58.0 / 255.0, blue: 183.0 / 255.0, alpha: 1.0)
    }
    
    class var defaultLightGray: UIColor {
        return UIColor(white: 224.0 / 255.0, alpha: 1.0)
    }
    
    class var defaultSteelGrey: UIColor {
        return UIColor(red: 121.0 / 255.0, green: 130.0 / 255.0, blue: 133.0 / 255.0, alpha: 1.0)
    }
    
    class var defaultGreyishBrown: UIColor {
        return UIColor(white: 74.0 / 255.0, alpha: 1.0)
    }
    
    class var defaultLightishGreen: UIColor {
        return UIColor(red: 76.0 / 255.0, green: 217.0 / 255.0, blue: 100.0 / 255.0, alpha: 1.0)
    }
    
    class var defaultCharcoalGrey: UIColor {
        return UIColor(red: 57.0 / 255.0, green: 57.0 / 255.0, blue: 58.0 / 255.0, alpha: 1.0)
    }
    class var defaulgreen: UIColor {
        return UIColor(red: 57.0 / 255.0, green: 181.0 / 255.0, blue: 74.0 / 255.0, alpha: 1.0)
    }
    class var defaultred: UIColor {
        return UIColor(red: 216.0 / 255.0, green: 7.0 / 255.0, blue: 7.0 / 255.0, alpha: 1.0)
    }
    
}
extension String {
    
    func fileName() -> String {
        return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent ?? ""
    }
    
    func fileExtension() -> String {
        return NSURL(fileURLWithPath: self).pathExtension ?? ""
    }
}
extension String {
    
    public func isImage() -> Bool {
        // Add here your image formats.
        let imageFormats = ["jpg", "jpeg", "png", "gif"]
        
        if let ext = self.getExtension() {
            return imageFormats.contains(ext)
        }
        
        return false
    }
    
    public func getExtension() -> String? {
        let ext = (self as NSString).pathExtension
        
        if ext.isEmpty {
            return nil
        }
        
        return ext
    }
    
    public func isURL() -> Bool {
        return URL(string: self) != nil
    }
    
}
extension UITextField {
    
    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }
    
    @objc func checkMaxLength(textField: UITextField) {
        guard let prospectiveText = self.text,
            prospectiveText.count > maxLength
            else {
                return
        }
        
        let selection = selectedTextRange
        
        let indexEndOfText = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        let substring = prospectiveText[..<indexEndOfText]
        text = String(substring)
        
        selectedTextRange = selection
    }
}
extension String
{
    var parseJSONString: AnyObject?
    {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let jsonData = data
        {
            // Will return an object or nil if JSON decoding fails
            do
            {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:.mutableContainers)
                if let jsonResult = message as? NSMutableArray {
                    return jsonResult //Will return the json array output
                } else if let jsonResult = message as? NSMutableDictionary {
                    return jsonResult //Will return the json dictionary output
                } else {
                    return nil
                }
            }
            catch let error as NSError
            {
                print("An error occurred: \(error)")
                return nil
            }
        }
        else
        {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
}
extension UITextField{
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

typealias AlertActionHandler = ((UIAlertAction) -> Void)

extension UIAlertController.Style {
    
    func controller(title: String, message: String, actions: [UIAlertAction]) -> UIAlertController {
        let _controller = UIAlertController(
            title: title,
            message: message,
            preferredStyle: self
        )
        actions.forEach { _controller.addAction($0) }
        return _controller
    }
}
extension CGRect{
    init(_ x:CGFloat,_ y:CGFloat,_ width:CGFloat,_ height:CGFloat) {
        self.init(x:x,y:y,width:width,height:height)
    }
    
}
extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        
        getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        
        return String(format:"#%06x", rgb)
    }
}
extension String {
    
    func alertAction(style: UIAlertAction.Style = .default, handler: AlertActionHandler? = nil) -> UIAlertAction {
        return UIAlertAction(title: self, style: style, handler: handler)
    }
}
struct MyVariables {
    static var selectedVisitor = ""
    static var selectedVisitorid = ""
    static var selectedpersonName = ""
    static var selectedpersonid = ""
    static var selectedComplexType = ""
    static var selectedComplexTypeid = ""
}
//Validation
extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}
extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}

extension String
{
    var isValidContact: Bool {
        let phoneNumberRegex = "^[6-9]\\d{9}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = phoneTest.evaluate(with: self)
        return isValidPhone
    }
}
extension String {
    var isValidURL: Bool {
        let detector = try! NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        if let match = detector.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.endIndex.encodedOffset)) {
            // it is a link, if the match covers the whole string
            return match.range.length == self.endIndex.encodedOffset
        } else {
            return false
        }
    }
}
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}
extension String {
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
}
extension String {
    
    public func isPhone()->Bool {
        if self.isAllDigits() == true {
            let phoneRegex = "[235689][0-9]{6}([0-9]{3})?"
            let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
            return  predicate.evaluate(with: self)
        }else {
            return false
        }
    }
    
    private func isAllDigits()->Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = self.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  self == filtered
    }
}
extension Notification.Name {
    
    static let ontableviewscroll = Notification.Name("ontableviewscroll")
    static let offtableviewscroll = Notification.Name("offtableviewscroll")
    
    
}

extension UITextField {
    
    func useUnderline() {
        
        let border = CALayer()
        let borderWidth = CGFloat(1.0)
        border.borderColor = UIColor.gray.cgColor
        // border.frame = CGRectMake(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height)
        border.frame = CGRect(0, self.frame.size.height - borderWidth, self.frame.size.width, self.frame.size.height)
        border.borderWidth = borderWidth
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
extension UIColor {
    convenience init(rgb: UInt) {
        self.init(
            red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgb & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
extension Error {
    var code: Int { return (self as NSError).code }
    var domain: String { return (self as NSError).domain }
}
@IBDesignable
class CardView: UIView {
    
    // @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: Int = 1
    @IBInspectable var shadowOffsetHeight: Int = 3
    @IBInspectable var shadowColor: UIColor? = UIColor.gray
    @IBInspectable var shadowOpacity: Float = 0.1
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        
        layer.masksToBounds = false
        // layer.shadowColor = shadowColor?.cgColor
        layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        layer.shadowOpacity = shadowOpacity
        layer.shadowPath = shadowPath.cgPath
    }
    
}
