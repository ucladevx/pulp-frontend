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
//    Location(placeImage: "Image", placeName: "Venice\nBeach Canals",placeCityState: "Los Angeles, California" ,placeLocation: "Venice Canals, Venice, CA", placeType: "Nature, Photo Ops",placeDescription:"The Venice Canal Historic District are great to capture during the day or at sunset." ,placeRating: 4.5,placeDistance: 1.2, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage:"b1 (3)" , placeName: "Bottega Louie", placeCityState: "Los Angeles, Californa", placeLocation: "700 Grand Ave, Los Angeles", placeType: "Restaurant", placeDescription: "Pizzas, pastas & small plates in a bright, bustling space, plus weekend brunch & macarons to-go.", placeRating: 4.8, placeDistance: 0.8, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "yaletown1", placeName: "Izakaya & Bar Fu-ga", placeCityState: "Los Angeles, Californa", placeLocation: "111 San Pedro, Los Angeles", placeType: "Restaurant", placeDescription: "Modern Japanese small plates, steaks & sushi served in a contemporary space, plus happy-hour deals.", placeRating: 4.3, placeDistance: 1.2, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "25162570", placeName: "Redbird", placeCityState: "Los Angeles, Californa", placeLocation: "114 E 2nd St, Los Angeles", placeType: "Restaurant", placeDescription: "Innovative New American dishes are paired with creative cocktails & a snazzy, historic setting.", placeRating: 4.0, placeDistance: 7.3, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "IMG_0879", placeName: "Âu Lạc LA", placeCityState: "Los Angeles, Californa", placeLocation: "710 W 1st St, Los Angeles", placeType: "Restaurant", placeDescription: "Strip-mall eatery serving creative vegan fare with Asian influence in a serene dining room.", placeRating: 4.0, placeDistance: 5.7, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "LAX-johnny-rockets-le-gout-de-l-amerique-2_1-1024x512", placeName: "Johnny Rockets", placeCityState: "Los Angeles, Californa", placeLocation: "131 Central Ave, Los Angeles", placeType: "Restaurant", placeDescription: "Your classic American restaurant with family-friendly dancing, music and ketchup art.", placeRating: 3.9, placeDistance:0.4 , placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "20170816_191703", placeName: "Blacksmiths DTLA", placeCityState: "Los Angeles, Californa", placeLocation: "117 Winston St, Los Angeles", placeType: "Restaurant", placeDescription: "Downtowners dig the elevated comfort food & craft cocktails at this upscale eatery.", placeRating: 3.3, placeDistance: 1.6, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "orochon-ramen", placeName: "Orochon Ramen", placeCityState: "Los Angeles, Californa", placeLocation: "123 Onizuka St, Los Angeles", placeType: "Restaurant", placeDescription: "Small Japanese restaurant with a Wall of Fame for diners who can conquer the spiciest ramen bowl.", placeRating: 3.3, placeDistance: 1.9, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "50bca03140c4271ad960733b9197032d", placeName: "Kushi Shabu", placeCityState: "Los Angeles, Californa", placeLocation: "123 Onizuka St, Los Angeles", placeType: "Restaurant", placeDescription: "Casual eatery presenting a mix of traditional Japanese dishes from shabu to sushi.", placeRating: 3.0, placeDistance: 1.9, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "manuela-anne-fishbein", placeName: "Manuela", placeCityState: "Los Angeles, Californa", placeLocation: "907 E 3rd St, Los Angeles", placeType: "Restaurant", placeDescription: "All-day eatery for seasonal menus, cocktails & housegrown ingredients in a rustic-chic arts complex.", placeRating: 2, placeDistance: 10.5, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "DSC01580+DSC01574+DSC01559+DSC01568", placeName: "Bavel", placeCityState: "Los Angeles, Californa", placeLocation: "500 Mateo St, Los Angeles", placeType: "Restaurant", placeDescription: "Ori Menashe’s Middle Eastern follow-up to his always-packed Bestia, with a similar downtown vibe.", placeRating: 0.5, placeDistance: 15.5, placeHours: 24, fbfriends: FBFriendsData)
]
