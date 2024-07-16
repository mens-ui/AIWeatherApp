//
//  PageViewController.swift
//  AiWeatherApp
//
//  Created by 김윤홍 on 7/17/24.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate {
  
  private lazy var controllerArray = [MainViewController(), TestViewController()]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.delegate = self
    self.dataSource = self
    self.setViewControllers([controllerArray[0]], direction: .forward, animated: true)
  }
}

extension PageViewController: UIPageViewControllerDataSource {
  
  /// 이전 화면 만약 제스처를 왼쪽으로 스와이프 한다면?
  /// - Parameters:
  /// - Returns: 아래와 반대입니당!
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
    guard let index = controllerArray.firstIndex(of: viewController) else { return nil }
    
    guard index > 0 else { return nil }
    return controllerArray[index - 1]
  }
  
  /// 반대로 제스처를 오른쪽으로 스와이프한다면?
  /// - Parameters:
  ///   - pageViewController: 현재 뷰컨트롤러
  ///   - viewController: 아까와 달리 이거는 after사용되어있어서 다음페이지라는 거를 확인할 수 있음
  /// - Returns: page배열 증가
  /// 현재 뷰컨트롤러를 인덱스 값을 구한뒤 인덱스가 배열의 마지막 인덱스라면 nil리턴 하고 아니면 page증가
  func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
    guard let index = controllerArray.firstIndex(of: viewController) else { return nil }
    
    guard index < controllerArray.count - 1 else { return nil }
    return controllerArray[index + 1]
  }
}
