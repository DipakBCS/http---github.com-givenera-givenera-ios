//
//  EventDetailVC.swift
//  Baseline
//
//  Created by Bharti Softech on 12/11/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

class EventDetailVC: UIViewController

{
    var eventID:String!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        GlobalClass.sharedInstance.addBackgroundImage(self.view)
       

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        let lblEventID = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(screenWidth/2-50, screenHeight/2-15, 100, 30), backColor:BC, fontColor: WC, text: eventID, textAlign:.Center, fontSize: 20)
        self.view.addSubview(lblEventID)
        
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
