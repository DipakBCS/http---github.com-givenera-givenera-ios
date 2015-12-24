//
//  GiveneraMapDetail.swift
//  Baseline
//
//  Created by Bharti Softech on 12/22/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

class GiveneraMapDetail: UIViewController {

    var appriationID : String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Event Detail"
        self.navigationController?.navigationBarHidden = false
        GlobalClass.sharedInstance.addBackgroundImage(self.view)
        
        let lblEventID = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(0, screenHeight/2-25, screenWidth, 50), backColor:BC, fontColor: WC, text:String(format: "Appriation Id\n%@", appriationID), textAlign:.Center, fontSize: 15)
        lblEventID.numberOfLines = 2
        self.view.addSubview(lblEventID)
        
        
        // Do any additional setup after loading the view.
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
