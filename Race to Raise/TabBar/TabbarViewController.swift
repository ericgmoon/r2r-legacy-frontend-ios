//
//  TabbarViewController.swift
//  Canon
//
//  Created by Infield Infotech on 4/1/19.
//  Copyright © 2019 Infield Infotech. All rights reserved.
//

import UIKit
var tabIndex:Int = 1

class TabbarViewController: UIView {

    @IBOutlet var tabbarBgView: UIView!
    @IBOutlet var homeBTN: UIButton!
    @IBOutlet var profileBTN: UIButton!
    @IBOutlet var settingBTN: UIButton!
    @IBOutlet var homeImg: UIImageView!
    @IBOutlet var profileImg: UIImageView!
    @IBOutlet var settingImg: UIImageView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let _ = loadViewFromXib()
        tabbarBgView.layer.cornerRadius = 10
        homeImg.image = UIImage(named: "home")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        homeImg.tintColor = blackColor
        profileImg.image = UIImage(named: "profile")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        profileImg.tintColor = blackColor
        settingImg.image = UIImage(named: "leaderboard")!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        settingImg.tintColor = blackColor
        changeTabTitleColorAndImageColor(ItemIndex:tabIndex)
    }

    
    
    @IBAction func allTabBTNActions(_ sender: Any) {
        switch (sender as AnyObject).tag {
        case 101:
            tabIndex = 1
            NotificationCenter.default.post(name: Notification.Name("NextControllerForTab"), object: "home")
            changeTabTitleColorAndImageColor(ItemIndex:1)
         break
        case 102:
            tabIndex = 2
           NotificationCenter.default.post(name: Notification.Name("NextControllerForTab"), object: "profile")
           changeTabTitleColorAndImageColor(ItemIndex:2)
            break
        case 103:
            tabIndex = 3
            NotificationCenter.default.post(name: Notification.Name("NextControllerForTab"), object: "leaderboard")
            changeTabTitleColorAndImageColor(ItemIndex:3)
            break
        default:
            break
        }
    }
    func changeTabTitleColorAndImageColor(ItemIndex:Int) {
        if ItemIndex == 1 {
            homeImg.tintColor = headerColor
            profileImg.tintColor = UIColor.white
            settingImg.tintColor = UIColor.white
            homeBTN.setTitleColor(headerColor, for: .normal)
            profileBTN.setTitleColor(UIColor.white, for: .normal)
            settingBTN.setTitleColor(UIColor.white, for: .normal)
        }else if ItemIndex == 2 {
            homeImg.tintColor = UIColor.white
            profileImg.tintColor = headerColor
            settingImg.tintColor = UIColor.white
            homeBTN.setTitleColor(UIColor.white, for: .normal)
            profileBTN.setTitleColor(headerColor, for: .normal)
            settingBTN.setTitleColor(UIColor.white, for: .normal)
        }else if ItemIndex == 3 {
            homeImg.tintColor = UIColor.white
            profileImg.tintColor = UIColor.white
            settingImg.tintColor = headerColor
            homeBTN.setTitleColor(UIColor.white, for: .normal)
            profileBTN.setTitleColor(UIColor.white, for: .normal)
            settingBTN.setTitleColor(headerColor, for: .normal)
        }
    }
    func loadViewFromXib() -> UIView {
        let bundle = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "TabbarViewController", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        return view
    }
}
