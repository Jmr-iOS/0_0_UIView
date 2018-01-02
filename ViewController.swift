/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @project    0_0 - UIView
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/6/16
 *  @last rev   1/2/18
 *
 *
 *  @notes      x
 *
 *  @section    Animations Reference
 *      http://www.raywenderlich.com/76200/basic-uiview-animation-swift-tutorial
 *      http://www.raywenderlich.com/86521/how-to-make-a-view-controller-transition-animation-like-in-the-ping-app
 *
 *  @section    Reference
 *      http://stackoverflow.com/questions/24046898/how-do-i-create-a-new-swift-project-without-using-storyboards
 *      http://stackoverflow.com/questions/24030348/how-to-create-a-button-programmatically
 *      http://stackoverflow.com/questions/24102191/make-a-uibutton-programatically-in-swift
 *
 *  @section    Opens
 *      @objc drops
 *      add data
 *      add rounded corners
 *      print() formats consistent
 *      misc cleanups (wow, non-standardized)
 *
 *     @section    Legal Disclaimer
 *             All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *             Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var viewOne   : CustomView!;
    var viewTwo   : UIView!;
    var viewThree : UIView!;
    
    var popupView  : UIView!;
    var scrollView : UIScrollView!;
    
    let popupHeight : CGFloat = 35;
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        self.genBasicViews();
        self.genScrollView();
        self.genUpperBorderedView();
        self.genPopup();
        self.add_primary_tapResponse();
        
        return;
    }
    
    
    func genBasicViews() {
        
        //View One
        self.viewOne = CustomView();
        //(if needed) self.viewOne.backgroundColor = UIColor.redColor();
        self.viewOne.frame = self.view.frame;
        
        //Misc. Buttons
        self.addLabel(self.viewOne,     dispStr: "View 1", yCoord: 60);
        self.addSubviewButton(self.viewOne,    return_msg: "Launch View #2",       action_fcn:  #selector(ViewController.press_launch(_:)));
        self.addScrollViewButton(self.viewOne, return_msg: "Launch ScrollView",    action_fcn:  #selector(ViewController.press_scrollLaunch(_:)));
        self.addPopupViewButton(self.viewOne,  return_msg: "Launch Popup Message", action_fcn:  #selector(ViewController.press_popupLaunch(_:)));
        
        //View Two
        self.viewTwo = UIView();
        self.viewTwo.backgroundColor = UIColor.blue;
        self.viewTwo.frame = self.view.frame;
        
        self.addLabel(self.viewTwo, dispStr: "View 2", yCoord: 60);
        self.addSubviewButton(self.viewTwo, return_msg: "Return to View #1", action_fcn:  #selector(ViewController.press_return(_:)));

        self.viewOne.frame = self.view.frame;
        self.viewTwo.frame = CGRect(x: self.view.frame.width,
                                        y: 0,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height);            /* init off-screen                              */

        self.view.addSubview(self.viewOne);                                         /* add em both!                                 */
        self.view.addSubview(self.viewTwo);
        
        return;
    }
    
    
    func genScrollView() {
        
        let scrollViewHeight : CGFloat = 3 * self.view.frame.height;
        
        self.scrollView = UIScrollView.init(frame: self.view.frame);
        
        self.scrollView.backgroundColor = UIColor.green;
        
        self.scrollView.frame = CGRect(x: self.view.frame.width,
                                           y: 0,
                                           width: self.view.frame.width,            /* init off-screen                              */
                                           height: scrollViewHeight);
        
        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.width, height: self.scrollView.frame.height);
        
        self.scrollView.isUserInteractionEnabled = true;
        
        self.addLabel(self.scrollView, dispStr: "ScrollView", yCoord: 60);
        
        self.addSubviewButton(self.scrollView, return_msg: "Return to View #1", action_fcn:  #selector(ViewController.press_return(_:)));
        
        self.addLabel(self.scrollView, dispStr: "midText", yCoord: scrollViewHeight/2);
        self.addLabel(self.scrollView, dispStr: "LowText", yCoord: scrollViewHeight-75);


        self.view.addSubview(self.scrollView);

        return;
    }
    
    
    func genPopup() {
        
        //Popup View (from bottom
        self.popupView = UIView();
        self.popupView.backgroundColor = UIColor(red: 83/255, green: 90/255, blue: 102/255, alpha: 1); //UIColor.blackColor();

        let someLabel : UILabel = UILabel(frame: CGRect(x:0,y:0,width:self.view.frame.width,height:popupHeight));
        someLabel.font  =   UIFont(name: "HelveticaNeue", size: 17);
        someLabel.text  =   "Test Message - A nice and good message";
        someLabel.textColor     = UIColor.white;
        someLabel.textAlignment = NSTextAlignment.center;
        
        self.popupView.addSubview(someLabel);
        
        self.popupView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.frame.width, height: popupHeight);
 
        return;
    }
    
    
    func genUpperBorderedView() {

        //Generate the View
        self.viewThree = CustomSubview();

        //Add
        self.view.addSubview(self.viewThree);

        return;
    }
    
    
    
    func isViewInFront(_ viewSelection : Int) -> Bool {
        
        let viewOne_x    = self.viewOne.frame.origin.x;
        let viewTwo_x    = self.viewTwo.frame.origin.x;
        let scrollView_x = self.scrollView.frame.origin.x;
        
        switch(viewSelection) {
        case 1:
            if ((viewOne_x == 0)&&(viewTwo_x != 0)&&(scrollView_x != 0)) {
                return true;
            }
            break;
        case 2:
            if ((viewTwo_x == 0)&&(scrollView_x != 0)) {
                return true;
            }
            break;
        case 3:
            if (scrollView_x == 0) {
                return true;
            }
            break;
        default:
            fatalError("invalid viewSelection presented in isViewInFront()");
        }
        
        return false;
    }
    
    
    // View Numbers 1=View One, 2=View Two, 3=ScrollView
    func pick_view(_ viewSelection : Int) {
        
        if(viewSelection == 2) {
            self.view.addSubview(viewTwo);
        } else if (viewSelection == 3) {
            self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false);           //reset view origin before load!
            self.view.addSubview(scrollView);
        }
        
        print("old view off!");
        
        let animDur_s : Double = 0.5;
        let animDel_s : Double = 0.5;
        
        UIView.animate(withDuration: animDur_s, delay: animDel_s, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            
            var newView2InFront      : Bool = (self.viewTwo.frame.origin.x == 0);
            var newScrollViewInFront : Bool = (self.scrollView.frame.origin.x == 0);
            
            if(viewSelection == 2) {                                /* Slide View 2 into view                                       */
                print("sliding view 2 in!");
                self.viewTwo.alpha = 1.0;
                self.viewTwo.frame = self.view.frame;
                newView2InFront = true;
                newScrollViewInFront = false;
                
            } else if (viewSelection == 3) {                        /* Slide ScrollView into view                                   */
                print("sliding scrollview in!");
                self.scrollView.alpha = 1.0;
                self.scrollView.frame = self.view.frame;
                newScrollViewInFront = true;
                newView2InFront = false;
                
            } else {                                                /* Slide View 2 out of view                                     */
                
                print("sliding old view(s) out!");
                
                //if view 2 in front
                if(newView2InFront == true) {
                    
                    self.viewOne.frame = self.view.frame;
                    self.viewTwo.frame = CGRect(x: self.view.frame.width,
                        y: 0,
                        width: self.view.frame.width,
                        height: self.view.frame.height);                    /* init off-screen                                              */
                }
                
                //if scrollview in front
                if(newScrollViewInFront == true) {
                    
                    self.viewOne.frame = self.view.frame;
                    self.scrollView.frame = CGRect(x: self.view.frame.width,
                        y: 0,
                        width: self.view.frame.width,
                        height: self.view.frame.height);                    /* init off-screen                                              */
                }
                
                newScrollViewInFront = false;
                newView2InFront = false;
                
            }
            }, completion: { (finished: Bool) -> Void in
                
                if(viewSelection == 2) {        /* Slide View 2 into view                                                           */
                    print("sliding view 2 in completion!");
                    
                    self.viewOne.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
                    
                } else {                        /* Slide View 2 out of view                                                         */
                    print("sliding view 2 out completion!");
                    
                    self.viewTwo.frame = CGRect(x: self.view.frame.width, y: 0, width: self.view.frame.width, height: self.view.frame.height); //TEMP
                }
        });
        
        return;
    }

    
    //open bring pop-up from bottom
    func loadPopup(_ dir : Bool) {

        if(dir == true) {
            self.view.addSubview(self.popupView);

            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            
                    print("sliding popup in!");
                    self.popupView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-self.popupHeight, width: self.view.frame.width, height: self.popupHeight);
            
                }, completion: { (finished: Bool) -> Void in
                        print("sliding popup in completion!");
                        self.viewOne.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            });
        } else {
            print("off!");
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                
                print("sliding popup out");
                self.viewOne.frame = UIScreen.main.bounds;
                self.popupView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.frame.width, height: self.popupHeight);
                
                }, completion: { (finished: Bool) -> Void in
                    print("sliding popup out completion");
            });
        }
        
        return;
    }


    func add_primary_tapResponse() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.myPrimaryTapResponse(_:)));
        
        tapGesture.delegate = self;
        
        self.view.addGestureRecognizer(tapGesture);
        
        self.add_popup_tapResponse();
        
        return;
    }
    
    
    func add_popup_tapResponse() {
        
        let pop_tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.myPrimaryTapResponse2(_:)));
        
        pop_tapGesture.delegate = self;
        
        self.popupView.addGestureRecognizer(pop_tapGesture);
        
        return;
    }
    
    
    func addLabel(_ aView: UIView, dispStr : String, yCoord : CGFloat) {
        
        let anotherView : UIView = UIView(frame: CGRect(x: 20, y:yCoord, width: 120, height: 50));
        
        anotherView.backgroundColor = UIColor.gray;
        
        anotherView.layer.cornerRadius = 15;
        
        let someLabel : UILabel = UILabel(frame: CGRect(x:5, y: 0, width: anotherView.frame.width, height:  anotherView.frame.height));
        
        someLabel.font  =   UIFont(name: "HelveticaNeue", size: 23);
        someLabel.text  =   dispStr;
        someLabel.textColor     = UIColor.white;
        someLabel.textAlignment = NSTextAlignment.center;
        
        anotherView.addSubview(someLabel);
        
        aView.addSubview(anotherView);
        
        return;
    }
    
    
    func addSubviewButton(_ aView: UIView, return_msg: String, action_fcn : Selector) {
        
        let newButton : UIButton = UIButton(type: UIButtonType.roundedRect);
        
        newButton.translatesAutoresizingMaskIntoConstraints = true;                     /* must be true for center to work          */
        
        newButton.setTitle(return_msg,      for: UIControlState());
        newButton.backgroundColor = UIColor.white;
        
        newButton.sizeToFit();
        newButton.center = CGPoint(x: (UIScreen.main.bounds.width)/2, y: 250);    /* must call after it's sized or won't work!*/
        newButton.frame = nudgeTextFrame(newButton.frame, width_expand: 10);
        
        //actions
        newButton.addTarget(self, action: action_fcn, for:  .touchUpInside);
        
        //add!
        aView.addSubview(newButton);
        
        return;
    }
    
    
    func addScrollViewButton(_ aView: UIView, return_msg: String, action_fcn : Selector) {
        
        let newButton2 : UIButton = UIButton(type: UIButtonType.roundedRect);
        
        newButton2.translatesAutoresizingMaskIntoConstraints = true;                     /* must be true for center to work          */
        
        newButton2.setTitle(return_msg,      for: UIControlState());
        newButton2.backgroundColor = UIColor.white;
        
        newButton2.sizeToFit();
        newButton2.center = CGPoint(x: (UIScreen.main.bounds.width)/2, y: 500);    /* must call after it's sized or won't work!*/
        newButton2.frame = nudgeTextFrame(newButton2.frame, width_expand: 20);
        
        //actions
        newButton2.addTarget(self, action: action_fcn, for:  .touchUpInside);
        
        //add!
        aView.addSubview(newButton2);
        
        return;
    }

    
    func addPopupViewButton(_ aView: UIView, return_msg: String, action_fcn : Selector) {
        
        let newButton2 : UIButton = UIButton(type: UIButtonType.roundedRect);
        
        newButton2.translatesAutoresizingMaskIntoConstraints = true;                     /* must be true for center to work          */
        
        newButton2.setTitle(return_msg,      for: UIControlState());
        newButton2.backgroundColor = UIColor.white;
        
        newButton2.sizeToFit();
        newButton2.center = CGPoint(x: (UIScreen.main.bounds.width)/2, y: 600);    /* must call after it's sized or won't work!*/
        newButton2.frame = nudgeTextFrame(newButton2.frame, width_expand: 20);
        
        //actions
        newButton2.addTarget(self, action: action_fcn, for:  .touchUpInside);
        
        //add!
        aView.addSubview(newButton2);
        
        return;
    }

    
    //@brief    nudge the width of a text button's frame to fit the text
    func nudgeTextFrame(_ origFrame : CGRect, width_expand : CGFloat) -> CGRect {

        let size : CGFloat = origFrame.width + width_expand;
        
        let newFrame : CGRect = CGRect(x: origFrame.origin.x - (width_expand/2), y: origFrame.origin.y, width: size, height: origFrame.height);

        return newFrame;
    }


    @objc func myPrimaryTapResponse(_ sender: UITapGestureRecognizer) {
        print("Bam here it is!!!!");
        //let tappedView = sender.view as UIView!;
        return;
    }
    
    
    @objc func myPrimaryTapResponse2(_ sender: UITapGestureRecognizer) {
        print("Pop???");
        self.loadPopup(false);
        return;
    }
    
    
    @objc func press_launch(_ sender: UIButton!) {
        
        print("\(sender.titleLabel!.text!) was pressed and press_launch called");
        
        self.pick_view(2);
        
        return;
    }
    
    
    @objc func press_scrollLaunch(_ sender: UIButton!) {
        print("\(sender.titleLabel!.text!) was pressed and press_scrollLaunch called!");
        
        self.pick_view(3);
        
        return;
    }
    
    
    @objc func press_return(_ sender: UIButton!) {
        print("\(sender.titleLabel!.text!) was pressed and press_return called");
        
        self.pick_view(1);
        
        return;
    }
    
    
    @objc func press_popupLaunch(_ sender: UIButton!) {
        print("\(sender.titleLabel!.text!) was pressed and press_popupLaunch called!");

        self.loadPopup(true);
        
        return;
    }
    
    
    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning(); }
}

