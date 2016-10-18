//
//  SettingsLauncher.swift
//  Youtube-Clone
//
//  Created by SimpuMind on 10/17/16.
//  Copyright © 2016 SimpuMind. All rights reserved.
//

import UIKit

class Settings: NSObject{
    let name: SettingsName
    let imageName: String
    
    init(name: SettingsName, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

enum SettingsName: String{
    case Cancel = "Cancel"
    case Settings = "Settings"
    case Help = "Help"
    case Switch = "Switch Account"
    case Terms = "Terms and privacy policy"
    case Feedback = "Send Feedback"
}

class SettingsLauncher: NSObject, UICollectionViewDelegate,
        UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
       
        let layout = UICollectionViewFlowLayout()
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
        
    }()
    
    let cellId = "cellId"
    let cellHeight: CGFloat = 50
    
    let settings: [Settings] = {
       return [Settings(name: .Settings, imageName: "settings"),
               Settings(name: .Terms, imageName: "privacy"),
                Settings(name: .Feedback, imageName: "feedback"),
                Settings(name: .Help, imageName: "help"),
                Settings(name: .Switch, imageName: "switch_account"),
                Settings(name: .Cancel, imageName: "cancel")]
    }()
    
    var homeController: HomeController?
    
    func showSettings(){
        //show menu
        if let window = UIApplication.shared.keyWindow{
            
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            window.addSubview(blackView)
            window.addSubview(collectionView)
            
            let height: CGFloat = CGFloat(settings.count) * cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
                
                }, completion: nil)
            
        }
        
    }
    
    func handleDismiss(setting: Settings){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackView.alpha = 0
            
            if let window = UIApplication.shared.keyWindow{
                self.collectionView.frame = CGRect(x: 0, y:
                    window.frame.height, width:
                    self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            let setting = setting
            if setting.name != .Cancel{
                self.homeController?.showControllerForSetting(setting: setting)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let setting = settings[indexPath.item]
        handleDismiss(setting: setting)
    }
    
    override init(){
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
