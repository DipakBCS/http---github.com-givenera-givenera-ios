//
//  GiveneraTimeLine.swift
//  Baseline
//
//  Created by Bharti Softech on 12/9/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

let size = 5

class GiveneraTimeLine: UIViewController ,GiveneraManagerDelagate ,UITableViewDataSource,UITableViewDelegate
{
    //MARK:
    //MARK: Variable Declaration
    //MARK:
    
    var tableView : UITableView!
    var eventArray = NSMutableArray()
    var start : Int = 0
    
    //  MARK:
    //  MARK: VIEW LIFE CYCLE
    //  MARK:
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.title = "Timeline"
        
        self.view.backgroundColor =  CC
        GlobalClass.sharedInstance.transparentNavigationBar(self.navigationController!)
        initTableView()
        
        reloadNextData()
    }
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
       
    }
    func reloadNextData()
    {
        GiveneraManager.sharedInstance.giveneraDelegate = self
        GlobalClass.sharedInstance.initiateLoaderWithMessage(Please_wait, inView: self.view)
        GiveneraManager.sharedInstance.getAppriations(String(format: "start=%d&size=%d",start,size))
    }
    
    //MARK:
    //MARK: OTHER USEFUL METHODS
    //MARK:
    
    func initTableView()
    {
        if (tableView == nil)
        {
             tableView = UITableView (frame: CGRectMake(0, y, screenWidth,screenHeight-y))
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = CC
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .None
        
        GlobalClass.sharedInstance.addBackgroundImage(self.view)
        tableView.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")
        
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = WC
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to Refresh")
        
        refreshControl.addTarget(self, action: "handleRefresh:", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
    
        self.view.addSubview(tableView)
    }
    
    
    func handleRefresh(refreshControl: UIRefreshControl) {
        // Do some reloading of data and update the table view's data source
        // Fetch more objects from a web service, for example...
        
        // Simply adding an object to the data source for this example
       start  += 5
        
       reloadNextData()
       refreshControl.endRefreshing()
    }
    
   
    
    func appreciationSuccess()
    {
        dispatch_async(dispatch_get_main_queue(),  {
            
            GlobalClass.sharedInstance.HideLoader()
            self.eventArray = NSMutableArray (array: GiveneraManager.sharedInstance.eventArray)
            
            //self.eventArray = GiveneraManager.sharedInstance.eventArray
            print(self.eventArray.count)
            self.tableView.reloadData()
        });
    }
    
    func serverSyncFailure()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // MARK:
    // MARK: Table View Delegate & Datasource method
    // MARK:
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat
    {
        var defaultHeight = CGFloat(80)
        
        let event =  eventArray.objectAtIndex(indexPath.row) as! GiveneraAppreciation
        
        let profileHeight = CGFloat(25) // including y gap
        
        let eventHeight = CGFloat(35) // including y gap
        
        let  textHeight = CGFloat(20) // including y gap
        
        
       /*  textHeight = GlobalClass.sharedInstance.getHeightOfText(screenWidth - 50, font:UIFont(name:FONT_Gill_Sans, size:14)! , text:event.eventDisc)
        if(textHeight <= 30)
        {
            textHeight = textHeight + 5
        }
        */
        if(event.employeeList.count >= 2)
        {
            defaultHeight = defaultHeight + profileHeight*2 + eventHeight + textHeight// Height of 2 image
        }
        else
        {
             defaultHeight = defaultHeight   + textHeight + 40 // textHeight
        }        
        return defaultHeight
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return eventArray.count
    }
    
    func drawTextInRect (rect:CGRect,label lbl:UILabel)
    {
        let insets = UIEdgeInsets (top: 0,left: 5,bottom: 0,right: 5)
        lbl.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        cell.selectionStyle = .None
        
        var fontSize = 10 // For iPhone 5
        if(iPhone6)        { fontSize = 12 }
        else if(iPhone6P)  { fontSize = 12 }
        
        for view in cell.contentView.subviews
        {
            if (view.tag == REMOVE_TAG)
            {
                view.removeFromSuperview()
            }
        }
        let event =  eventArray.objectAtIndex(indexPath.row) as! GiveneraAppreciation
        
        
        let labelDate = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(5, 10, 45, 20), backColor:CC, fontColor: WC, text:event.eventDateStr, textAlign:.Left,fontSize:fontSize)
        cell.contentView.addSubview(labelDate)
        
        let labelLine = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(labelDate.frame.origin.x + labelDate.frame.size.width-2, 0, 3,cell.contentView.frame.size.height), backColor:WC, fontColor: WC, text: "", textAlign:.Left , fontSize: fontSize)
        labelLine.alpha = 0.5
        labelLine.layer.cornerRadius = 3
        cell.contentView.addSubview(labelLine)
        
        let roundImage = GlobalClass.sharedInstance.configImageView(CGRectMake(labelLine.frame.origin.x + labelLine.frame.size.width/2-5, labelDate.frame.origin.y + 5, 10,10), imageName:"", backColor: WC, contentMode:.ScaleToFill)
        roundImage.layer.cornerRadius = roundImage.frame.size.width/2
        cell.contentView.addSubview(roundImage)
        
        let contentView = UIView(frame:CGRectMake(roundImage.frame.origin.x + roundImage.frame.size.width + 7, labelDate.frame.origin.y , screenWidth - (roundImage.frame.origin.x + roundImage.frame.size.width + 20), cell.contentView.frame.size.height - 20))
        contentView.layer.cornerRadius = 10
        contentView.backgroundColor = DEFAULT_COLOR

        contentView.tag = REMOVE_TAG
        contentView.layer.borderColor = WC.CGColor
        contentView.layer.borderWidth = 0.5
        cell.contentView.addSubview(contentView)
        
        var eventId = event.eventID
        let lblID = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(contentView.frame.size.width-70, 10, 60, 20), backColor:CC, fontColor: WC, text: eventId, textAlign:.Left , fontSize: 16)
        contentView.addSubview(lblID)
        
        let lblHelp = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(10, lblID.frame.origin.y + lblID.frame.size.height - 2, 100, 20), backColor:CC, fontColor: WC, text: "You helped :", textAlign:.Left , fontSize: 15)
        contentView.addSubview(lblHelp)
        lblHelp.alpha = 0.8
        
        if (eventId.isEmpty)
        {
            eventId = "#0000"
        }
        else
        {
            eventId = String (format: "#%@",  eventId)
        }
        lblID.alpha = 0.8
        lblID.text = eventId
        
        var x = lblHelp.frame.origin .x + lblHelp.frame.size.width+2
        var y = lblID.frame.origin.y + lblID.frame.size.height + 5
        let w = CGFloat(20)
        
        var finalStr = ""
        
        var width = contentView.frame.size.width - (32 + lblHelp.frame.origin.x + lblHelp.frame.size.width) //

        for (var j = 0; j < event.employeeList.count; j++)
        {
            //  let usrId = event.employeeList.objectAtIndex(j).valueForKey(userId) as! String
            if(event.employeeList.count == 1)
            {
                let firstNm = getFirstLastName(event.employeeList, key: firstName, index:j)
                let lastNm  = getFirstLastName(event.employeeList, key: lastName, index:j)
                
                let userImage = GlobalClass.sharedInstance.configAsyncImageView(CGRectMake(x,y,w,w), backColor: WC, contentMode: UIViewContentMode.ScaleAspectFit)
                userImage.layer.masksToBounds = true
                userImage.layer.cornerRadius = userImage.frame.size.width/2
                
                userImage.image = getProfileImage(event.employeeList, key1: profileImage, key2: image, index: j)
                
                
                let lblUserName = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(userImage.frame.origin .x + userImage.frame.size.width+2 ,y, width, 20), backColor:CC, fontColor: WC, text:String(format: "%@ %@", firstNm,lastNm), textAlign:.Left , fontSize: fontSize)
                contentView.addSubview(userImage)
                contentView.addSubview(lblUserName)
            }
            else // More than one users
            {
                x = lblHelp.frame.origin .x
                
                if (j == 0)
                {
                    if(event.employeeList.count == 3)
                    {
                        x = x + w/2
                    }
                    else
                    {
                        x = lblHelp.frame.origin .x
                    }
                    
                    y = lblHelp.frame.origin .y + lblHelp.frame.size.height + 7
                }
                else if (j == 1)
                {
                    if(event.employeeList.count%2 == 0)
                    {
                        x = x + w
                        y = lblHelp.frame.origin .y + lblHelp.frame.size.height + 7
                    }
                    else if(event.employeeList.count == 3)
                    {
                        x = lblHelp.frame.origin .x
                        y = lblHelp.frame.origin .y + lblHelp.frame.size.height + w
                    }
                    
                }
                else if (j == 2)
                {
                    if(event.employeeList.count%2 == 0)
                    {
                        x = lblHelp.frame.origin .x
                        y = lblHelp.frame.origin .y + lblHelp.frame.size.height + w
                    }
                    else if(event.employeeList.count == 3)
                    {
                        x = x + w
                        y = lblHelp.frame.origin .y + lblHelp.frame.size.height + w
                    }
                    
                }
                else if (j == 3)
                {
                    x = x + w
                    y = lblHelp.frame.origin .y + lblHelp.frame.size.height + w
                }
                
                    
               
                
                
                let userImage = GlobalClass.sharedInstance.configAsyncImageView(CGRectMake(x,y,w,w), backColor: WC, contentMode: UIViewContentMode.ScaleAspectFit)
                userImage.layer.masksToBounds = true
                userImage.layer.cornerRadius = userImage.frame.size.width/2
                userImage.image = getProfileImage(event.employeeList, key1: profileImage, key2: image, index: j)
                contentView.addSubview(userImage)
                
               
                
                let firstNm = getFirstLastName(event.employeeList, key: firstName, index:j)
                let lastNm  = getFirstLastName(event.employeeList, key: lastName, index:j)
                
                if(event.employeeList.count - 1  == j)
                {
                    finalStr = finalStr.substringToIndex(finalStr.endIndex.predecessor())
                    finalStr = String(format: "%@ and %@ %@", finalStr,firstNm,lastNm)
                    
                }
                else if(event.employeeList.count >= 4 && j == 2)
                {
                    finalStr = String(format: "%@ and %d more people", finalStr,event.employeeList.count-2)
                }
                else
                {
                    finalStr = String(format: "%@%@ %@,", finalStr,firstNm,lastNm)
                }                
                print(finalStr)
                
                if(j == event.employeeList.count - 1)
                {
                    width = contentView.frame.size.width - (2*w + lblHelp.frame.origin.x+7)
                    let lblUserName = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(2*w + lblHelp.frame.origin.x + 7,y-10, width, CGFloat(fontSize) + 4), backColor:CC, fontColor: WC, text:finalStr, textAlign:.Left , fontSize: fontSize)
                    contentView.addSubview(lblUserName)
                }
            }
            
        }
       
        var  yyy = lblHelp.frame.origin.y  + lblHelp.frame.size.height  + 10  // 10 = GAP
        if(event.employeeList.count == 2) // for 2 images
        {
            yyy = w + lblHelp.frame.size.height + lblHelp.frame.origin.y + 10
        }
        else if(event.employeeList.count > 2) // for more than 2 images
        {
            yyy = 2*w + lblHelp.frame.size.height + lblHelp.frame.origin.y + 5
        }
        
        let scrollView = UIScrollView (frame: CGRectMake(lblHelp.frame.origin.x ,yyy,contentView.frame.size.width-20 ,45))
        scrollView.contentSize = CGSizeMake(CGFloat(event.employerList.count) * 55.0,scrollView.frame.size.height)
        
        var X = CGFloat(5)
        for (var k = 0; k < event.imageArray.count; k++)
        {
            let eventImage = GlobalClass.sharedInstance.configAsyncImageView(CGRectMake(X,5,40,40), backColor: WC, contentMode: UIViewContentMode.ScaleAspectFill)
            X = X + 40.0 + 5.0
            eventImage.image = getEventImage(event.imageArray, key1: image, index: k)
                        scrollView.addSubview(eventImage)
        }
        contentView.addSubview(scrollView)
        
        
        let txtDesc = UITextView (frame: CGRectMake(lblHelp.frame.origin.x, scrollView.frame.origin.y + scrollView.frame.size.height - 5, contentView.frame.size.width-10,20))
        txtDesc.backgroundColor = CC
        txtDesc.textColor   = WC
        txtDesc.scrollEnabled = false
        
        txtDesc.showsVerticalScrollIndicator = false
        
        txtDesc.font = UIFont(name:FONT_Gill_Sans, size:14)
        txtDesc.editable = false
        if let _ = event.eventDisc
        {
            let height = GlobalClass.sharedInstance.getHeightOfText(txtDesc.frame.size.width, font:txtDesc.font! , text:event.eventDisc)
            
            if(height <= 30)
            {
               txtDesc.frame.size.height = height + 7
            }
            
            txtDesc.text = event.eventDisc
        }
    
        txtDesc.textAlignment = .Left
        contentView.addSubview(txtDesc)
    
        let lblHorLine = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(contentView.frame.origin.x+10, cell.contentView.frame.size.height - 1 , contentView.frame.size.width-20,0.5), backColor:WC, fontColor: WC, text: "", textAlign:.Left , fontSize:17)        
        cell.backgroundColor = CC
        cell.contentView.addSubview(lblHorLine)
        
       /* if (indexPath.row == self.eventArray.count - 1)
        {
            start += 5
            reloadNextData()
           
        }*/
        
        
        return cell;
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let event =  eventArray.objectAtIndex(indexPath.row) as! GiveneraAppreciation
        let objVC = EventDetailVC(nibName:"EventDetailVC", bundle:nil)
        objVC.eventID = String(format: "#%@", event.eventID)
        self.navigationController?.pushViewController(objVC, animated: true)
        
    }

    //MARK:
    //MARK: Reuseble Methods
    //MARK:
    
    func getFirstLastName(array:NSMutableArray , key:String , index:Int)-> String
    {
        var name = ""
        if let _ = array.objectAtIndex(index).valueForKey(key) as? String
        {
            name = (array.objectAtIndex(index).valueForKey(key) as? String)!
        }
        return name
    }
    
    func getProfileImage(array:NSMutableArray , key1:String , key2:String ,index:Int)-> UIImage
    {
        let img : UIImage!
        if let imageStr = array.objectAtIndex(index).valueForKey(key1)?.valueForKey(key2) as? String
        {
            img = GlobalClass.sharedInstance.getImageFromBase64(imageStr)
        }
        else
        {
            img = UIImage(named: "profile4.png")
        }
        return img
    }
    
    func getEventImage(array:NSArray , key1:String , index:Int)-> UIImage
    {
        let img : UIImage!
        if let imageStr = array.objectAtIndex(index).valueForKey(key1) as? String
        {
            img = GlobalClass.sharedInstance.getImageFromBase64(imageStr)
        }
        else
        {
            img = UIImage(named: "event.jpeg")
        }
        return img
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
