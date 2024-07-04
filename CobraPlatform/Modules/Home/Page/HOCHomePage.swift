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
        sphereView.backgroundColor = .clear
        return sphereView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        generateStarWallView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sphereView.timerStart()
    }
    
}

extension HOCHomePage {
    
    // 小星星背景
    private func generateStarWallView() {
        
        for _ in 1..<30 {
            // 生成小星星背景
            let starView = UIView()
            let starViewX = Double.random(in: 0.0...SCREEN_WIDTH)
            let starViewY = Double.random(in: 0.0...130)
            let starViewWH = Double.random(in: 1.0...5.0)
            starView.frame = CGRectMake(starViewX, starViewY, starViewWH, starViewWH)
            starView.backgroundColor = .gray
            starView.layer.shadowColor = UIColor.gray.cgColor
            starView.layer.shadowOffset = CGSize.zero
            starView.layer.shadowRadius = starViewWH * 0.5
            starView.layer.shadowOpacity = 0.8
            starView.layer.cornerRadius = starViewWH * 0.5
            starView.layer.zPosition = -100
            view.insertSubview(starView, belowSubview: sphereView)
            
            // 小星星闪烁动画
            let delayTime = Double.random(in: 0...10) / 10.0 + 0.5
            let duration = Double.random(in: 0...2) + 1
            let toValue = Double.random(in: 0...6) / 10.0
            let starOpacityAnim  = CABasicAnimation(keyPath: "opacity")
            starOpacityAnim.fromValue = 1.0
            starOpacityAnim.toValue = toValue
            starOpacityAnim.duration = duration
            starOpacityAnim.beginTime = delayTime
            starOpacityAnim.autoreverses = true
            starOpacityAnim.repeatCount = MAXFLOAT
            starOpacityAnim.isRemovedOnCompletion = false
            starOpacityAnim.fillMode = .forwards
            starOpacityAnim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            starView.layer.add(starOpacityAnim, forKey: nil)
        }
    }
}

extension HOCHomePage {
    
    private func setupUI() {
        
        var array = [HOCCloudTagView]()
        
        for _ in 1..<50 {
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
        
        // 添加两个测试按钮
        let stackView = UIStackView(frame: CGRectMake(15, CGRectGetMaxY(sphereView.frame) + 80, SCREEN_WIDTH - 30, 100))
        stackView.spacing = 10
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        view.addSubview(stackView)
        
        // 1.发射流星
        let startBtn = UIButton(type: .custom)
        startBtn.setTitle("流星效果", for: .normal)
        startBtn.layer.cornerRadius = 20
        startBtn.layer.masksToBounds = true
        startBtn.addTarget(self, action: #selector(launchRain), for: .touchUpInside)
        startBtn.backgroundColor = UIColor(colorHex: 0xff385c)
       
        // 2.模拟中奖效果
        let simulatorBtn = UIButton(type: .custom)
        simulatorBtn.setTitle("中奖效果", for: .normal)
        simulatorBtn.layer.cornerRadius = 20
        simulatorBtn.layer.masksToBounds = true
        simulatorBtn.backgroundColor = UIColor(colorHex: 0x35534d)
        
        stackView.addArrangedSubview(startBtn)
        stackView.addArrangedSubview(simulatorBtn)
    }
    
    // 背景
    
    
    @objc
    private func launchRain() {
        
        let rainEmitter = CAEmitterLayer()
        rainEmitter.emitterPosition = CGPointMake(SCREEN_WIDTH, 0)
//        rainEmitter.emitterSize = CGSize(width: SCREEN_WIDTH, height: 0)
        rainEmitter.birthRate = 1
        rainEmitter.emitterMode = .outline
        rainEmitter.emitterShape = .point
        rainEmitter.renderMode = .additive
        
        let rainFlake = CAEmitterCell()
        rainFlake.birthRate = 1
        rainFlake.velocity = 500.0
        rainFlake.velocityRange = 300.0
        rainFlake.yAcceleration = 0.0
        rainFlake.scale = 0.5
        rainFlake.scaleSpeed = 0.1
        rainFlake.lifetime = 2.5
       
        rainFlake.emissionLongitude = -.pi * 5 / 4
        rainFlake.emissionLatitude = 0
        rainFlake.emissionRange = 0  // 不允许偏差
        rainFlake.contents = UIImage(named: "star")?.cgImage
        rainFlake.color = UIColor(colorHex: 0xFFFFFF).cgColor
        
        rainEmitter.emitterDepth = 10.0
        rainEmitter.shadowOpacity = 0.0
        rainEmitter.shadowRadius = 0.0
        rainEmitter.emitterCells = [rainFlake]
        
        view.layer.insertSublayer(rainEmitter, below: sphereView.layer)
    }
}


