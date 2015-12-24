//
//  ViewController.swift
//  Baseline
//
//  Created by hersh amin on 12/4/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    //  MARK:
    //  MARK: VARIABLE DECLARATION
    //  MARK:
    
    @IBOutlet var tableView:UITableView!
    
    var tempArray:NSArray!
    
   

    //  MARK:
    //  MARK: VIEW LIFE CYCLE
    //  MARK:
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        tableView.frame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, screenWidth,screenHeight)
        
        tableView.registerNib(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "Cell")

        tempArray = NSArray (objects: "Timeline","Map","Points")
        
       // modifyDateFormat("")
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func modifyDateFormat(str:String)->NSDate
    {
        let   str1 = "23 Dec 2015 09:34:20 GMT"
        
       
        
        
        
        /***** NSDateFormatter Part *****/
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "dd-MMM-yyyy hh:mm:ss"
        return  dateFormat.dateFromString(str1)!
        
       
        
        //dateString now contains the string:
        //  "December 25, 2014 at 7:00:00 AM"
        
       /* let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "MM-dd-yyyy"
        return  dateFormat.dateFromString(str1)!*/
    }
    /*
    func modifyDateFormat(str:String)->NSDate
    {
    let str1 = "23 Dec 2015 09:34:20 GMT"
    
    
    let array = NSArray(array: str1.componentsSeparatedByString(" "))
    
    
    print(array)
    
    let morningOfChristmasComponents = NSDateComponents()
    morningOfChristmasComponents.year = array.objectAtIndex(2) as! Int
    morningOfChristmasComponents.month = array.objectAtIndex(1) as! NSString
    morningOfChristmasComponents.day = array.objectAtIndex(0) as! Int
    morningOfChristmasComponents.hour = 7
    morningOfChristmasComponents.minute = 0
    morningOfChristmasComponents.second = 0
    
    let morningOfChristmas = NSCalendar.currentCalendar().dateFromComponents(morningOfChristmasComponents)!
    
    
    
    /***** NSDateFormatter Part *****/
    
    let dateFormat = NSDateFormatter()
    dateFormat.dateFormat = "MM-dd-yyyy"
    return  dateFormat.dateFromString(str1)!
    
    let formatter = NSDateFormatter()
    formatter.dateStyle = NSDateFormatterStyle.LongStyle
    formatter.timeStyle = .MediumStyle
    
    let dateString = formatter.stringFromDate(morningOfChristmas)
    
    //dateString now contains the string:
    //  "December 25, 2014 at 7:00:00 AM"
    
    /* let dateFormat = NSDateFormatter()
    dateFormat.dateFormat = "MM-dd-yyyy"
    return  dateFormat.dateFromString(str1)!*/
    }
    

    */
    
    //  MARK:
    //  MARK: UITableView Data Source Method
    //  MARK:
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempArray.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let  cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CustomCell
        for view in cell.contentView.subviews
        {
            if (view.tag == REMOVE_TAG)
            {
                view.removeFromSuperview()
            }
        }

        let lblName = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(20,5, tableView.frame.size.width - 20, 20), backColor:CC, fontColor:BC, text:tempArray.objectAtIndex(indexPath.row) as! String, textAlign: NSTextAlignment.Left,fontSize:17)
        cell.contentView.addSubview(lblName)
       
        return cell;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        
        var objVC:UIViewController!
        
        if(indexPath.row == 0)
        {
             objVC = GiveneraTimeLine(nibName:"GiveneraTimeLine", bundle:nil)
        }
        else if(indexPath.row == 1)
        {
            objVC = GiveneraMap(nibName: "GiveneraMap", bundle: nil)
        }
        else if(indexPath.row == 2)
        {
            objVC = GiveneraPoints(nibName: "GiveneraPoints", bundle: nil)
        }
        self.navigationController?.pushViewController(objVC, animated: true)
      
    }
    

    

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

