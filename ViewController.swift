/************************************************************************************************************************************/
/** @file       ViewController.swift
 *  @project    0_0 - UIView
 *  @brief      x
 *  @details    x
 *
 *  @author     Justin Reina, Firmware Engineer, Jaostech
 *  @created    11/6/16
 *  @last rev   1/14/18
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
 *      add data & globals
 *      ...
 *      encapsulation into subroutines for all major examples. clean for copy 'n paste
 *      image to background example
 *      add rounded corners
 *
 *     @section    Legal Disclaimer
 *             All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *             Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit

let verbose : Bool = true;


class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //UI
    var viewOne   : CustomView!;
    var viewTwo   : ViewTwo!;
    var viewThree : UIView!;
    var popupView  : UIView!;
    var scrollView : UIScrollView!;
    
    //Constants
    let popupHeight : CGFloat = 35;
    
    
    /********************************************************************************************************************************/
    /** @fcn        override func viewDidLoad()
     *  @brief      after view has loaded
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func viewDidLoad() {
        super.viewDidLoad();
        
        //Init UI
        genBasicViews();
        genScrollView();
        genUpperBorderedView();
        genPopup();
        add_primary_tapResponse();
        
        if(verbose) { print("ViewController.viewDidLoad():       complete"); }

        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        override func viewDidAppear(_ animated: Bool)
     *  @brief      after view has appeared
     *  @details    used to set orientation if needed
     *
     *  @section    Orientations
     *      landscapeLeft  - bott is right of screen
     *      portrait       - bott is bott of screen
     */
    /********************************************************************************************************************************/
    override func viewDidAppear(_ animated: Bool) {
        let value = UIInterfaceOrientation.portrait.rawValue;
        UIDevice.current.setValue(value, forKey: "orientation");
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        genBasicViews()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func genBasicViews() {
        
        //View One
        viewOne = CustomView();
        //(if needed) self.viewOne.backgroundColor = UIColor.redColor();
        viewOne.frame = self.view.frame;
        
        //Misc. Buttons
        addLabel(self.viewOne,     dispStr: "View 1", yCoord: 60);
        addSubviewButton(self.viewOne,    return_msg: "Launch View #2",       action_fcn:  #selector(ViewController.press_launch(_:)));
        addScrollViewButton(self.viewOne, return_msg: "Launch ScrollView",    action_fcn:  #selector(ViewController.press_scrollLaunch(_:)));
        addPopupViewButton(self.viewOne,  return_msg: "Launch Popup Message", action_fcn:  #selector(ViewController.press_popupLaunch(_:)));
        
        //View Two
        viewTwo = ViewTwo();
        viewTwo.backgroundColor = UIColor.blue;
        viewTwo.frame = self.view.frame;
        
        addLabel(viewTwo, dispStr: "View 2", yCoord: 60);
        addSubviewButton(viewTwo, return_msg: "Return to View #1", action_fcn:  #selector(ViewController.press_return(_:)));

        viewOne.frame = self.view.frame;
        viewTwo.frame = CGRect(x: self.view.frame.width,
                                        y: 0,
                                        width: self.view.frame.width,
                                        height: self.view.frame.height);            /* init off-screen                              */

        self.view.addSubview(viewOne);                                              /* add em both!                                 */
        self.view.addSubview(viewTwo);

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        genScrollView()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func genScrollView() {
        
        let scrollViewHeight : CGFloat = 3 * self.view.frame.height;
        
        scrollView = UIScrollView.init(frame: self.view.frame);
        
        scrollView.backgroundColor = UIColor.green;
        
        scrollView.frame = CGRect(x: self.view.frame.width,
                                           y: 0,
                                           width: self.view.frame.width,            /* init off-screen                              */
                                           height: scrollViewHeight);
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width, height: scrollView.frame.height);
        
        scrollView.isUserInteractionEnabled = true;
        
        addLabel(scrollView, dispStr: "ScrollView", yCoord: 60);
        
        addSubviewButton(scrollView, return_msg: "Return to View #1", action_fcn:  #selector(ViewController.press_return(_:)));
        
        addLabel(scrollView, dispStr: "midText", yCoord: scrollViewHeight/2);
        addLabel(scrollView, dispStr: "LowText", yCoord: scrollViewHeight-75);


        self.view.addSubview(scrollView);

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        genPopup()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func genPopup() {
        
        //Popup View (from bottom
        popupView = UIView();
        popupView.backgroundColor = UIColor(red: 83/255, green: 90/255, blue: 102/255, alpha: 1); //UIColor.blackColor();

        let someLabel : UILabel = UILabel(frame: CGRect(x:0,y:0,width:self.view.frame.width,height:popupHeight));
        someLabel.font  =   UIFont(name: "HelveticaNeue", size: 17);
        someLabel.text  =   "Test Message - A nice and good message";
        someLabel.textColor     = UIColor.white;
        someLabel.textAlignment = NSTextAlignment.center;
        
        popupView.addSubview(someLabel);
        
        popupView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.frame.width, height: popupHeight);
 
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        genUpperBorderedView()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func genUpperBorderedView() {

        //Generate the View
        viewThree = CustomSubview();

        viewThree.setBorder(color: UIColor.white, size: 2);
        
        //Add
        view.addSubview(self.viewThree);

        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        isViewInFront(_ viewSelection : Int) -> Bool
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func isViewInFront(_ viewSelection : Int) -> Bool {
        
        var isInFront : Bool = false;                                   /* init to false, set true if found                         */
        
        let viewOne_x    = viewOne.frame.origin.x;
        let viewTwo_x    = viewTwo.frame.origin.x;
        let scrollView_x = scrollView.frame.origin.x;
        
        switch(viewSelection) {
        case 1:
            if ((viewOne_x == 0)&&(viewTwo_x != 0)&&(scrollView_x != 0)) {
                isInFront = true;
            }
            break;
        case 2:
            if ((viewTwo_x == 0)&&(scrollView_x != 0)) {
                isInFront = true;
            }
            break;
        case 3:
            if (scrollView_x == 0) {
                isInFront = true;
            }
            break;
        default:
            fatalError("invalid viewSelection presented in isViewInFront()");
        }
        
        if(verbose) { print("ViewController.isViewInFront():     view \(viewSelection) in front: \(isInFront)"); }
        
        return isInFront;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        pick_view(_ viewSelection : Int)
     *  @brief      x
     *  @details    view numbers - 1=View One, 2=View Two, 3=ScrollView
     */
    /********************************************************************************************************************************/
    func pick_view(_ viewSelection : Int) {
        
        if(viewSelection == 2) {
            self.view.addSubview(viewTwo);
        } else if (viewSelection == 3) {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false);           //reset view origin before load!
            self.view.addSubview(scrollView);
        }
        
        if(verbose) { print("ViewController.pick_view():         old view off"); }
        
        let animDur_s : Double = 0.5;
        let animDel_s : Double = 0.5;
        
        UIView.animate(withDuration: animDur_s, delay: animDel_s, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            
            var newView2InFront      : Bool = (self.viewTwo.frame.origin.x == 0);
            var newScrollViewInFront : Bool = (self.scrollView.frame.origin.x == 0);
            
            if(viewSelection == 2) {                                /* Slide View 2 into view                                       */
                if(verbose) { print("ViewController.pick_view():         sliding view 2 in"); }
                self.viewTwo.alpha = 1.0;
                self.viewTwo.frame = self.view.frame;
                newView2InFront = true;
                newScrollViewInFront = false;
                
            } else if (viewSelection == 3) {                        /* Slide ScrollView into view                                   */
                if(verbose) { print("ViewController.pick_view():         sliding scrollview in"); }
                self.scrollView.alpha = 1.0;
                self.scrollView.frame = self.view.frame;
                newScrollViewInFront = true;
                newView2InFront = false;
                
            } else {                                                /* Slide View 2 out of view                                     */
                if(verbose) { print("ViewController.pick_view():         sliding old view(s) out"); }
                
                //if view 2 in front
                if(newView2InFront == true) {
                    
                    self.viewOne.frame = self.view.frame;
                    self.viewTwo.frame = CGRect(x: self.view.frame.width,
                        y: 0,
                        width: self.view.frame.width,
                        height: self.view.frame.height);                    /* init off-screen                                      */
                }
                
                //if scrollview in front
                if(newScrollViewInFront == true) {
                    
                    self.viewOne.frame = self.view.frame;
                    self.scrollView.frame = CGRect(x: self.view.frame.width,
                        y: 0,
                        width: self.view.frame.width,
                        height: self.view.frame.height);                    /* init off-screen                                      */
                }
                
                newScrollViewInFront = false;
                newView2InFront = false;
                
            }
            }, completion: { (finished: Bool) -> Void in
                
                if(viewSelection == 2) {                                    /* Slide View 2 into view                               */
                    if(verbose) { print("ViewController.pick_view():         sliding view 2 in completion"); }
                    self.fadeInViewTwoComponents();
                    self.viewOne.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
                    
                } else {                                                    /* Slide View 2 out of view                             */
                    if(verbose) { print("ViewController.pick_view():         sliding view 2 out completion"); }
                }
        });
        
        if(verbose) { print("ViewController.pick_view():         view selection complete"); }
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        fadeInViewTwoComponents()
     *  @brief      fade in selected components to viewTwo
     *  @details    used to illustrate multi-step fades
     */
    /********************************************************************************************************************************/
    func fadeInViewTwoComponents() {

        UIView.animate(withDuration: 1, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.viewTwo.fadingView.alpha = 1.0;
            if(verbose) { print("ViewController.fadeInVwTwoComp():   fade in begin"); }
        }, completion: { (finished: Bool) -> Void in
            
            if(verbose) { print("ViewController.fadeInVwTwoComp():   fade in complet"); }
            self.fadeOutViewTwoComponents();                            /* fade out on completion                                   */
        });
        
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        fadeOutViewTwoComponents()
     *  @brief      fade out selected components from viewTwo
     *  @details    called from fadeInViewTwoComponents on completion
     */
    /********************************************************************************************************************************/
    func fadeOutViewTwoComponents() {
        
        UIView.animate(withDuration: 1, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
            self.viewTwo.fadingView.alpha = 0.0;
        if(verbose) { print("ViewController.fadeOutVwTwoComp():  fade out begin"); }
        }, completion: { (finished: Bool) -> Void in
            if(verbose) { print("ViewController.fadeOutVwTwoComp():  fade out complete"); }
        });
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        loadPopup(_ dir : Bool)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func loadPopup(_ dir : Bool) {

        if(dir == true) {
            self.view.addSubview(self.popupView);

            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                if(verbose) { print("ViewController.loadPopup():         sliding popup in"); }
                self.popupView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-self.popupHeight, width: self.view.frame.width, height: self.popupHeight);
            
                }, completion: { (finished: Bool) -> Void in
                    if(verbose) { print("ViewController.loadPopup():         sliding popup in completion"); }
                    self.viewOne.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height);
            });
        } else {
            if(verbose) { print("ViewController.loadPopup():         off"); }
            UIView.animate(withDuration: 0.5, delay: 0.5, options: UIViewAnimationOptions.transitionCrossDissolve, animations: {
                if(verbose) { print("ViewController.loadPopup():         sliding popup out"); }
                self.viewOne.frame = UIScreen.main.bounds;
                self.popupView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: self.view.frame.width, height: self.popupHeight);
                
                }, completion: { (finished: Bool) -> Void in
                    if(verbose) { print("ViewController.loadPopup():         sliding popup out completion"); }
            });
        }
        
        return;
    }


    /********************************************************************************************************************************/
    /** @fcn        add_primary_tapResponse()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func add_primary_tapResponse() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.mainTapResp(_:)));
        
        tapGesture.delegate = self;
        
        self.view.addGestureRecognizer(tapGesture);
        
        add_popup_tapResponse();
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        add_popup_tapResponse()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func add_popup_tapResponse() {
        
        let pop_tapGesture = UITapGestureRecognizer(target: self, action: #selector(ViewController.popupResp(_:)));
        
        pop_tapGesture.delegate = self;
        
        popupView.addGestureRecognizer(pop_tapGesture);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        addLabel(_ aView: UIView, dispStr : String, yCoord : CGFloat)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
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
    
    
    /********************************************************************************************************************************/
    /** @fcn        addSubviewButton(_ aView: UIView, return_msg: String, action_fcn : Selector)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addSubviewButton(_ aView: UIView, return_msg: String, action_fcn : Selector) {
        
        let newButton : UIButton = UIButton(type: UIButtonType.roundedRect);
        
        newButton.translatesAutoresizingMaskIntoConstraints = true;                     /* must be true for center to work          */
        
        newButton.setTitle(return_msg,      for: UIControlState());
        newButton.backgroundColor = UIColor.white;
        
        newButton.sizeToFit();
        newButton.center = CGPoint(x: (UIScreen.main.bounds.width)/2, y: 250);    /* must call after it's sized or won't work!*/
        newButton.frame = nudgeTextFrame(newButton.frame, width_expand: 10);
        
        //Actions
        newButton.addTarget(self, action: action_fcn, for:  .touchUpInside);
        
        //Add to view
        aView.addSubview(newButton);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        addScrollViewButton(_ aView: UIView, return_msg: String, action_fcn : Selector)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addScrollViewButton(_ aView: UIView, return_msg: String, action_fcn : Selector) {
        
        let newButton : UIButton = UIButton(type: UIButtonType.roundedRect);
        
        newButton.translatesAutoresizingMaskIntoConstraints = true;                 /* must be true for center to work              */
        
        newButton.setTitle(return_msg,      for: UIControlState());
        newButton.backgroundColor = UIColor.white;
        
        newButton.sizeToFit();
        newButton.center = CGPoint(x: (UIScreen.main.bounds.width)/2, y: 500);      /* must call after it's sized or won't work!    */
        newButton.frame = nudgeTextFrame(newButton.frame, width_expand: 20);
        
        //Actions
        newButton.addTarget(self, action: action_fcn, for:  .touchUpInside);
        
        //Add to view
        aView.addSubview(newButton);
        
        return;
    }
    

    /********************************************************************************************************************************/
    /** @fcn        addPopupViewButton(_ aView: UIView, return_msg: String, action_fcn : Selector)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    func addPopupViewButton(_ aView: UIView, return_msg: String, action_fcn : Selector) {
        
        let newButton : UIButton = UIButton(type: UIButtonType.roundedRect);
        
        newButton.translatesAutoresizingMaskIntoConstraints = true;                 /* must be true for center to work             */
        
        newButton.setTitle(return_msg,      for: UIControlState());
        newButton.backgroundColor = UIColor.white;
        
        newButton.sizeToFit();
        newButton.center = CGPoint(x: (UIScreen.main.bounds.width)/2, y: 600);     /* must call after it's sized or won't work!    */
        newButton.frame = nudgeTextFrame(newButton.frame, width_expand: 20);
        
        //Actions
        newButton.addTarget(self, action: action_fcn, for:  .touchUpInside);
        
        //Add to view
        aView.addSubview(newButton);
        
        return;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        nudgeTextFrame(_ origFrame : CGRect, width_expand : CGFloat) -> CGRect
     *  @brief      nudge the width of a text button's frame to fit the text
     *  @details    x
     */
    /********************************************************************************************************************************/
    func nudgeTextFrame(_ origFrame : CGRect, width_expand : CGFloat) -> CGRect {

        let size : CGFloat = origFrame.width + width_expand;
        
        let newFrame : CGRect = CGRect(x: origFrame.origin.x - (width_expand/2), y: origFrame.origin.y, width: size, height: origFrame.height);
        
        return newFrame;
    }

    
    /********************************************************************************************************************************/
    /** @fcn        mainTapResp(_ sender: UITapGestureRecognizer)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func mainTapResp(_ sender: UITapGestureRecognizer) {
        if(verbose) { print("ViewController.mainTapResp():       primary view was tapped"); }
        //let tappedView = sender.view as UIView!;
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        myPrimaryTapResponse2(_ sender: UITapGestureRecognizer)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func popupResp(_ sender: UITapGestureRecognizer) {
        if(verbose) { print("ViewController.popupResp():         popupview selected, dismissing"); }
        
        loadPopup(false);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        press_launch(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func press_launch(_ sender: UIButton!) {

        if(verbose) { print("ViewController.press_launch():      \(sender.titleLabel!.text!) was pressed and press_launch called"); }
        
        pick_view(2);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        press_scrollLaunch(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func press_scrollLaunch(_ sender: UIButton!) {

        if(verbose) { print("ViewController.press_scrollLnch():  Scroll launch was pressed and view launched"); }
        
        pick_view(3);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        press_return(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func press_return(_ sender: UIButton!) {
        
        if(verbose) { print("ViewController.press_return():      \(sender.titleLabel!.text!) was pressed and press_return called"); }
        
        pick_view(1);
        
        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        press_popupLaunch(_ sender: UIButton!)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    @objc func press_popupLaunch(_ sender: UIButton!) {
        
        if(verbose) { print("ViewController.press_popupLaunch(): popup launch was pressed"); }
        
        loadPopup(true);

        return;
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        didReceiveMemoryWarning()
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
}


//**********************************************************************************************************************************//
/**@class   ViewTwo
 * @brief   showing fade start on entry, not load!                                                                                */
//**********************************************************************************************************************************//
class ViewTwo : UIView {
    
    //UI
    var fadingView : UIView;
    
    //Const
    let fadeDur_sec = 1;
    
    /********************************************************************************************************************************/
    /** @fcn        override init(frame: CGRect)
     *  @brief      x
     *  @details    x
     */
    /********************************************************************************************************************************/
    override init(frame: CGRect) {
        
        fadingView = UIView(frame: CGRect(x: (UIScreen.main.bounds.width/2-75), y: 135, width: 150, height: 75));
        fadingView.backgroundColor = UIColor.darkGray;
        fadingView.alpha = 0.0;                                         /* init hidden                                              */
        
        super.init(frame:frame);
        
        addSubview(fadingView);
        
        return;
        
    }
    
    
    /********************************************************************************************************************************/
    /** @fcn        required init?(coder aDecoder: NSCoder)
     *  @brief      x                                                                                                               */
    /********************************************************************************************************************************/
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented"); }
}

