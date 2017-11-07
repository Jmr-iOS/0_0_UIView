// ref: http://stackoverflow.com/questions/24339145/how-do-i-write-a-custom-init-for-a-uiview-subclass-in-swift/37645346?noredirect=1#comment66816342_37645346

import UIKit

class CustomSubview : UIView {
    
    init() {
        super.init(frame: UIScreen.mainScreen().bounds);
        
        let windowHeight : CGFloat = 150;
        let windowWidth  : CGFloat = 360;
        
        let borderSize : CGFloat = 2;
        let borderColor : CGColor = UIColor(red:   140/255, green: 140/255, blue:  140/255, alpha: 1.0).CGColor; //Apple Border Color
        

        self.backgroundColor = UIColor.whiteColor();
        self.frame = CGRectMake(0, 0, windowWidth, windowHeight);
        self.center = CGPoint(x: UIScreen.mainScreen().bounds.width/2, y: 375);

 
        //Generate upper border for the View
        let upperBorder : CALayer = CALayer();
        upperBorder.frame = CGRectMake(0, 0, self.frame.width, borderSize);
        upperBorder.backgroundColor = borderColor;
 
        //Generate bottom border for the View
        let bottomBorder : CALayer = CALayer();
        bottomBorder.frame = CGRectMake(0, windowHeight - borderSize, self.frame.width, borderSize);
        bottomBorder.backgroundColor = borderColor;
 
        //Generate left border for the View
        let leftBorder : CALayer = CALayer();
        leftBorder.frame = CGRectMake(0,0, borderSize, self.frame.height);
        leftBorder.backgroundColor = borderColor;
 
        //Generate left border for the View
        let rightBorder : CALayer = CALayer();
        rightBorder.frame = CGRectMake(self.frame.width-borderSize, 0, borderSize, self.frame.height);
        rightBorder.backgroundColor = borderColor;
 
        //Add border
        self.layer.addSublayer(upperBorder);          /* note - it could be added to self.view.layer instead if desired   */
        self.layer.addSublayer(bottomBorder);
        self.layer.addSublayer(leftBorder);
        self.layer.addSublayer(rightBorder);


        //for debug validation
        self.backgroundColor = UIColor.grayColor();
        print("My Custom Init");
 
        return;
    }
 
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}