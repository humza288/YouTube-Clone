//
//  ViewController.swift
//  youtube
//
//  Created by Humza Munir on 9/17/20.
//  Copyright © 2020 Humza Munir. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var videos: [Video]?
    
//    var videos: [Video] = {
//
//        var joeRoganChannel = Channel()
//        joeRoganChannel.name = "Joe Rogan Experience"
//        joeRoganChannel.profileImageName = "joeRoganProfile"
//
//        var blackPinkChannel = Channel()
//        blackPinkChannel.name = "BlackPink Vevo"
//        blackPinkChannel.profileImageName = "profile"
//
//        var videoOne = Video()
//        videoOne.title = "Ice Cream - (Ft. Selena Gomez)"
//        videoOne.thumbnailImage = "icecream"
//        videoOne.channel = blackPinkChannel
//        videoOne.numberOfViews = 42342234
//
//        var videoTwo = Video()
//        videoTwo.title = "DDU-DU DDU-DU"
//        videoTwo.thumbnailImage = "dudu"
//        videoTwo.channel = blackPinkChannel
//        videoTwo.numberOfViews = 43423343
////
////        var videoThree = Video()
////        videoThree.title = "Kill This Love"
////        videoThree.thumbnailImage = "killthis"
////        videoThree.channel = blackPinkChannel
////
////        var videoFour = Video()
////        videoFour.title = "AS IF IT'S YOUR LAST"
////        videoFour.thumbnailImage = "asifitsyourlast"
////        videoFour.channel = blackPinkChannel
////
//        var videoFive = Video()
//        videoFive.title = "Smoking with musk is the best thing ever"
//        videoFive.thumbnailImage = "joeroganone"
//        videoFive.channel = joeRoganChannel
//        videoFive.numberOfViews = 234234323
////
////        var videoSix = Video()
////        videoSix.title = "Trying DMT for the First Time"
////        videoSix.thumbnailImage = "joerogantwo"
////        videoSix.channel = joeRoganChannel
//
//        return [videoOne, videoTwo, videoFive]
////            , videoThree, videoFour, videoFive, videoSix]
//    }()
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")!
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
        
            if error != nil {
                print(error as Any)
                return
            }
            
            do {
                
                self.videos = [Video]()
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                
                for dictionary in json as! [[String: AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImage = dictionary["thumbnail_image_name"] as? String
                    
                    let channel = Channel()
                    let channelDict = dictionary["channel"] as? [String: AnyObject]
                    
                    channel.name = channelDict?["name"] as? String
                    channel.profileImageName = channelDict?["profile_image_name"] as? String
                    
                    video.channel = channel
 
                    self.videos?.append(video)
                }
            }
            
            catch let jsonError {
                print(jsonError)
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }).resume()
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
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
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        
        cell.video = videos?[indexPath.item]
                
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
