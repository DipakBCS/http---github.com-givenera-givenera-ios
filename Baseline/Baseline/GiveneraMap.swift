//
//  GiveneraMap.swift
//  Baseline
//
//  Created by Bharti Softech on 12/9/15.
//  Copyright © 2015 Givenera. All rights reserved.
//
    
import UIKit
import MapKit

class GiveneraMap: UIViewController,GiveneraManagerDelagate ,MKMapViewDelegate
{
   
    
    var donateView : UIView!
    
    var mapView    : MKMapView!
    
    //  MARK:
    //  MARK: VIEW LIFE CYCLE
    //  MARK:
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Default for iphone 5
        var bottomViewHeight = CGFloat(150)
        var fontS = 15
        
        if(iPhone6)
        {
            bottomViewHeight = 180
        }
        
        else if(iPhone6P)
        {
            bottomViewHeight = 200
            fontS = 17
        }
        
        GlobalClass.sharedInstance.addBackgroundImage(self.view)
        
        let lblTitle = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(screenWidth/2 - 110, UIApplication.sharedApplication().statusBarFrame.size.height, 220, y), backColor: CC, fontColor: WC, text: "Light up the world with kindness by helping others", textAlign:.Center,fontSize: fontS)
        lblTitle.numberOfLines = 2
        lblTitle.lineBreakMode = .ByWordWrapping
        
        self.view.addSubview(lblTitle)
        
        let btnMenu = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(10, 30, 50, 40), backCol: CC, textCol: WC, btnTitle:"", imageName: "Menu.png")
        btnMenu.addTarget(self, action: Selector("menuClicked"), forControlEvents:.TouchUpInside)
        self.view.addSubview(btnMenu)
        
        let btnSearch = GlobalClass.sharedInstance.configButton(2, frame: CGRectMake(screenWidth - 2*btnMenu.frame.origin.x - 25 , btnMenu.frame.origin.y + 10 , 25, 25), backCol: CC, textCol: WC, btnTitle:"", imageName: "Search.png")
        btnMenu.addTarget(self, action: Selector("searchClicked"), forControlEvents:.TouchUpInside)
        self.view.addSubview(btnSearch)
        
        mapView = MKMapView(frame: CGRectMake(0, lblTitle.frame.origin.y + lblTitle.frame.size.height + 10, screenWidth, screenHeight - bottomViewHeight))
        
        GlobalClass.sharedInstance.addCustomTabbarView(self.view, inVC: self, selectedTab:0)
        
        if #available(iOS 9.0, *)
        {
            mapView.mapType = MKMapType.SatelliteFlyover
            //mapView.mapType = MKMapType.Standard
        } else {
            mapView.mapType = MKMapType.Satellite
        }
        mapView.showsBuildings = true
        mapView.delegate = self
        self.view.addSubview(mapView)        
        
        donateView = GlobalClass.sharedInstance.configView( CGRectMake(-screenWidth, mapView.frame.size.height + 5, screenWidth, 90), bColor: DEFAULT_COLOR)
        donateView.tag = DONATE_VIEW_TAG
        
        UIView.animateWithDuration(0.5, animations: {
            self.donateView.frame = CGRectMake(0, self.donateView.frame.origin.y, screenWidth, self.donateView.frame.size.height)
        })
        
        let btnClose = GlobalClass.sharedInstance.configButton(1, frame: CGRectMake(donateView.frame.size.width - 40,0, 40, 40), backCol: CC, textCol: BC, btnTitle:"X", imageName: "")
        btnClose.addTarget(self, action: Selector("closeClicked"), forControlEvents:.TouchUpInside)
        donateView.addSubview(btnClose)
        
        let btnDonate = GlobalClass.sharedInstance.configButton(1, frame: CGRectMake(donateView.frame.size.width/2 - 40,20, 80, 30), backCol:DONATE_COLOR, textCol: WC, btnTitle:"Donate", imageName: "")
        btnDonate.layer.cornerRadius = btnDonate.frame.size.height / 2
        btnDonate.addTarget(self, action: Selector("donateClicked"), forControlEvents:.TouchUpInside)
        donateView.addSubview(btnDonate)
        
        let lblDonate = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(20, btnDonate.frame.origin.y + btnDonate.frame.size.height + 10, screenWidth - 40, 20), backColor: CC, fontColor: WC, text: "Donate to support this dream.", textAlign:.Center,fontSize:16)
        donateView.addSubview(lblDonate)
        self.view.addSubview(donateView)
        
        GiveneraManager.sharedInstance.giveneraDelegate = self
        GlobalClass.sharedInstance.initiateLoaderWithMessage(Please_wait, inView: self.view)
        GiveneraManager.sharedInstance.getMapEventCall()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    //  MARK:
    //  MARK: OTHER METHOD
    //  MARK:
    
    func serverSyncFailure()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func donateClicked()
    {
        
    }
    
    func getLatLongDic(lat:String , long:String)->NSMutableDictionary
    {
        let   latlongDic = NSMutableDictionary()
        latlongDic.setValue(lat, forKey: "latitude")
        latlongDic.setValue(long, forKey: "longitude")
        return latlongDic
    }
    
    func getTempLatLong()->NSMutableArray
    {
        let tempLocationArray = NSMutableArray()
        
        var latlongDic = getLatLongDic("30.2275502",long: "-97.8251888")
        tempLocationArray.addObject(latlongDic)
        
        latlongDic = getLatLongDic("30.2247691",long: "-97.8225066")
        tempLocationArray.addObject(latlongDic)
        
        
        latlongDic = getLatLongDic("30.2260299",long: "-97.819835")
        tempLocationArray.addObject(latlongDic)

        latlongDic = getLatLongDic("30.2267268",long: "-97.818429")
        tempLocationArray.addObject(latlongDic)
        
        latlongDic = getLatLongDic("30.22785",long: "-97.8126664")
        tempLocationArray.addObject(latlongDic)
        
        latlongDic = getLatLongDic("30.2280281",long: "-97.8113808")
        tempLocationArray.addObject(latlongDic)
       
        latlongDic = getLatLongDic("30.2280281",long: "-97.8113808")
        tempLocationArray.addObject(latlongDic)

        
        latlongDic = getLatLongDic("30.2280281",long: "-97.8113808")
        tempLocationArray.addObject(latlongDic)

        
        return tempLocationArray

    }
    
    func eventCallSuccess(eventArray:NSArray)
    {
        let array =  NSMutableArray()

        dispatch_async(dispatch_get_main_queue(), {
             GlobalClass.sharedInstance.HideLoader()
             self.removeDonateView()
            
        })

        // Test Chages 
        for(var i = 0; i<eventArray.count; i++)
        {
            let dic  = eventArray.objectAtIndex(i) as! NSDictionary
            let star = GlobalClass.sharedInstance.checkKeyInDictionary (dic, key: "star")
            let appriId = GlobalClass.sharedInstance.checkKeyInDictionary (dic, key: "appreciationID")
            let lat  = (GlobalClass.sharedInstance.checkKeyInDictionary(dic, key: "latitude") as NSString).doubleValue
            let long = (GlobalClass.sharedInstance.checkKeyInDictionary(dic, key: "longitude")as NSString).doubleValue
                      
         
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            let annotation = Annotation.init(coordinate: coordinate, index: i, star: GlobalClass.sharedInstance.checkNullString(star),appriationID:appriId)
            array.addObject(annotation)           
            
            setRegion(latitude: lat, longitude: long)
        }
        if let annotationArray = array as NSArray as? [MKAnnotation]
        {
            mapView.addAnnotations(annotationArray)
        }
    }
    
    func setRegion(latitude lat: Double,longitude longi: Double)
    {
        let span = MKCoordinateSpanMake(0.075, 0.075)

        let  region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: longi), span: span)
        mapView.setRegion(region, animated: true)
    }
    
    //MARK:
    //MARK: MKMapView Methods
    //MARK:
    
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView?
    {
        if let annotation = annotation as? Annotation
        {
            let identifier = "pin"
            var view: MKAnnotationView?
            if let dequeuedView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
                as? MKPinAnnotationView
            { // 2
                    dequeuedView.annotation = annotation
                   // view = dequeuedView
            }
            else
            {
                if view == nil
                {
                     view = MKAnnotationView(annotation: annotation, reuseIdentifier:identifier)
                }
                if(annotation.star == weekly)
                {
                    view!.image = UIImage(named:GREEN_STAR)
                }
                else  if(annotation.star == monthly)
                {
                    view!.image = UIImage(named:BLUE_STAR)
                }
                else if(annotation.star == yearly)
                {
                    view!.image = UIImage(named:RED_STAR)
                }
                else
                {
                    view!.image = UIImage(named:WHITE_ROUND)
                }
                //view.colo = anot.color
                
            }
            return view
        }
        return nil
    }
        
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    {
        if view.annotation! .isKindOfClass(MKUserLocation)
        {
            
        }
        else
        {
            let annotation = view.annotation as! Annotation
            mapView.deselectAnnotation(annotation, animated: true)
            
            let   objVC = GiveneraMapDetail(nibName: "GiveneraMapDetail", bundle: nil)
            objVC.appriationID = annotation.appriationID
            self.navigationController?.pushViewController(objVC, animated: true)
          //  GlobalClass.sharedInstance.alert(Success, message:String(format: "Appriation Id =%@", annotation.appriationID))
            
        }
        print("didSelectAnnotationView")
    }
    func mapViewDidFailLoadingMap(mapView: MKMapView, withError error: NSError)
    {
        print(error.description)
    }
    func mapView(mapView: MKMapView, didFailToLocateUserWithError error: NSError)
    {
        print(error.description)
    }
    //MARK:
    //MARK: BUTTON CLICK EVENTS
    //MARK:
    
    func menuClicked()
    {
        self.navigationController?.popViewControllerAnimated(true)
    }
    func searchClicked()
    {
    }    
    func compareClicked()
    {
        let  objVC = GiveneraCompare(nibName: "GiveneraCompare", bundle: nil)
        self.navigationController?.pushViewController(objVC, animated: true)
    }
    func starClicked()
    {
    }
    func modeClicked()
    {
    }
    
    func removeDonateView()
    {
        UIView.animateWithDuration(0.5, delay: 0.0, options:  UIViewAnimationOptions.CurveEaseInOut,
            animations: {
                self.donateView.frame = CGRectMake(screenWidth, self.donateView.frame.origin.y, screenWidth, 90)
            },
            completion: { _ in
                
                if((self.donateView) != nil)
                {
                    self.donateView.removeFromSuperview()
                }
        })
    }
    func closeClicked()
    {
        removeDonateView()
    }
    
  /*  func getDate()
    {
        let calendar = NSCalendar.currentCalendar()
        
        // Set up date object
        let date = NSDate()
        
        // Create an NSDate for the first and last day of the month
        //let components = calendar.components(NSCalendarUnit.CalendarUnitYear |
        //                                     NSCalendarUnit.CalendarUnitMonth |
        //                                     NSCalendarUnit.WeekdayCalendarUnit |
        //                                     NSCalendarUnit.WeekCalendarUnit |
        //                                     NSCalendarUnit.CalendarUnitDay,
        //                                     fromDate: date)
        
        // Create an NSDate for the first and last day of the month
        let components = NSCalendar.currentCalendar().components(NSCalendarUnit.Month, fromDate: date)
        
        
        
        // Getting the First and Last date of the month
        components.day = 1
        let firstDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        
        components.month  += 1
        components.day     = 0
        let lastDateOfMonth: NSDate = calendar.dateFromComponents(components)!
        
      //  var unitFlags = NSCalendarUnit.WeekOfMonth ||  NSCalendarUnit.Weekday || NSCalendarUnit.Day
        
        let unitFlags: NSCalendarUnit = [.Hour, .Day, .Month, .Year]

        
        let firstDateComponents = calendar.components(unitFlags, fromDate: firstDateOfMonth)
        let lastDateComponents  = calendar.components(unitFlags, fromDate: lastDateOfMonth)
        
        // Sun = 1, Sat = 7
        let firstWeek = firstDateComponents.weekOfMonth
        let lastWeek  = lastDateComponents.weekOfMonth
        
        let numOfDatesToPrepend = firstDateComponents.weekday - 1
        let numOfDatesToAppend  = 7 - lastDateComponents.weekday + (6 - lastDateComponents.weekOfMonth) * 7
        
       // let startDate: NSDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: -numOfDatesToPrepend, toDate: firstDateOfMonth)!
        if #available(iOS 8.0, *) {
            let startDate: NSDate = calendar.dateByAddingUnit(.Day, value: -numOfDatesToPrepend, toDate: firstDateOfMonth, options: .MatchFirst)!
            
            Array(map(0..<42)
                {
                    calendar.dateByAddingUnit(NSCalendarUnit.Day, value: $0, toDate: startDate, options: nil)!
                })

        } else {
            // Fallback on earlier versions
        }
         if #available(iOS 8.0, *) {
             let endDate: NSDate = calendar.dateByAddingUnit(.Day, value: numOfDatesToAppend, toDate: lastDateOfMonth, options: .MatchFirst)!
         } else {
             // Fallback on earlier versions
         }
      //  let endDate:   NSDate = calendar.dateByAddingUnit(NSCalendarUnit.Day, value: numOfDatesToAppend, toDate: lastDateOfMonth, options: nil)!
        
        
        
        "\(components.year)"
        
        
        var dateString = "2014-10-3" // change to your date format
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        var someDate = dateFormatter.dateFromString(dateString)
        print(someDate)

    }*/
    
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
