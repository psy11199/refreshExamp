//
//  HankookNfcViewController.swift
//  SnappyWireExamp
//
//  Created by 김성남 on 2018. 9. 11..
//  Copyright © 2018년 김성남. All rights reserved.
//

import UIKit

class HankookNfcViewController: UIViewController {
  //-------------------------------------------------------------------------------------------
  // MARK: - IBOutlets
  //-------------------------------------------------------------------------------------------
  
  //-------------------------------------------------------------------------------------------
  // MARK: - Local Variables
  //-------------------------------------------------------------------------------------------
  var appDelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.layoutIfNeeded()
    self.view.setNeedsLayout()
    self.initLayout()
    self.initRequest()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
  }
  
  override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func initLayout() {
    
  }
  
  func initRequest() {
    
  }
  //-------------------------------------------------------------------------------------------
  // MARK: - Local method
  //-------------------------------------------------------------------------------------------
  /**------------------------------------------------------------------------------------------
   * @ Method : coverNavigationController
   * @ Description : [공통] 뷰컨트롤러를 네비게이션 컨트롤러의 루트로 만들어준다.
   * @ Parameters : UIBarButtonItem
   * @ Returns : nil
   -------------------------------------------------------------------------------------------*/
  func coverNavigationController() -> UINavigationController {
    return UINavigationController(rootViewController: self)
  }
  
  //-------------------------------------------------------------------------------------------
  // MARK: - IBAction
  //-------------------------------------------------------------------------------------------
  /**------------------------------------------------------------------------------------------
   * @ Method : backButtonTouched
   * @ Description : [공통] 뒤로가기 버튼 터치
   * @ Parameters : UIBarButtonItem
   * @ Returns : nil
   -------------------------------------------------------------------------------------------*/
  @IBAction func backButtonTouched(sender: UIBarButtonItem) {
    self.view.endEditing(true)
    if let navigation = self.navigationController {
      if navigation.viewControllers.count == 1 {
        self.dismiss(animated: true, completion: nil)
      } else {
        navigation.popViewController(animated: true)
      }
    } else {
      self.dismiss(animated: true, completion: nil)
    }
  }
}


//-------------------------------------------------------------------------------------------
// MARK: - StoryBoardHelper
//-------------------------------------------------------------------------------------------
extension NSObject {
  public var className: String {
    return type(of: self).className
  }
  
  public static var className: String {
    return String(describing: self)
  }
}

protocol StoryBoardHelper {}
extension UIViewController: StoryBoardHelper {}
extension StoryBoardHelper where Self: UIViewController {
  static func instantiate() -> Self {
    let storyboard = UIStoryboard(name: self.className, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
  }
  
  static func instantiate(storyboard: String) -> Self {
    let storyboard = UIStoryboard(name: storyboard, bundle: nil)
    return storyboard.instantiateViewController(withIdentifier: self.className) as! Self
  }
}
//-------------------------------------------------------------------------------------------*/


extension UIView {
  public func setCornerRadius(radius: CGFloat) {
    self.layer.cornerRadius = radius
    self.layer.masksToBounds = true
  }
  
  public func addBorder(width: CGFloat, color: UIColor) {
    layer.borderWidth = width
    layer.borderColor = color.cgColor
    layer.masksToBounds = true
  }
  
  public func addShadow(offset: CGSize, radius: CGFloat, color: UIColor, opacity: Float, cornerRadius: CGFloat? = nil) {
    self.layer.shadowOffset = offset
    self.layer.shadowRadius = radius
    self.layer.shadowOpacity = opacity
    self.layer.shadowColor = color.cgColor
    if let r = cornerRadius {
      self.layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: r).cgPath
    }
  }
  
  public func addTapGesture(tapNumber: Int = 1, target: AnyObject, action: Selector) {
    let tap = UITapGestureRecognizer(target: target, action: action)
    tap.numberOfTapsRequired = tapNumber
    addGestureRecognizer(tap)
    isUserInteractionEnabled = true
  }
  
  public func addTapGesture(tapNumber: Int = 1, action: ((UITapGestureRecognizer) -> Void)?) {
    let tap = BlockTap(tapCount: tapNumber, fingerCount: 1, action: action)
    addGestureRecognizer(tap)
    isUserInteractionEnabled = true
  }
}

open class BlockTap: UITapGestureRecognizer {
  private var tapAction: ((UITapGestureRecognizer) -> Void)?
  
  public override init(target: Any?, action: Selector?) {
    super.init(target: target, action: action)
  }
  
  public convenience init (
    tapCount: Int = 1,
    fingerCount: Int = 1,
    action: ((UITapGestureRecognizer) -> Void)?) {
    self.init()
    self.numberOfTapsRequired = tapCount
    
    #if os(iOS)
    
    self.numberOfTouchesRequired = fingerCount
    
    #endif
    
    self.tapAction = action
    self.addTarget(self, action: #selector(BlockTap.didTap(_:)))
  }
  
  @objc open func didTap (_ tap: UITapGestureRecognizer) {
    tapAction? (tap)
  }
  
}


// tableView
extension UITableView {
  public func registerCell<T: UITableViewCell>(type: T.Type) {
    let className = type.className
    let nib = UINib(nibName: className, bundle: nil)
    register(nib, forCellReuseIdentifier: className)
  }
  
  public func registerCells<T: UITableViewCell>(types: [T.Type]) {
    types.forEach {
      registerCell(type: $0)
    }
  }
}

