//
//  GiveneraManager.swift
//  Baseline
//
//  Created by Bharti Softech on 12/10/15.
//  Copyright © 2015 Givenera. All rights reserved.
//

import UIKit

@objc
protocol GiveneraManagerDelagate
{
    optional func appreciationSuccess()
    optional func userCallSuccess(userArray:NSArray)
    optional func eventCallSuccess(eventArray:NSArray)
    optional func appreciationFailure(message:String)
    optional func serverSyncFailure()
}

class GiveneraManager: NSObject, NSURLConnectionDataDelegate, NSURLSessionTaskDelegate
{
    
     static let sharedInstance = GiveneraManager()
    
     var giveneraDelegate: GiveneraManagerDelagate?
    
     var eventArray:NSMutableArray!
    
    
     var participantArray:NSArray!
    
     var userArray:NSArray!
    
     var commentArray:NSArray!
    
    //MARK: 
    //MARK: API CALL METHOD
    //MARK:
    
    
    func getAppriations(sizeStr:String)
    {
        callAPI(String(format:"%@%@?%@",baseURL,appreciation,sizeStr), APIno: APPRECIATION_TAG)
   
    }
   
    func getUserCallById(userID:String)
    {
        callAPI(String(format:"%@:%@/%@/%@",backendHost,backendPort,user,userID), APIno: USER_BY_ID_TAG)
    }
    func getCommentCall()
    {
        callAPI(String(format:"%@:%@/%@",backendHost,backendPort,comment), APIno: COMMENT_TAG)
    }
    
    func getCommentCallByUserID(userID:String)
    {
        callAPI(String(format:"%@%@/%@",baseURL,comment,userId), APIno: COMMENT_TAG)
    }
    func getMapEventCall()
    {
        callAPI(String(format:"%@%@",baseURL,map), APIno: MAP_EVENT_TAG)
    }
    func callAPI(urlString:String,APIno apiNO:Int)
    {
        if(GlobalClass.sharedInstance.checkInternet())
        {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = true
            let request = NSMutableURLRequest(URL:NSURL(string:urlString)!)
            request.HTTPMethod = "GET"
            
            print(request.URL)
            let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
                data, response, error in
                
                if error != nil
                {
                    
                    self.gotError((error?.localizedDescription)!)
                    return
                }
                else
                {
                    let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    do
                    {
                        let responseData = try NSJSONSerialization.JSONObjectWithData((responseString?.dataUsingEncoding(NSUTF8StringEncoding))!, options: NSJSONReadingOptions.MutableContainers)
                        
                        if(apiNO == APPRECIATION_TAG)
                        {
                            self.seprateDataFromMainArrray(self.checkResponseDataClass(responseData))
                            self.giveneraDelegate?.appreciationSuccess!()
                        }
                        else if(apiNO == PARTICIPANT_TAG)
                        {
                            self.participantArray =  self.checkResponseDataClass(responseData)
                           
                        }
                        else if(apiNO == USER_TAG)
                        {
                            self.userArray =  self.checkResponseDataClass(responseData)
                            self.getCommentCall()
                        }
                        else if (apiNO == COMMENT_TAG)
                        {
                            self.commentArray =  self.checkResponseDataClass(responseData)
                           
                        }
                        else if (apiNO == USER_BY_ID_TAG)
                        {
                            let userArray =  self.checkResponseDataClass(responseData)
                            self.giveneraDelegate?.userCallSuccess!(userArray)
                        }
                        else if (apiNO == MAP_EVENT_TAG)
                        {
                            let eventArray =  self.checkResponseDataClass(responseData)
                            self.giveneraDelegate?.eventCallSuccess!(eventArray)
                        }
                        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                    }
                    catch
                    {
                    }
                }
            }
            task.resume()
        }
        else
        {
            self.alert(Alert, message:INTERNET_NOT_AVAILABLE, buttonTitle: "OK")
            GlobalClass.sharedInstance.HideLoader()
        }
    }
    
    func alert(title1:String , message msg:String ,buttonTitle button:String)
    {
        let alert: UIAlertView = UIAlertView()
        alert.delegate = nil
        alert.title = title1
        alert.message = msg
        alert.addButtonWithTitle(button)
        alert.show()
    }
    
    //MARK: 
    //MARK: COMMON USEFUL METHOD 
    //MARK:
    
    
    func gotError(message:String)
    {
        dispatch_async(dispatch_get_main_queue(), {
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            GlobalClass.sharedInstance.HideLoader()
            self.alert(Alert, message: message, buttonTitle: "OK")
        });
        self.giveneraDelegate?.serverSyncFailure!()
    }
    
    func checkResponseDataClass(responseClass:AnyObject) -> NSArray /// to avoid crash
    {
        var  array : NSArray!
        if(responseClass.self .isKindOfClass(NSMutableDictionary) || responseClass.self .isKindOfClass(NSDictionary))
        {
            array = NSArray(objects:responseClass)
        }
        else if(responseClass.self .isKindOfClass(NSMutableArray) || responseClass.self .isKindOfClass(NSArray))
        {
            array = responseClass as! NSArray
        }
        else
        {
            array = NSArray()
        }
        print(array.count)
        return array
    }
    
    func areTheySameClass(class1: AnyObject!, class2: AnyObject!) -> Bool
    {
        return object_getClassName(class1) == object_getClassName(class2)
    }

    
    func seprateDataFromMainArrray(array:NSArray)
    {
        eventArray = NSMutableArray ()
        for (var i = 0; i<array.count; i++)
        {
            let eventObj = GiveneraAppreciation()
           
            eventObj.eventID = array.objectAtIndex(i).objectForKey(eventID) as! String
            eventObj.eventDisc = array.objectAtIndex(i).objectForKey(eventDisc) as! String
            eventObj.eventID = getLastChar(eventObj.eventID,n:5)
            eventObj.eventDateStr = array.objectAtIndex(i).objectForKey(event_date) as! String
            
            eventObj.eventDate =  getDate(eventObj)

           eventObj.eventDateStr = getDateString(eventObj)
           
            eventObj.employeeList = array.objectAtIndex(i).objectForKey(employeeList) as! NSMutableArray
            eventObj.imageArray = array.objectAtIndex(i).objectForKey(images) as! NSArray
            
            eventObj.employerList = array.objectAtIndex(i).objectForKey(employerList) as! NSMutableArray
            eventObj.eventCreator = array.objectAtIndex(i).objectForKey(creatorId) as! String
            eventArray.addObject(eventObj)
        }
    }
    
    func getLastChar(str:String, n:Int)->String
    {
        let    index1 = str.endIndex.advancedBy(-n)
        let    substring1 = str.substringFromIndex(index1)
        return substring1
        
    }
    
    func removeLastChar(str:String, n:Int)->String
    {
        let index1 = str.endIndex.advancedBy(-n)
        let  substring1 = str.substringToIndex(index1)
        return substring1
        
    }
    
      
    func getDate(eventObj:GiveneraAppreciation)->NSDate
    {
        let index1 = eventObj.eventDateStr.endIndex.advancedBy(-4) // Remove last time zone character
        let substring1 = eventObj.eventDateStr.substringToIndex(index1)
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "dd-MMM-yyyy HH:mm:ss"
       return  dateFormat.dateFromString(substring1)!
             
      
    }
    
    func getDateString(eventObj:GiveneraAppreciation) ->String
    {
        let index1 = eventObj.eventDateStr.endIndex.advancedBy(-4) // Remove last time zone character
        let substring1 = eventObj.eventDateStr.substringToIndex(index1)
        
        let dateFormat = NSDateFormatter()
        dateFormat.dateFormat = "dd-MMM-yyyy HH:mm:ss"
        
        let da = dateFormat.dateFromString(substring1)!
        dateFormat.dateFormat = "dd/MM"
        return dateFormat.stringFromDate(da)
    }

    

   
}
