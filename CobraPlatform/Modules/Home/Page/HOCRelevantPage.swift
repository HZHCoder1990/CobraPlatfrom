
import UIKit
import Hero
class HOCRelevantPage: CBPBasePage {
    
    
    private lazy var avatar: UIImageView = {
        let avatar = UIImageView(frame: CGRectMake(80, 100, 80, 80))
        avatar.layer.cornerRadius = 40
        avatar.layer.masksToBounds = true
        avatar.hero.id = "tagView"
        avatar.image = UIImage(named: "avatar")
        return avatar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(avatar)
    }
}
