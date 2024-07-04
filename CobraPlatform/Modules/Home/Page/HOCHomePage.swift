//
//  HOCHomePage.swift
//  CobraPlatform
//
//  Created by mac on 2024/7/4.
//

import UIKit
import DBSphereTagCloudSwift

class HOCHomePage: CBPBasePage {
    
    
    // MARK: - lazy load
    
    private lazy var sphereView: DBSphereView = {
        let margin = 15.0
        let sphereWidth = SCREEN_WIDTH - 2 * margin
        let sphereHeight = sphereWidth
        let sphereView = DBSphereView(frame: CGRectMake(margin, 100, sphereWidth, sphereHeight))
        return sphereView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sphereView.timerStart()
    }
    
}

extension HOCHomePage {
    
    private func setupUI() {
        
        var array = [HOCCloudTagView]()
        
        for _ in 1..<40 {
            let tagView = HOCCloudTagView()
            tagView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
            tagView.touchedHandler = {
                self.sphereView.timerStop()
                // 放大动画
                UIView.animate(withDuration: 0.3) {
                    tagView.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
                } completion: { _ in
                    UIView.animate(withDuration: 0.3, animations: {
                        tagView.transform = CGAffineTransformIdentity
                    }, completion: { _ in
//                        self.sphereView.timerStart()
                        let relevantPage = HOCRelevantPage()
                        self.navigationController?.pushViewController(relevantPage, animated: true)
                    })
                }
            }
            array.append(tagView)
            sphereView.addSubview(tagView)
        }
        
        sphereView.setCloudTags(array)
        view.addSubview(sphereView)
    }
}
