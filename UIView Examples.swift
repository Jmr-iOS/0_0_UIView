/************************************************************************************************************************************/
/** @file       UIView Examples.swift
 *  @project    examples stored for quick access
 *  @brief      x
 *  @details    x
 *
 *  @section    Examples
 *      basic view          initBaseView()
 *      custom view class   CustomView.init()
 *      scroll view         ViewController.genScrollView()
 *      popup view          ViewController.genPopup()
 *      borders             UIKitExtens.setBorder()
 *      fade                ViewController.fadeOutViewTwoComponents()
 *
 *  @section    Opens
 *      none listed
 *
 *  @section    Legal Disclaimer
 *      All contents of this source file and/or any other Jaostech related source files are the explicit property on Jaostech
 *      Corporation. Do not distribute. Do not copy.
 */
/************************************************************************************************************************************/
import UIKit


/********************************************************************************************************************************/
/** @fcn        initBaseView() -> UIView
 *  @brief      initialize a basic UIVew fullscreen
 *  @details    fresh and simple for quick cut 'n paste
 */
/********************************************************************************************************************************/
func initBaseView() -> UIView {
    
    let view : UIView = UIView(frame: UIScreen.main.bounds);
    view.backgroundColor = UIColor.lightGray;
    
    return view;
}


/********************************************************************************************************************************/
/** @fcn        setOrientation(orientation : UIInterfaceOrientation)
 *  @brief      set orientation
 *  @details    x
 *
 *  @section    Orientation Options
 *      .unknown
 *      .portrait
 *      .portraitUpsideDown
 *      .landscapeLeft
 *      .landscapeRight
 */
/********************************************************************************************************************************/
func setOrientation(orientation : UIInterfaceOrientation) {
    UIDevice.current.setValue(orientation.rawValue, forKey: "orientation");
    return;
}

