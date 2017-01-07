//
//  OnboardingPager.swift
//  MyVoice
//
//  Created by Tobiasz Dobrowolski on 04.01.2017.
//  Copyright © 2017 Infinite. All rights reserved.
//

import UIKit

class OnboardingPager: UIPageViewController {

    func getStepZero() -> StepZero {
        return storyboard!.instantiateViewController(withIdentifier: "StepZero") as! StepZero
    }
    
    func getStepTwo() -> StepTwo {
        return storyboard!.instantiateViewController(withIdentifier: "StepTwo") as! StepTwo
    }
    
    func getStepThree() -> StepThree {
        return storyboard!.instantiateViewController(withIdentifier: "StepThree") as! StepThree
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .darkGray
        dataSource = self
        setViewControllers([getStepZero()], direction: .forward, animated: false, completion: nil)
    }

}

extension OnboardingPager : UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if viewController is StepThree {
            return getStepTwo()
        } else if viewController is StepTwo {
            return getStepZero()
        } else {
            return nil
        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if viewController is StepZero {
            return getStepTwo()
        } else if viewController is StepTwo {
            return getStepThree()
        } else {
            return nil
        }
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 3
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
}
