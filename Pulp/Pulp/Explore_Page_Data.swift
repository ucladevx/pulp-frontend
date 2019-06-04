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
struct Location {
    var placeImage: String?
    var placeName: String?
    var placeCityState: String?
    var placeLocation: String?
    var placeType: String?
    var placeDescription: String?
    var placeRating: Double?
    var placeDistance: Double?
    var placeHours: Int?
    var fbfriends: [FBFriend]?
    
}


var reviewData: [Review] = [
Review(imageName: "Profile Photo", text: "You'll find tons of pedestrian walkways and bridges here that go between incredible homes and gardens"),
Review(imageName: "1", text: "The canals themselves offer great reflections of the palm tress poking up all over the neighborhood"),
    Review(imageName: "3", text: "Great free place for a date night or relaxing stroll"),
    Review(imageName: "4", text: "Great free place for a date night or relaxing stroll")
]

var FBFriendsData: [FBFriend] = [
FBFriend(imageName: "4"), FBFriend(imageName:"3" ), FBFriend(imageName: "Profile Photo"), FBFriend(imageName: "1")
]

var locationData: [Location] = [
    Location(placeImage: "Image", placeName: "Venice\nBeach Canals",placeCityState: "Los Angeles, California" ,placeLocation: "Venice Canals, Venice, CA", placeType: "Nature, Photo Ops",placeDescription:"The Venice Canal Historic District are great to capture during the day or at sunset." ,placeRating: 4.5,placeDistance: 1.2, placeHours: 24, fbfriends: FBFriendsData)
]
