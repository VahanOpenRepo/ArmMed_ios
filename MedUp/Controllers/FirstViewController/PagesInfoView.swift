//
//  PagesInfoView.swift
//  UAE TRA
//
//  Created by Vahe Makaryan on 12/29/20.
//

import UIKit
import ViewModel

final class PagesInfoView: UIView {

    private let infoScrollView = UIScrollView()
    private let pageControl = UIPageControl()
    private let pageControllerHeight: CGFloat = 50
    private var infoViewModels: [InfoViewModel]?
     
    var selectedPage: Int {
        pageControl.currentPage
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        infoScrollView.contentSize = CGSize(width: (infoViewModels?.count ?? 0)  * Int(self.frame.size.width), height: Int(infoScrollView.frame.size.height))
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupInfoView()
    }
    
    func configWith(infoModels: [InfoViewModel]) {
        infoViewModels = infoModels
    }

    // MARK: - Private Methods
    private func setUp() {
        pageControl.currentPageIndicatorTintColor = UIColor.blue
        pageControl.isUserInteractionEnabled = false
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        infoScrollView.backgroundColor = .clear
        infoScrollView.delegate = self
        infoScrollView.isPagingEnabled = true
        infoScrollView.showsHorizontalScrollIndicator = false
        self.insert(subview: infoScrollView, atIndex: 0, with: UIEdgeInsets(top: 0, left: 0, bottom: 35, right: 0))
    }

    private func setupInfoView() {

        for i in 0..<(infoViewModels?.count ?? 0) {
            guard let infoModel = infoViewModels?[i] else { return }
            let currenView = InfoView()
            currenView.configure(with: infoModel)
            currenView.frame = infoScrollView.bounds

            let width = UIScreen.main.bounds.width
            currenView.backgroundColor = .yellow
            let xPosition = width * CGFloat(i)
            currenView.frame = CGRect(x: xPosition, y: 0, width: width, height: currenView.frame.height)
            infoScrollView.addSubview(currenView)
        
        }
        pageControl.numberOfPages = infoViewModels?.count ?? 0
        self.insert(subview: pageControl, atIndex: 1, with: UIEdgeInsets(top: infoScrollView.bounds.height - pageControllerHeight, left: 0, bottom: 0, right: 0))
    }
    
    func selectNextPage() {
        pageControl.currentPage = pageControl.currentPage + 1
        infoScrollView.scrollTo(horizontalPage: pageControl.currentPage, verticalPage: 0, animated: true)
    }

}

extension PagesInfoView: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.size.width
        guard !(page.isNaN || page.isInfinite) else {
            return //"illegal value" // or do some error handling
        }
        pageControl.currentPage = Int(page)
    }
}
