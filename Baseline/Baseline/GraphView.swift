import UIKit

@IBDesignable class GraphView: UIView {
  
  //Weekly sample data
  var graphPoints:[Int] = [4, 2, 6, 4]
  
  //1 - the properties for the gradient
  @IBInspectable var startColor: UIColor = UIColor.clearColor()
  @IBInspectable var endColor: UIColor = UIColor.clearColor()
  
  override func drawRect(rect: CGRect) {
    
    let width = rect.width
    let height = rect.height
    
    //set up background clipping area
    let path = UIBezierPath(roundedRect: rect,
      byRoundingCorners: UIRectCorner.AllCorners,
      cornerRadii: CGSize(width: 1, height: 1))
    path.addClip()
    
    //2 - get the current context
    let context = UIGraphicsGetCurrentContext()
    let colors = [startColor.CGColor, endColor.CGColor]
    
    //3 - set up the color space
    let colorSpace = CGColorSpaceCreateDeviceRGB()
    
    //4 - set up the color stops
    let colorLocations:[CGFloat] = [0.0, 1.0]
    
    //5 - create the gradient
    let gradient = CGGradientCreateWithColors(colorSpace,
      colors,
      colorLocations)
    
    //6 - draw the gradient
    var startPoint = CGPoint.zero
    var endPoint = CGPoint(x:0, y:self.bounds.height)
    CGContextDrawLinearGradient(context,
      gradient,
      startPoint,
      endPoint,
      CGGradientDrawingOptions.init(rawValue: 0))
    
    //calculate the x point
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul","Aug","Sep","Oct","Nov","Dec"]

    
    let margin:CGFloat = 20.0
    let columnXPoint =
    {
        (column:Int) -> CGFloat in
      //Calculate gap between points
      let spacer = (width - margin*2 - 4) /
        CGFloat((self.graphPoints.count - 1))
      var x:CGFloat = CGFloat(column) * spacer
      x += margin + 2
      let lblMonth = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(x + 10, self.frame.size.height - 20, 30, 20), backColor: CC, fontColor: WC, text:months[column] , textAlign:NSTextAlignment.Center, fontSize:12)
      self.addSubview(lblMonth)
        
      return x
    }
    
    let topBorder:CGFloat = 50
    let bottomBorder:CGFloat = 50
    let graphHeight = height - topBorder - bottomBorder
    // calculate the y point
    
    
    var yy = rect.origin.y + 40
    
    let points :[Int] = [0 ,10, 20, 30, 40]
    
    
    let maxValue = points.maxElement()!
   
    let columnYPoint = {
        (graphPoint:Int) -> CGFloat in
     var y:CGFloat = CGFloat(graphPoint)
        CGFloat(maxValue) * graphHeight
        
        y = graphHeight + topBorder - y // Flip the graph
        
     return y
    }
    
    print( graphHeight / CGFloat(points.count) )
    
    for(var i = points.count - 1 ; i >= 0; i--)
    {
        print(i)
        let str = String(format:" %d" ,points[i])
        let lblPoints = GlobalClass.sharedInstance.configLabelFrame(CGRectMake(0, yy, 30, 20), backColor: RC, fontColor: WC, text:str , textAlign:NSTextAlignment.Center, fontSize:12)
        self.addSubview(lblPoints)
        yy = yy + lblPoints.frame.size.height + 10   // Flip the graph
    }

    
    // draw the line graph
    
    UIColor.blueColor().setFill()
    UIColor.blueColor().setStroke()
    
    //set up the points line
    let graphPath = UIBezierPath()
    //go to start of line
    graphPath.moveToPoint(CGPoint(x:columnXPoint(0),
      y:columnYPoint(graphPoints[0])))
    
    //add points for each item in the graphPoints array
    //at the correct (x, y) for the point
    for i in 1..<graphPoints.count {
      let nextPoint = CGPoint(x:columnXPoint(i),
        y:columnYPoint(graphPoints[i]))
      graphPath.addLineToPoint(nextPoint)
    }
    
    //Create the clipping path for the graph gradient
    
    //1 - save the state of the context (commented out for now)
    CGContextSaveGState(context)
    
    //2 - make a copy of the path
    let clippingPath = graphPath.copy() as! UIBezierPath
    
    //3 - add lines to the copied path to complete the clip area
    clippingPath.addLineToPoint(CGPoint(
      x: columnXPoint(graphPoints.count - 1),
      y:height))
    clippingPath.addLineToPoint(CGPoint(
      x:columnXPoint(0),
      y:height))
    clippingPath.closePath()
    
    //4 - add the clipping path to the context
    clippingPath.addClip()
    
    let highestYPoint = columnYPoint(maxValue)
   startPoint = CGPoint(x:margin, y: highestYPoint)
    endPoint = CGPoint(x:margin, y:self.bounds.height)
    
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, CGGradientDrawingOptions.init(rawValue: 0))
    CGContextRestoreGState(context)
    
    //draw the line on top of the clipped gradient
    graphPath.lineWidth = 2.0
    graphPath.stroke()
    
    //Draw the circles on top of graph stroke
    for i in 0..<graphPoints.count
    {
      var point = CGPoint(x:columnXPoint(i), y:columnYPoint(graphPoints[i]))
      point.x -= 5.0/2
      point.y -= 5.0/2
      
      let circle = UIBezierPath(ovalInRect:
        CGRect(origin: point,
          size: CGSize(width: 5.0, height: 5.0)))
      circle.fill()
    }
    
    
    
    //Draw horizontal graph lines on the top of everything
    let linePath = UIBezierPath()
    
    //top line
    linePath.moveToPoint(CGPoint(x:margin, y: topBorder))
    linePath.addLineToPoint(CGPoint(x: width - margin,
      y:topBorder))
    
    //center line
    linePath.moveToPoint(CGPoint(x:margin,
      y: graphHeight/2 + topBorder))
    linePath.addLineToPoint(CGPoint(x:width - margin,
      y:graphHeight/2 + topBorder))
    
    //bottom line
    linePath.moveToPoint(CGPoint(x:margin,
      y:height - bottomBorder))
    linePath.addLineToPoint(CGPoint(x:width - margin,
      y:height - bottomBorder))
    let color = UIColor(white: 1.0, alpha: 0.3)
    color.setStroke()
    
    linePath.lineWidth = 1.0
    linePath.stroke()
    
    
  }
}