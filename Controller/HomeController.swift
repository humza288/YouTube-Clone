//
//  ViewController.swift
//  youtube
//
//  Created by Humza Munir on 9/17/20.
//  Copyright © 2020 Humza Munir. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video] = {
        var videoOne = Video()
        videoOne.title = "Ice Cream - (Ft. Selena Gomez)"
        videoOne.thumbnailImage = "icecream"
           
        var videoTwo = Video()
        videoTwo.title = "DDU-DU DDU-DU"
        videoTwo.thumbnailImage = "dudu"
        
        var videoThree = Video()
        videoThree.title = "Kill This Love"
        videoThree.thumbnailImage = "killthis"
        
        var videoFour = Video()
        videoFour.title = "AS IF IT'S YOUR LAST"
        videoFour.thumbnailImage = "asifitsyourlast"
        
        return [videoOne, videoTwo, videoThree, videoFour]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        
        titleLabel.text = "Home"
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.white
        
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        
        setupMenuBar()
        setupNavBarButton()
    }
    
    func setupNavBarButton() {
        let searchImage = UIImage(systemName: "magnifyingglass")
        let searchBarButtonIcon = UIBarButtonItem(image: searchImage, style: .plain,
                                        target: self, action: #selector(handleSearch))
        let moreImage = UIImage(systemName: "ellipsis")
        let moreButtonIcon = UIBarButtonItem(image: moreImage, style: .plain,
                                               target: self, action: #selector(handleMore))
        
        navigationItem.rightBarButtonItems = [moreButtonIcon, searchBarButtonIcon]
    }
    
    @objc func handleSearch() {
        print("Searching...")
    }
    
    @objc func handleMore() {
        print("More menu...")
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat(format: "V:|[v0(50)]", views: menuBar)
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos[indexPath.item]
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let height = (view.frame.width - 16 - 16) * 9 / 16
        
        return CGSize(width: view.frame.width, height: height + 16 + 68)
    }

}
