//
//  Video.swift
//  youtube
//
//  Created by Humza Munir on 9/17/20.
//  Copyright © 2020 Humza Munir. All rights reserved.
//

import UIKit

class Video: NSObject {
    
    var thumbnailImage: String?
    var title: String?
    var numberOfViews: Int?
    
    var channel: Channel?
    
}

class Channel: NSObject {
    var name: String?
    var profileImageName: String?
}
