//
//  GiveneraCompare.swift
//  Baseline
//
//  Created by Bharti Softech on 12/17/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

class GiveneraCompare: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        GlobalClass.sharedInstance.transparentNavigationBar(self.navigationController!)
        GlobalClass.sharedInstance.addBackgroundImage(self.view)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
     
        GlobalClass.sharedInstance.addCustomTabbarView(self.view, inVC: self, selectedTab:1)
// Default value for iPhone 5
        
        var bottomViewHeight = CGFloat(150)
        //var bottomViewHeight = CGFloat(130)
        var fontS = 13
        
        if(iPhone6)
        {
            bottomViewHeight = 170
            fontS = 16
        }
        else if(iPhone6P)
        {
            fontS = 17
            bottomViewHeight = 200
        }
        
        let lblTitle = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(screenWidth/2 - 110,10, 220, y), backColor: CC, fontColor: WC, text: "Houston vs Austin", textAlign:.Center,fontSize: fontS)
        self.view.addSubview(lblTitle)
        
        
        let statView = GlobalClass.sharedInstance.configView(CGRectMake(10, y + 20, screenWidth-20, screenHeight - bottomViewHeight), bColor:DEFAULT_COLOR)
       //setBorder(statView, borderWidth: 3, corberRadius:10)
        self.view.addSubview(setBorder(statView, borderWidth: 3, corberRadius:10))
       // GlobalClass.sharedInstance.shadowEffect(statView)
        self.view.addSubview(statView)

       
        let  X  = (statView.frame.size.width - (20  + 200 + CGFloat(fontS) + 4))/3 // 200 = 2 LABEL WIDTH 3 = NUMBER OF GAP
        
        
        let lblVs = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(statView.frame.size.width / 2 ,20,30,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "vs", textAlign:.Left,fontSize: fontS)
        lblVs.center.x = statView.center.x
        statView.addSubview(lblVs)

        let lblCity1 = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(lblVs.frame.origin.x - 80 - X/2 ,lblVs.frame.origin.y, 80,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "Houston", textAlign:.Center,fontSize: fontS)
        
        statView.addSubview(setBorder(lblCity1, borderWidth: 1.5, corberRadius:3))
        
        let lblCity2 = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(lblVs.frame.origin.x + lblVs.frame.size.width + X/2 - 20/2 ,lblVs.frame.origin.y, lblCity1.frame.size.width,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "Austin", textAlign:.Center,fontSize: fontS)
        
        
        statView.addSubview(setBorder(lblCity2, borderWidth: 1.5, corberRadius:3))
        
        var xGap = (statView.frame.size.width - lblCity2.frame.origin.x - lblCity2.frame.size.width - 20)/2
        
        let btnAdd = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(lblCity2.frame.origin.x + lblCity2.frame.size.width + xGap , lblCity2.frame.origin.y,20, 20), backCol:CC, textCol: BC, btnTitle:"", imageName:"edit.png")
       // btnAdd.setTitleColor(WC, forState:.Normal)
       // btnAdd.layer.cornerRadius = btnAdd.frame.size.width / 2
        
        btnAdd.addTarget(self, action: Selector("addClicked"), forControlEvents:.TouchUpInside)
        statView.addSubview(btnAdd)
        
        
        let lblBottomCity1 = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(X,statView.frame.size.height - 50, 80,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "Austin", textAlign:.Center,fontSize: fontS)
        statView.addSubview(lblBottomCity1)
        
        let City1View = GlobalClass.sharedInstance.configView(CGRectMake(lblBottomCity1.frame.origin.x + lblBottomCity1.frame.size.width  ,statView.frame.size.height - 50,40,25), bColor: CC)
       
        
        let btnGraph = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(0 ,0,City1View.frame.size.width, City1View.frame.size.height), backCol: CC, textCol: BC, btnTitle:"", imageName:"graph.png")
        
        
        City1View.addSubview(btnGraph)
        
         City1View.center.y = lblBottomCity1.center.y
        statView.addSubview(City1View)
      //  statView.addSubview(setBorder(City1View, borderWidth: 1.5, corberRadius:3))

        
        let lblBottomCity2 = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(X,lblBottomCity1.frame.origin.y - City1View.frame.size.height - 10, 80,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "Houston", textAlign:.Center,fontSize: fontS)
        statView.addSubview(lblBottomCity2)
        
        let City2View = GlobalClass.sharedInstance.configView(CGRectMake(lblBottomCity2.frame.origin.x + lblBottomCity2.frame.size.width  ,lblBottomCity2.frame.origin.y,40,25), bColor: CC)
        
        
        let btnGraph2 = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(0 ,0,City1View.frame.size.width, City1View.frame.size.height), backCol: CC, textCol: BC, btnTitle:"", imageName:"graph.png")
        
        City2View.addSubview(btnGraph2)
        City2View.center.y = lblBottomCity2.center.y
        
         statView.addSubview(City2View)
       // statView.addSubview(setBorder(City2View, borderWidth: 1.5, corberRadius:3))
        
        
        
        xGap = (statView.frame.size.width - 2*lblCity2.frame.size.width)/2
        
        let lblCenterCity1 = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(X + xGap/2 ,City2View.frame.origin.y - City2View.frame.size.height - X, 80,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "Houston", textAlign:.Center,fontSize: fontS)
        lblCenterCity1.center.x = lblCity1.center.x
        statView.addSubview(lblCenterCity1)
        

        let height = (screenHeight - statView.frame.origin.y - statView.frame.size.height)
        
        let City1VerView = GlobalClass.sharedInstance.configView(CGRectMake(lblCenterCity1.center.x,lblCenterCity1.frame.origin.y  - height*2.5-5 ,30,height*2.5), bColor:GRAPH1_COLOR)
        City1VerView.center.x = lblCity1.center.x
        statView.addSubview(City1VerView)
        
        let lblCity1Point = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(lblCenterCity1.frame.origin.x,City1VerView.frame.origin.y - (CGFloat(fontS) + 10) ,lblCenterCity1.frame.size.width ,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "4900", textAlign:.Center,fontSize: fontS - 2)
        lblCity1Point.center.x = lblCity1.center.x
        statView.addSubview(lblCity1Point)

        ///
        let lblCenterCity2 = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(statView.frame.size.width - (lblCenterCity1.frame.size.width + xGap) ,City2View.frame.origin.y - City2View.frame.size.height - X, 80,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "Austin", textAlign:.Center,fontSize: fontS)
        lblCenterCity2.center.x = lblCity2.center.x
        
        statView.addSubview(lblCenterCity2)
        
        
        let City2VerView = GlobalClass.sharedInstance.configView(CGRectMake(lblCenterCity2.center.x,lblCenterCity2.frame.origin.y  - height*2-5,30,height*2), bColor:GRAPH2_COLOR)
        City2VerView.center.x = lblCity2.center.x
        statView.addSubview(City2VerView)
        
        let lblCity2Point = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(lblCenterCity2.frame.origin.x,City2VerView.frame.origin.y - (CGFloat(fontS) + 10) , lblCenterCity2.frame.size.width,CGFloat(fontS) + 4), backColor:CC, fontColor: WC, text: "3600", textAlign:.Center,fontSize: fontS - 2)
          lblCity2Point.center.x = lblCity2.center.x
        statView.addSubview(lblCity2Point)

    }
    func setBorder(view:UIView,borderWidth width:CGFloat , corberRadius radius:CGFloat ) -> UIView
    {
        view.layer.borderColor = DEFAULT_COLOR.CGColor
        view.layer.borderWidth = width
        view.layer.cornerRadius = radius
        return view
    }
    func addClicked()
    {
    }
    func compareClicked()
    {
       // let  objVC = GiveneraCompare(nibName: "GiveneraCompare", bundle: nil)
       // self.navigationController?.pushViewController(objVC, animated: true)
    }
    
    func starClicked()
    {
    }
    func modeClicked()
    {
    }

    override func didReceiveMemoryWarning()
    {
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
