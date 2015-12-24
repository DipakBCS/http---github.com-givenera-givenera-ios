//
//  GlobalClass.swift
//  MyRiskScoutSolution
//
//  Created by Bharti Soft Tech Pvt Ltd on 25/09/15.
//  Copyright © 2015 Bharti Soft Tech Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreLocation
import CoreData


protocol GlobalClassDelegate
{
    func dataSaved()
}

class GlobalClass: NSObject, UIAlertViewDelegate, UITextFieldDelegate
{
    
    static let sharedInstance = GlobalClass()
    
    var viewController = UIViewController()
    
    var globalDelegate:GlobalClassDelegate?
    
    var viewLoader: UIView?
    
    var errorView:UIView!
    
     override init()
     {
        super.init()
    
     }
    
    //For checking Internet
    
    func checkInternet() -> ObjCBool
    {
        if Reachability.isConnectedToNetwork() == true
        {
            return true
        }
        else
        {
            print(INTERNET_NOT_AVAILABLE)
            return false
        }
    }
    
    //For String Validation
    func checkNullString(str:String!)->String
    {
        if let str1 = str
        {
            switch str1
            {
            case "<null>","(null)","","0"," ":
                return ""
                
            case (_) where str1.isEmpty:
                return ""
                
            default:
                return str1
            }
        }
        return "";
    }
    
    //For Checking device is Ipad or not
    func isIpad() -> ObjCBool {
        
        if (UIDevice.currentDevice().userInterfaceIdiom == UIUserInterfaceIdiom.Pad)
        {
            return true;
        }
            return false;
    }
    
    
    //General Alert Method
    func alert(title:String, message:String)
    {
        let alert = UIAlertView(title: title, message: message, delegate: nil, cancelButtonTitle: "OK") // EXC_BAD_ACCESS here
        
        alert.show()
       
    }
    
    
    //For Checking System version
    func isLatestVersion() -> ObjCBool{
        
        switch UIDevice.currentDevice().systemVersion.compare("8.0.0", options: NSStringCompareOptions.NumericSearch) {
            
        case .OrderedSame, .OrderedDescending:
            
            print("iOS >= 8.0")
            
            return true
            
        case .OrderedAscending:
            
            print("iOS < 8.0")
            
            return false
        }
    }
    
    
    
    //MARK:
    //MARK:Configuration Method
    //MARK:
    
    func configButton(type:Int, frame:CGRect, backCol:UIColor, textCol:UIColor, btnTitle:String, imageName:String) -> UIButton
    {
        var btn = UIButton()
        
        if(type == 1) //System
        {
           btn = UIButton(type: UIButtonType.System)
        }
        else if(type == 2) //Custom
        {
           btn = UIButton(type: UIButtonType.Custom)
            
           btn.setBackgroundImage(UIImage(named: imageName), forState: .Normal)
           
        }
        
        btn.backgroundColor = backCol
        
        btn.setTitleColor(textCol, forState: .Normal)
        
        btn.frame = frame
        
        btn.setTitle(btnTitle, forState: .Normal)
        
       // inView.addSubview(btn)
        
        return btn
    }
    
    func configTextField(frame:CGRect, backCol:UIColor, textCol:UIColor,placeHolderText:String, placeHolderTextColor:UIColor, font:UIFont ,isBorder:Bool , txtTag:Int) -> UITextField
    {
        var textField = UITextField()
        
        textField.frame = frame
        
        textField.tag = txtTag
       
        textField.font = font
        
        textField.textColor = textCol
        
        if(isBorder)
        {
            textField = boredrInTextfield(textField: textField)
        }
        
        
        textField.attributedPlaceholder = NSAttributedString(string:placeHolderText,
                
        attributes:[NSForegroundColorAttributeName: placeHolderTextColor])
     
        return textField
        
       
    }
    
    func boredrInTextfield(textField txtFeild:UITextField)->UITextField
    {
        let  bottomLine = CALayer()
        bottomLine.frame = CGRectMake(0.0, txtFeild.frame.height - 1, txtFeild.frame.width, 1.0)
        bottomLine.backgroundColor = UIColor.blackColor().CGColor
        txtFeild.borderStyle = UITextBorderStyle.None
        txtFeild.layer.addSublayer(bottomLine)
        return txtFeild;
    }
    
    
    func configLabelFrame(frame:CGRect, backColor:UIColor, fontColor:UIColor, var text:String, textAlign:NSTextAlignment,fontSize:Int) -> UILabel
    {
        text = checkNullString(text)
        
        let lbl = UILabel()
        
        lbl.frame = frame
        
        lbl.tag  = REMOVE_TAG
        
        lbl.backgroundColor = backColor
        
        lbl.textColor = fontColor
        
        lbl.textAlignment = textAlign
        
        lbl.text = text
        
        lbl.font = UIFont(name:Avenir , size:CGFloat(fontSize))
        
        return lbl
       
    }
    
    func shadowEffect(view:UIView)->UIView
    {
        let shadowPath = UIBezierPath(rect: view.bounds)
        
        view.layer.masksToBounds = false;
        view.layer.shadowColor = BC.CGColor;
        view.layer.shadowOffset = CGSizeMake(1, 1)
       // view.layer.sha
        view.layer.shadowOpacity = 0.5
        view.layer.shadowPath = shadowPath.CGPath
        return view
        
    }
    
    func configView(frame:CGRect, bColor:UIColor) -> UIView
    {
        let view = UIView()
        
        view.frame = frame
        
        view.backgroundColor = bColor
        
        return view
        
    }
    
    
    
    func configImageView(frame:CGRect, imageName:String, backColor:UIColor, contentMode:UIViewContentMode) -> UIImageView
    {
        let imageView = UIImageView()
        
        imageView.frame = frame
        
        imageView.backgroundColor = backColor
        
        imageView.contentMode = contentMode
        
        imageView.image = UIImage(named: imageName)
        
        return imageView
    }
    
    func configAsyncImageView(frame:CGRect, backColor:UIColor, contentMode:UIViewContentMode) ->
        AsyncImageView
    {
        let imageView = AsyncImageView()
        
        imageView.tag = REMOVE_TAG
        
        imageView.frame = frame
        
        imageView.backgroundColor = backColor
        
        imageView.contentMode = contentMode
        
        return imageView
    }

    
    
    //location Method
    

    func locationPermission(){
        
        var alertText = String()
       
        let status = CLLocationManager.authorizationStatus()
        
        if(status == CLAuthorizationStatus.Denied){
            
            switch(CLLocationManager.authorizationStatus()){
                
            case CLAuthorizationStatus.Authorized:
                
                print("Location Service Authorised")
                
            case CLAuthorizationStatus.Denied:
                
                alertText = "App level settings has been denied.To re-enable, Please go to Settings and turn on Location Service for this app."
                
            case CLAuthorizationStatus.NotDetermined:
                
                alertText = "The user is yet to provide the permission.To enable, Please go to Settings and turn on Location Service for this app."
            
            case CLAuthorizationStatus.Restricted:
                
                alertText = "The app is recstricted from using location services.To re-enable, Please go to Settings and turn on Location Service for this app."
                
            default:
                break
               
            }
            
        }
        
        let alert = UIAlertView(title: "ERROR", message: alertText, delegate: self, cancelButtonTitle: "OK")
        
       // alert.tag = LOCATION_TAG
        
        alert.show()
       
    }
    
    func initiateLoaderWithMessage(var str:String, inView:UIView)
    {
        
        self.viewLoader = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        
        self.viewLoader!.hidden = false
        
        let imgBg = UIImageView(frame: self.viewLoader!.frame)
        
        imgBg.alpha = 0.5
        
        imgBg.backgroundColor = UIColor.blackColor()
        
        self.viewLoader!.addSubview(imgBg)
        
        let imgLoadingBG = UIImageView(frame: CGRectMake(self.viewLoader!.frame.width/2, self.viewLoader!.frame.height/2, 100, 100))
        
        imgLoadingBG.center = self.viewLoader!.center
        
        imgLoadingBG.alpha = 0.8
        
        imgLoadingBG.layer.cornerRadius = 10
        
        imgLoadingBG.backgroundColor = UIColor.blackColor()
        
        self.viewLoader!.addSubview(imgLoadingBG)
        
        let activityLoader = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
        
        activityLoader.frame = CGRectMake(imgLoadingBG.frame.width/2, imgLoadingBG.frame.height/2, 50, 50)
        
        activityLoader.center = self.viewLoader!.center
        
        self.viewLoader!.addSubview(activityLoader)
        
        
        let lblMsg = configLabelFrame(CGRectMake(self.viewLoader!.frame.width/2 - 50, self.viewLoader!.frame.height/2 - 25, 100, 50), backColor: UIColor.redColor(), fontColor: UIColor.whiteColor(), text: str, textAlign: NSTextAlignment.Center , fontSize: 17)
        
        
        lblMsg.numberOfLines = 2
        
        lblMsg.center = self.viewLoader!.center
        
        
        str = str.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        str = checkNullString(str)
        
        if(str.isEmpty){
            
            str = "Please Wait"
        }
        
        lblMsg.text = str
        
        activityLoader.startAnimating()
        
        inView.addSubview(self.viewLoader!)
    }

    
    func HideLoader()
    {
        if (self.viewLoader != nil)
        {
           self.viewLoader!.removeFromSuperview()
            
        }
    }
    
    
    //Email Validation
    func isValidEmail(testStr:String) -> Bool {
        
        print("validate emilId: \(testStr)")
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        let result = emailTest.evaluateWithObject(testStr)
        
        return result
        
    }
    
    func getWidthOfText(height: CGFloat, font: UIFont,text:String) -> CGFloat
    {
        let constraintRect = CGSize(width:CGFloat.max , height:height)
        
        let boundingBox = text.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.width
        
    }
    
    func getHeightOfText(width: CGFloat, font: UIFont,text:String) -> CGFloat
    {
        let constraintRect = CGSize(width:width , height: CGFloat.max)
        
        let boundingBox = text.boundingRectWithSize(constraintRect, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.height
        
    }
    
    
    //Error View Related Methods
    
    
    func displayAlert(title:String , alertMsg:String)
    {
        let alert = UIAlertView(title: title, message: alertMsg, delegate: self, cancelButtonTitle: "OK")
        
        alert.show()
    }
    
    func getDevices()
    {
        if(screenHeight == 568)
        {
            iPhone5 = true
        }
        else if(screenHeight == 667)
        {
             iPhone6 = true
        }
        else if(screenHeight == 736)
        {
            iPhone6P = true
        }

    }
    
    func transparentNavigationBar(navigationController:UINavigationController)
    {
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: WC]
        navigationController.navigationBarHidden = false
        navigationController.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        navigationController.navigationBar.tintColor = WC;
        navigationController.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationController.navigationBar.shadowImage = UIImage()
        navigationController.navigationBar.translucent = true
    }
    func addBackgroundImage(inView:UIView)
    {
        //inView.backgroundColor =  CC
        let backImage   =   UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        backImage.image = UIImage(named:background_image)
        backImage.contentMode = .ScaleAspectFit
        inView.addSubview(backImage)
    }
    
    func addCustomTabbarView(inView:UIView ,inVC viewController:UIViewController , selectedTab tab:Int)
    {
        
        var bottomViewY = CGFloat(20)
        
        
        if(iPhone6)
        {
            bottomViewY = CGFloat(30)
        }
            
        else if(iPhone6P)
        {
            bottomViewY = 40
        }
        
     
        let lblCompare = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(50, screenHeight - bottomViewY, 70, 14), backColor: CC, fontColor: WC, text: "Compare", textAlign:.Center,fontSize: 12)
        
        let btnCompare = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(lblCompare.frame.origin.x, lblCompare.frame.origin.y - 35, 30, 30), backCol: CC, textCol: WC, btnTitle:"", imageName: COMPARE)
        btnCompare.addTarget(viewController, action: Selector("compareClicked"), forControlEvents:.TouchUpInside)
        
        let lblStar = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(screenWidth - (lblCompare.frame.origin.x + lblCompare.frame.size.width), lblCompare.frame.origin.y, lblCompare.frame.size.width, lblCompare.frame.size.height), backColor: CC, fontColor: WC, text: "Lucky Star", textAlign:.Center,fontSize: 12)
        
        let btnStar = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(lblStar.frame.origin.x, btnCompare.frame.origin.y, btnCompare.frame.size.width, btnCompare.frame.size.height), backCol: CC, textCol: WC, btnTitle:"", imageName: LUCKY_STAR)
        btnStar.addTarget(viewController, action: Selector("starClicked"), forControlEvents:.TouchUpInside)
        
        btnCompare.center.x = lblCompare.center.x
        btnStar.center.x = lblStar.center.x

        if(tab == 1) // Compare Selected
        {
             btnCompare.setBackgroundImage(UIImage(named:COMPARE_SELECTED), forState: .Normal)
        }
        else if(tab == 2) // Lucky Star Selected
        {
            btnStar.setBackgroundImage(UIImage(named:LUCKY_STAR_SELECTED), forState: .Normal)
        }
        inView.addSubview(lblCompare)
        inView.addSubview(btnCompare)
        inView.addSubview(lblStar)
        inView.addSubview(btnStar)
    }
    func UIColorFromRGB(rgbValue: UInt) -> UIColor
    {
        return UIColor(
            red:   CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue:  CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    func checkKeyInDictionary(dic:NSDictionary, key:String) -> String
    {
        var  value = String()
        if let val = dic[key]
        {
            value = val as! String
        }
        else {
            print("value is nil")
        }
        
        /*            else {
        print("key is not present in dict")
        }*/
        return value
    }
    
    func getImageFromBase64(base64String:String)->UIImage
    {

        let imageData = NSData (base64EncodedString: base64String, options: .IgnoreUnknownCharacters)
        let image = UIImage(data: imageData!)            
        return image!
    }
    func getValidString(var str:String)->String
    {
        
        if let _ = str as? String 
        {
           // str = imageStr
        }
        else
        {
            str = ""
        }
        return str
        
    }
        

}





