//
//  DataViewController.swift
//  Swift-Sample-UIPageViewController
//
//  Created by A10 Lab Inc. 003 on 2018/04/15.
//  Copyright © 2018年 A10 Lab Inc. 003. All rights reserved.
//

import UIKit

protocol DataViewControllerDelegate: class {
    func onLeftButtonTapped(_ vc: DataViewController)
    func onRightButtonTapped(_ vc: DataViewController)
}

class DataViewController: UIViewController {

    weak var delegate: DataViewControllerDelegate?

    let item: DataItem

    private let topContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .brown
        return view
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .white
        return label
    }()

    let leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("back", for: UIControlState())
        return button
    }()

    let rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("next", for: UIControlState())
        return button
    }()

    init(item: DataItem) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        self.item = DataItem(title: "", color: .red)
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = item.color
        titleLabel.text = item.title
        leftButton.addTarget(self, action: #selector(self.onLeftButtonTapped), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(self.onRightButtonTapped), for: .touchUpInside)

        initView()
    }

    private func initView() {
        view.addSubview(topContainer)
        topContainer.addSubview(leftButton)
        topContainer.addSubview(titleLabel)
        topContainer.addSubview(rightButton)

        leftButton.translatesAutoresizingMaskIntoConstraints = false
        leftButton.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 10).isActive = true
        leftButton.leadingAnchor.constraint(equalTo: topContainer.leadingAnchor, constant: 10).isActive = true
        leftButton.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -10).isActive = true
        leftButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 10).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -10).isActive = true

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.topAnchor.constraint(equalTo: topContainer.topAnchor, constant: 10).isActive = true
        rightButton.trailingAnchor.constraint(equalTo: topContainer.trailingAnchor, constant: -10).isActive = true
        rightButton.bottomAnchor.constraint(equalTo: topContainer.bottomAnchor, constant: -10).isActive = true
        rightButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

        topContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        topContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        topContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        topContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc func onLeftButtonTapped(_ sender: UIButton) {
        delegate?.onLeftButtonTapped(self)
    }

    @objc func onRightButtonTapped(_ sender: UIButton) {
        delegate?.onRightButtonTapped(self)
    }
}
