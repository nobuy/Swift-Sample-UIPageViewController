//
//  ViewController.swift
//  Swift-Sample-UIPageViewController
//
//  Created by A10 Lab Inc. 003 on 2018/04/15.
//  Copyright © 2018年 A10 Lab Inc. 003. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    private var pageViewController: UIPageViewController?

    private let dataItems: [DataItem]

    init(items: [DataItem]) {
        self.dataItems = items
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        dataItems = []
        super.init(coder: aDecoder)
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)

        let vc = DataViewController(item: dataItems.last!)
        switch dataItems.count {
        case 0: fallthrough
        case 1:
            vc.rightButton.isHidden = true
            vc.leftButton.isHidden = true
        default:
            vc.rightButton.isHidden = true
        }
        vc.delegate = self
        let viewControllers = [vc]
        pageViewController!.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)

        pageViewController?.dataSource = self

        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)

        pageViewController!.view.frame = view.bounds
        pageViewController!.didMove(toParentViewController: self)
    }
}

extension RootViewController {

    private func viewControllerAtIndex(_ index: Int) -> DataViewController? {
        if (dataItems.count == 0) || (index >= dataItems.count) { return nil }
        return DataViewController(item: dataItems[index])
    }

    private func indexOfViewController(_ viewController: DataViewController) -> Int {
        return dataItems.index(where: { return $0.title == viewController.item.title }) ?? NSNotFound
    }
}

// MARK: DataViewControllerDelegate

extension RootViewController: DataViewControllerDelegate {

    func onLeftButtonTapped(_ vc: DataViewController) {
        var index = indexOfViewController(vc)
        if (index == 0) || (index == NSNotFound) { return }
        index -= 1
        guard let vc = viewControllerAtIndex(index) else { return }
        vc.delegate = self
        if index == 0 { vc.leftButton.isHidden = true }
        pageViewController?.setViewControllers([vc], direction: .reverse, animated: true, completion: nil)
    }

    func onRightButtonTapped(_ vc: DataViewController) {
        var index = indexOfViewController(vc)
        if index == NSNotFound { return }
        index += 1
        guard let vc = viewControllerAtIndex(index) else { return }
        vc.delegate = self
        if index == dataItems.count - 1 { vc.rightButton.isHidden = true }
        pageViewController?.setViewControllers([vc], direction: .forward, animated: true, completion: nil)
    }
}

// MARK: UIPageViewControllerDataSource

extension RootViewController: UIPageViewControllerDataSource {

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! DataViewController)
        if (index == 0) || (index == NSNotFound) { return nil }
        index -= 1
        let vc = viewControllerAtIndex(index)
        vc?.delegate = self
        if index == 0 { vc?.leftButton.isHidden = true }
        return vc
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = indexOfViewController(viewController as! DataViewController)
        if index == NSNotFound { return nil }
        index += 1
        if index == dataItems.count { return nil }
        let vc = viewControllerAtIndex(index)
        vc?.delegate = self
        if index == dataItems.count - 1 { vc?.rightButton.isHidden = true }
        return vc
    }
}
