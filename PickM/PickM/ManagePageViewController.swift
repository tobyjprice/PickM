 //
//  ManagePageViewController.swift
//  PickM
//
//  Created by Toby Price on 21/09/2016.
//  Copyright © 2016 Toby Price. All rights reserved.
//

import UIKit

class ManagePageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    let dayCount = eventDayCount //eventDat.stages.count
    
    var currentIndex: Int = 0
    var pendingIndex: Int?
    
    var allowSwipe = true
    
    var pages = [UIViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = self
        self.delegate = self
        
        for _ in 1...dayCount
        {
            let tempPage: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "PageContentController")
            self.pages.append(tempPage)
        }
        
        /*let page1: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "PageContentController")
        let page2: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "PageContentController")
        let page3: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "PageContentController")
        let page4: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "PageContentController")
        let page5: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "PageContentController")
        let page6: UIViewController! = storyboard?.instantiateViewController(withIdentifier: "PageContentController")
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        pages.append(page4)
        pages.append(page5)
        pages.append(page6)*/
        
        let tempPage = pages[0] as! FirstViewController
        //tempPage.eventData = eventDat
        tempPage.pageIndex = 0
        
        setViewControllers([pages[0]], direction: UIPageViewControllerNavigationDirection.forward, animated: false, completion: nil)
    }
    
    func setCustomView(viewIndex: Int) {
        if allowSwipe {
            let nextPage = pages[viewIndex] as! FirstViewController
            //nextPage.eventData = eventDat
            nextPage.pageIndex = viewIndex
            
            if viewIndex > currentIndex {
                setViewControllers([pages[viewIndex]], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
                currentIndex = viewIndex
            } else {
                setViewControllers([pages[viewIndex]], direction: UIPageViewControllerNavigationDirection.reverse, animated: true, completion: nil)
                currentIndex = viewIndex
            }

        }
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if allowSwipe {
            currentIndex = pages.index(of: viewController)!
            let previousIndex = currentIndex - 1
            if previousIndex >= 0 {
                let nextPage = pages[previousIndex] as! FirstViewController
                //nextPage.eventData = eventDat
                nextPage.pageIndex = previousIndex
                return pages[previousIndex]
            }

        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if allowSwipe {
            currentIndex = pages.index(of: viewController)!
            let nextIndex = currentIndex + 1
            if nextIndex < pages.count {
                let nextPage = pages[nextIndex] as! FirstViewController
                //nextPage.eventData = eventDat
                nextPage.pageIndex = nextIndex
                return pages[nextIndex]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        pendingIndex = pages.index(of: pendingViewControllers.first!)
        allowSwipe = false
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            // Move to a background thread to do some long running work
            DispatchQueue.global().async {
                let parentControl = self.parent as! MasterViewController
                if completed { if self.currentIndex <= self.dayCount {
                    self.currentIndex = self.pendingIndex!
                    }
                }
                // Bounce back to the main thread to update the UI
                DispatchQueue.main.async {
                    parentControl.updateControl(index: self.currentIndex)
                }
            }
            allowSwipe = true
        }
    }
    
    private func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

