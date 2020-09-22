//
//  SettingsLauncher.swift
//  youtube
//
//  Created by Humza Munir on 9/22/20.
//  Copyright © 2020 Humza Munir. All rights reserved.
//

import UIKit

class Setting: NSObject {
    let name: String?
    let imageName: String?
    
    init(name: String, imageName: String) {
        self.name = name
        self.imageName = imageName
    }
}

let settings: [Setting] = {
    return [Setting(name: "Setting", imageName: "gear"),
            Setting(name: "Privacy Policy", imageName: "lock"),
            Setting(name: "Send Feedback", imageName: "flag"),
            Setting(name: "Change Account", imageName: "person.crop.circle"),
            Setting(name: "Help", imageName: "hand.raised"),
            Setting(name: "Close", imageName: "xmark")]
}()

class SettingsLauncher: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        
        let setting = settings[indexPath.item]
        cell.setting = setting
        
        return cell
    }
    
    
    let blackView = UIView()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        return cv
    }()
       
    @objc func showSettings() {
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: CGFloat(50 * settings.count + 20))
            blackView.frame = window.frame
            blackView.alpha = 0
           
            blackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleDismiss)))
            
            UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
                self.blackView.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y:         window.frame.height-CGFloat(50 * settings.count + 20), width: self.collectionView.frame.width, height: CGFloat(50 * settings.count + 20))
                
            }, completion: nil)
        }
    }
   
    @objc func handleDismiss() {
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, animations: {
            self.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: CGFloat(50 * settings.count + 20))
            }
       })
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectionView.frame.width, height: 50)
    }

    override init() {
        super.init()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
}
