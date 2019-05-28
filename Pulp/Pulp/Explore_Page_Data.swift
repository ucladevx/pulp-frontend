//
//  ReviewData.swift
//  Pulp
//
//  Created by Aryan Arora on 5/27/19.
//  Copyright © 2019 Andy Cai. All rights reserved.
//

import Foundation
import UIKit

struct Review {
    var imageName: String?
    var text: String?
    
}
struct FBFriend {
    var imageName: String?
}



var reviewData: [Review] = [
Review(imageName: "Profile Photo", text: "You'll find tons of pedestrian walkways and bridges here that go between incredible homes and gardens"),
Review(imageName: "1", text: "The canals themselves offer great reflections of the palm tress poking up all over the neighborhood"),
    Review(imageName: "3", text: "Great free place for a date night or relaxing stroll"),
    Review(imageName: "4", text: "Great free place for a date night or relaxing stroll")
]

var FBFriendsData: [FBFriend] = [
FBFriend(imageName: <#T##String?#>), 
]
