//
//  HOCCloudTagView.swift
//  CobraPlatform
//
//  Created by mac on 2024/7/4.
//

import UIKit

class HOCCloudTagView: CBPBaseView {
    
    var touchedHandler: (() -> Void)?
    
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView()
        avatar.image = UIImage(named: "avatar")
        avatar.layer.cornerRadius = 19.0
        avatar.layer.masksToBounds = true
        avatar.frame = CGRectMake(1, 1, 38, 38)
        return avatar
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .clear
        button.frame = CGRectMake(0, 0, 40, 40)
        return button
    }()

    override func setupSubViews() {
        
        layer.cornerRadius = 20.0
        backgroundColor = .red
    
        addSubview(avatar)
        addSubview(button)
       
        button.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc
    func click() {
        guard let touchedHandler = touchedHandler else { return  }
        touchedHandler()
        
    }
}
