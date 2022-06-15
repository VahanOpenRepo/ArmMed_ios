//
//  MainTabBarViewController.swift
//  MedUp
//
//  Created by Vahe Makaryan on 28.09.21.
//

import UIKit

struct TabBarItem {
    let controller: UIViewController
}

class MainTabBarViewModel {}

public class MainTabBarViewController: UITabBarController {

    private var tabbarViewControllerItems = [UIViewController]()

    private let tabBarHight: CGFloat = 66

    private let barItems: [TabBarItem]

    private let coordinator: TabBarCoordinator

    public override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureTabBar()
    }

    init(with coordinator: TabBarCoordinator, barItems: [TabBarItem], selectedItem: TabbarControllerItem? = nil) {
        self.barItems = barItems
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
        self.tabbarViewControllerItems = barItems.map { $0.controller }

        self.viewControllers = barItems.map { $0.controller }

        selectedIndex = (selectedItem ?? .patients).rawValue
    }

    public override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
        
        configureTabBar()
    }

    // MARK: - Actions

    private func configureTabBar() {
        tabBar.barTintColor = .white
        tabBar.tintColor = UIColor.systemBlue
        tabBar.backgroundImage = UIColor.clear.toImage()
        tabBar.shadowImage = UIImage()
        view.backgroundColor = .white
        let unselectedItem: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.white]
        let selectedItem: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor: UIColor.medBlue]

        tabBar.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
            $0.setTitleTextAttributes(unselectedItem, for: .normal)
            $0.setTitleTextAttributes(selectedItem, for: .selected)
        })

        tabBar.tintColor = .medBlue
        tabBar.unselectedItemTintColor = UIColor.tabColor
        setShadow()
    }

    private func setShadow() {
        let layer = CAShapeLayer()
        layer.name = "barShadow"
        layer.path = UIBezierPath(roundedRect: CGRect(x: 0, y: self.tabBar.bounds.minY, width: self.tabBar.bounds.width, height: self.tabBar.bounds.height + 10), cornerRadius: 0).cgPath

        let shadowColor = UIColor.lightGray.withAlphaComponent(0.6).cgColor
        layer.shadowColor = shadowColor

        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 10.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        tabBar.layer.sublayers?.forEach { if $0.name == "barShadow" { $0.removeFromSuperlayer() } }
        tabBar.layer.insertSublayer(layer, at: 0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        print("Tabbar Deinit")
    }
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    public override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {


    }

    public func tabBarController(_ tabBarController: UITabBarController,
                                 shouldSelect viewController: UIViewController) -> Bool {

        return true
    }
}

public extension UIColor {

    func toImage() -> UIImage? {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)

        guard let context = UIGraphicsGetCurrentContext() else { return nil }

        context.setFillColor(cgColor)
        context.fill(rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image
    }
}
