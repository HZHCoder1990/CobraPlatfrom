//
//  CBPBaseView.swift
//  CobraPlatform
//
//  Created by mac on 2024/7/4.
//

import UIKit

class CBPBaseView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CBPBaseView {
    
    @objc
    public func setupSubViews() {
        
    }
}
