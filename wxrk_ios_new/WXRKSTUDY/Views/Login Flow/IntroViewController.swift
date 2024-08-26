//
//  IntroViewController.swift
//  WXRKSTUDY
//
//  Created by KaramjeetSingh on 01/08/22.
//

import UIKit

class IntroViewController: UIViewController, IntroViewDelegate {
    
    var FromDashboard = false

    var pages : [IntroView] {
        get {
            
            let page1 = IntroView.loadFromXib() as! IntroView
            page1.lblIntroTitle.text = "CXMMUNITY"
            page1.lblIntroDisc.text = "Earn the $MYX token for watching your favorite streamer. Yes, it’s really that simple!"
            page1.vwWorkGotIt.isHidden = true
            page1.imgCharacter.image = UIImage(named: "casual-life-3d-adult-carrying-girl-on-his-back.png")
            page1.btnSkip.setTitle("   SKIP   ", for: .normal)
            page1.delegate = self
            ///
            let page2 = IntroView.loadFromXib() as! IntroView
            page2.lblIntroTitle.text = "$MYX"
            page2.lblIntroDisc.text = "Trade the $MYX tokens you earn for rewards from your favorite companies in our marketplace!"
            page2.vwWorkGotIt.isHidden = true
            page2.imgCharacter.image = UIImage(named: "casual-life-3d-girl-and-man-reading-book-and-smiling.png")
            page2.btnSkip.setTitle("   SKIP   ", for: .normal)
            page2.delegate = self

            ///
            let page3 = IntroView.loadFromXib() as! IntroView
            page3.lblIntroTitle.text = "REWARDS"
            page3.lblIntroDisc.text = "You never know what rewards you’ll find, so stay engaged!"
            page3.vwWorkGotIt.isHidden = true
            page3.imgCharacter.image = UIImage(named: "casual-life-3d-girl-child-with-vr-glasses.png")
            page3.btnSkip.setTitle("   GET STARTED?   ", for: .normal)
            page3.delegate = self

            return [page1, page2, page3]
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageController: UIPageControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.bringSubviewToFront(pageController)
        setupScrollView(pages: pages)
        pageController.numberOfPages = pages.count
        pageController.currentPage = 0
    }
    
    func setupScrollView(pages: [IntroView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
        scrollView.contentSize = CGSize(width: view.frame.size.width * CGFloat(pages.count), height: view.frame.size.height)
        scrollView.isPagingEnabled = true
        for i in 0..<pages.count {
            pages[i].frame = CGRect(x: view.frame.size.width * CGFloat(i), y: 0, width: view.frame.size.width, height: view.frame.size.height)
            scrollView.addSubview(pages[i])
        }
    }
    func skip(action: String) {
        if FromDashboard == true {
            self.navigationController?.popViewController(animated: true)
        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as? TabBarViewController
            self.navigationController?.pushViewController(tabBarController!, animated: true)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension IntroViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageController.currentPage = Int(pageIndex)
    }
}
