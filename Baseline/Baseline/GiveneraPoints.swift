//
//  GiveneraPoints.swift
//  Baseline
//
//  Created by Bharti Softech on 12/9/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

class GiveneraPoints: UIViewController , GiveneraManagerDelagate {

    //MARK:
    //MARK: VIEW LIFE CYCLE
    //MARK:
    
    var graphView : GraphView!
    
    var maxLabel:UILabel!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        GiveneraManager.sharedInstance.giveneraDelegate = self
        GlobalClass.sharedInstance.initiateLoaderWithMessage(Please_wait, inView: self.view)
        GiveneraManager.sharedInstance.getUserCallById("37d8310c-327a-4cfc-bf2f-a27c84c22786")
    }
    
    
    //MARK:
    //MARK: USEFUL METHODS
    //MARK:
    
    func userCallSuccess(userArray:NSArray)
    {
        dispatch_async(dispatch_get_main_queue(),  {
            GlobalClass.sharedInstance.HideLoader()

            self.initViews(userArray)
            
        });
    }
    func serverSyncFailure()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func initViews(userArray:NSArray)
    {
        var SecondYGap : CGFloat!
        var FirstYGap : CGFloat!
        var fontSize = 60
        
        
        var imageW : CGFloat!
        
        if(iPhone5 == true)
        {
            FirstYGap = 30
            SecondYGap = 120
            imageW = 90
        }
        if(iPhone6 == true)
        {
            fontSize = 50
            FirstYGap = 80
            SecondYGap = 150
            imageW = 100
        }
        if(iPhone6P == true)
        {
            fontSize = 70
            FirstYGap = 100
            SecondYGap = 180
            imageW = 120
        }
        
        GlobalClass.sharedInstance.addBackgroundImage(self.view)
        
        let btnMenu = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(10, 30, 50, 40), backCol: CC, textCol: WC, btnTitle:"", imageName: "Menu.png")
        btnMenu.addTarget(self, action: Selector("menuClicked"), forControlEvents:.TouchUpInside)
        self.view.addSubview(btnMenu)
        
        let profileImage = GlobalClass.sharedInstance.configImageView(CGRectMake(screenWidth - 80, btnMenu.frame.origin.y  + btnMenu.frame.size.height + 10, 60, 60), imageName: "profile.png", backColor: CC, contentMode:UIViewContentMode.ScaleAspectFit)
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius =  profileImage.frame.size.width / 2
        profileImage.layer.borderColor = WC.CGColor
        profileImage.layer.borderWidth = 2
        self.view.addSubview(profileImage)
        
        let firstName = userArray.objectAtIndex(0).valueForKey(first_name) as! String
        let lastName = userArray.objectAtIndex(0).valueForKey(last_name) as! String
        
        let lblProfileName = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(profileImage.frame.origin.x - 210, profileImage.frame.origin.y  + 10, 200, 26), backColor:CC, fontColor: WC, text:"\(firstName) \(lastName) ", textAlign:NSTextAlignment.Right, fontSize:22)
        self.view.addSubview(lblProfileName)
        
        let schoo = userArray.objectAtIndex(0).valueForKey(school) as! String
        
        let lblUniName = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(profileImage.frame.origin.x - 210, lblProfileName.frame.origin.y  + lblProfileName.frame.size.height, 200, 22), backColor: CC, fontColor: WC, text:schoo, textAlign:NSTextAlignment.Right, fontSize:15)
        self.view.addSubview(lblUniName)
        
        let lblMoralHead = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(btnMenu.frame.origin.x + 30 , lblUniName.frame.origin.y  + lblUniName.frame.size.height + FirstYGap, 100, 22), backColor: CC, fontColor: WC, text: "Moral Credit ", textAlign:NSTextAlignment.Center, fontSize:15)        
        
        
        let moralBackImage = GlobalClass.sharedInstance.configImageView(CGRectMake(40, lblMoralHead.frame.origin.y  + lblMoralHead.frame.size.height + 10, imageW, imageW), imageName: "", backColor: WC, contentMode:UIViewContentMode.ScaleAspectFit)
        moralBackImage.layer.cornerRadius =  moralBackImage.frame.size.width / 2
        
        
        let shadowPath = UIBezierPath(rect: moralBackImage.bounds)
        
        moralBackImage.layer.masksToBounds = true;
        moralBackImage.layer.shadowColor = BC.CGColor;
        moralBackImage.layer.shadowOffset = CGSizeZero
        moralBackImage.layer.shadowOpacity = 0.5
        moralBackImage.layer.shadowRadius = moralBackImage.frame.size.width / 2
        moralBackImage.layer.shadowPath = shadowPath.CGPath
        
        
       let  lblMoralCredit = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(0, 3, imageW, imageW), backColor: WC, fontColor: LGC, text: "79", textAlign:NSTextAlignment.Center, fontSize:fontSize)
        lblMoralCredit.layer.masksToBounds = true

        lblMoralHead.center.x = moralBackImage.center.x
        moralBackImage.addSubview(lblMoralCredit)
        self.view.addSubview(moralBackImage)
        self.view.addSubview(lblMoralHead)
        
        
       let contractImage = GlobalClass.sharedInstance.configImageView(CGRectMake(screenWidth - (40 + imageW),moralBackImage.frame.origin.y, imageW, imageW), imageName: "", backColor: WC, contentMode:UIViewContentMode.ScaleAspectFit)
        contractImage.layer.cornerRadius =  contractImage.frame.size.width / 2
        
       contractImage.layer.masksToBounds  = true
        
       self.view.addSubview(contractImage)
        
        
       let lblContractHead = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(contractImage.frame.origin.x + 10 , lblMoralHead.frame.origin.y ,100, 22), backColor: CC, fontColor: WC, text: "Contract ", textAlign:NSTextAlignment.Center, fontSize:15)
        lblContractHead.center.x = contractImage.center.x
        
       self.view.addSubview(lblContractHead)
        
       let  lblContractCredit = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(0, 0, imageW, imageW), backColor: WC, fontColor: LGC, text: "50/50", textAlign:NSTextAlignment.Center, fontSize:30)
        contractImage.addSubview(lblContractCredit)
        
        
        let lblActivity = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(screenWidth / 2 - 75 , lblContractHead.frame.origin.y + lblContractHead.frame.size.height + SecondYGap , 150, 24), backColor: CC, fontColor: WC, text: "Activity tracker", textAlign:NSTextAlignment.Center, fontSize:20)
        self.view.addSubview(lblActivity)
        
        let lblLine = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(0 , lblActivity.frame.origin.y + lblActivity.frame.size.height+5 , screenWidth, 0.5), backColor: DEFAULT_COLOR, fontColor: WC, text: "", textAlign:NSTextAlignment.Center, fontSize:10)
       
        self.view.addSubview(lblLine)
        
        let btnSetting = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(screenWidth - 60, lblActivity.frame.origin.y + lblActivity.frame.size.height, 50, 50), backCol: CC, textCol: WC, btnTitle:"", imageName: "Setting.png")
        btnSetting.addTarget(self, action: Selector("settingClicked"), forControlEvents:.TouchUpInside)
        self.view.addSubview(btnSetting)
        
       /* graphView = GraphView()
        graphView.frame = CGRectMake(0, btnSetting.frame.origin.y + btnSetting.frame.size.height, screenWidth,screenHeight - (btnSetting.frame.origin.y + btnSetting.frame.size.height))
        graphView.backgroundColor = CC
        
       /* maxLabel = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(screenWidth - 50, 10, 50, 20), backColor: RC, fontColor: WC, text: "", textAlign:.Center, fontSize: 16)
        graphView.addSubview(maxLabel)*/
        
        
        self.view.addSubview(graphView)
        
        setupGraphDisplay()*/
    }
    
    func setupGraphDisplay()
    {
       // graphView.setNeedsDisplay()
        
        
        //3 - calculate average from graphPoints
       //  let average = graphView.graphPoints.reduce(0, combine: +)
            // graphView.graphPoints.count
       // averageWaterDrunk.text = "\(average)"
        
        //set up labels
     
      /*  let calendar = NSCalendar.currentCalendar()
        let componentOptions:NSCalendarUnit = NSCalendarUnit.Month
        let components = calendar.components(componentOptions,
            fromDate: NSDate())
        let  currentMonth = components.month
        
        let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul","Aug","Sep","Oct","Nov","Dec"]
        
        var x = CGFloat(50)*/
        
        var gap = CGFloat(40)
        
        if(iPhone5)
        {
            gap = 30
        }
        else if(iPhone6)
        {
            gap = 40
        }
        else if(iPhone6P)
        {
            gap = 40
        }
    }    
    

    //MARK:
    //MARK: BUTTON CLICK EVENTS
    //MARK:
    
    func settingClicked()
    {
        //self.navigationController?.popViewControllerAnimated(true)
    }
    func menuClicked()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
