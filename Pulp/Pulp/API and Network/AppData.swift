//
//  AppData.swift
//  Pulp
//
//  Created by Aryan Arora on 1/20/20.
//  Copyright © 2020 Aryan Arora. All rights reserved.
//

import Foundation
import UIKit
var USERID = ""
var USER_Photo = ""
var defaultURL = USER_Photo 
var place_id = ""
var LoggedIn = false

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


//var reviewData: [Review] = [
//Review(imageName: "Profile Photo", text: "You'll find tons of pedestrian walkways and bridges here that go between incredible homes and gardens"),
//Review(imageName: "1", text: "The canals themselves offer great reflections of the palm tress poking up all over the neighborhood"),
//    Review(imageName: "3", text: "Great free place for a date night or relaxing stroll"),
//    Review(imageName: "4", text: "Great free place for a date night or relaxing stroll")
//]

var FBFriendsData: [FBFriend] = [
FBFriend(imageName: "4"), FBFriend(imageName:"3" ), FBFriend(imageName: "Profile Photo"), FBFriend(imageName: "1")
]

//let friendPlaces: Root = []

var locationData: [Location] = [
//    Location(placeImage: "Image", placeName: "Venice\nBeach Canals",placeCityState: "Los Angeles, California" ,placeLocation: "Venice Canals, Venice, CA", placeType: "Nature, Photo Ops",placeDescription:"The Venice Canal Historic District are great to capture during the day or at sunset." ,placeRating: 4.5,placeDistance: 1.2, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage:"b1 (3)" , placeName: "Bottega Louie", placeCityState: "Los Angeles, Californa", placeLocation: "700 Grand Ave, Los Angeles", placeType: "Restaurant", placeDescription: "Pizzas, pastas & small plates in a bright, bustling space, plus weekend brunch & macarons to-go.", placeRating: 4.8, placeDistance: 0.8, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "yaletown1", placeName: "Izakaya & Bar Fu-ga", placeCityState: "Los Angeles, Californa", placeLocation: "111 San Pedro, Los Angeles", placeType: "Restaurant", placeDescription: "Modern Japanese small plates, steaks & sushi served in a contemporary space, plus happy-hour deals.", placeRating: 4.3, placeDistance: 1.2, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "25162570", placeName: "Redbird", placeCityState: "Los Angeles, Californa", placeLocation: "114 E 2nd St, Los Angeles", placeType: "Restaurant", placeDescription: "Innovative New American dishes are paired with creative cocktails & a snazzy, historic setting.", placeRating: 4.0, placeDistance: 7.3, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "IMG_0879", placeName: "Âu Lạc LA", placeCityState: "Los Angeles, Californa", placeLocation: "710 W 1st St, Los Angeles", placeType: "Restaurant", placeDescription: "Strip-mall eatery serving creative vegan fare with Asian influence in a serene dining room.", placeRating: 4.0, placeDistance: 5.7, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "LAX-johnny-rockets-le-gout-de-l-amerique-2_1-1024x512", placeName: "Johnny Rockets", placeCityState: "Los Angeles, Californa", placeLocation: "131 Central Ave, Los Angeles", placeType: "Restaurant", placeDescription: "Your classic American restaurant with family-friendly dancing, music and ketchup art.", placeRating: 3.9, placeDistance:0.4 , placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "20170816_191703", placeName: "Blacksmiths", placeCityState: "Los Angeles, Californa", placeLocation: "117 Winston St, Los Angeles", placeType: "Restaurant", placeDescription: "Downtowners dig the elevated comfort food & craft cocktails at this upscale eatery.", placeRating: 3.3, placeDistance: 1.6, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "orochon-ramen", placeName: "Orochon Ramen", placeCityState: "Los Angeles, Californa", placeLocation: "123 Onizuka St, Los Angeles", placeType: "Restaurant", placeDescription: "Small Japanese restaurant with a Wall of Fame for diners who can conquer the spiciest ramen bowl.", placeRating: 3.3, placeDistance: 1.9, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "50bca03140c4271ad960733b9197032d", placeName: "Kushi Shabu", placeCityState: "Los Angeles, Californa", placeLocation: "123 Onizuka St, Los Angeles", placeType: "Restaurant", placeDescription: "Casual eatery presenting a mix of traditional Japanese dishes from shabu to sushi.", placeRating: 3.0, placeDistance: 1.9, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "manuela-anne-fishbein", placeName: "Manuela", placeCityState: "Los Angeles, Californa", placeLocation: "907 E 3rd St, Los Angeles", placeType: "Restaurant", placeDescription: "All-day eatery for seasonal menus, cocktails & housegrown ingredients in a rustic-chic arts complex.", placeRating: 2, placeDistance: 10.5, placeHours: 24, fbfriends: FBFriendsData),
    Location(placeImage: "DSC01580+DSC01574+DSC01559+DSC01568", placeName: "Bavel", placeCityState: "Los Angeles, Californa", placeLocation: "500 Mateo St, Los Angeles", placeType: "Restaurant", placeDescription: "Ori Menashe’s Middle Eastern follow-up to his always-packed Bestia, with a similar downtown vibe.", placeRating: 0.5, placeDistance: 15.5, placeHours: 24, fbfriends: FBFriendsData)
]

var FBFriends: [String] = ["5ddb6aacfed1c8041dcb1939"]



var FriendPlaces =
    [
        Place(
        name: "Fellow",
        city: "Los Angeles",
        state: "CA",
        latitude: 34.06116,
        longitude: -118.44464,
        tags: ["Venues & Event Spaces", "American (New)", "Cocktail Bars" ],
        address1: "1071 Glendon Ave",
        address2: "",
        zip_code: "90024",
        image:"https://s3-media1.fl.yelpcdn.com/bphoto/43cR4WiWIzUYb22NCbmF2A/o.jpg" ,
        price: "$$",
        id: "1",
        fbvisitors: [defaultURL,defaultURL],
        reviews:[Review(postedBy: "2", dateCreated: "2020-05-07T05:22:41.132Z", userImage:defaultURL, body: "Fellow is a Great place", rating: 4), Review(postedBy: "3", dateCreated: "2020-02-06T05:22:41.132Z", userImage:defaultURL, body: "Going to Fellow is worth it", rating: 5)],
        rating: 4.5,
        isDatabase: true),

        Place(
        name: "Toranj",
        city: "Los Angeles",
        state: "CA",
        latitude: 34.06026,
        longitude: -118.442964,
        tags: ["Persian/Iranian"],
        address1: "10861 Lindbrook Dr",
        address2: "",
        zip_code: "90024",
        image: "https://s3-media2.fl.yelpcdn.com/bphoto/Co8TInZe18L8ZIBiqDf7vg/o.jpg",
        price: "$",
        id: "2",
        fbvisitors: [defaultURL,defaultURL],
        reviews: [Review(postedBy: "3", dateCreated: "2020-02-06T05:22:41.132Z", userImage:defaultURL, body: "Toranj is a Great place", rating: 3), Review(postedBy: "4", dateCreated: "2020-02-06T05:22:41.132Z", userImage:defaultURL, body: "Going to Toranj is worth it", rating: 5)],
        rating: 4,
        isDatabase: true)
]
var YelpSearch: [Place] =
[
    Place(
    name: "Fellow",
    city: "Los Angeles",
    state: "CA",
    latitude: 34.06116,
    longitude: -118.44464,
    tags: ["Venues & Event Spaces", "American (New)", "Cocktail Bars" ],
    address1: "1071 Glendon Ave",
    address2: "",
    zip_code: "90024",
    image:"https://s3-media1.fl.yelpcdn.com/bphoto/43cR4WiWIzUYb22NCbmF2A/o.jpg" ,
    price: "$$",
    id: "1",
    fbvisitors: [defaultURL,defaultURL],
    reviews:[Review(postedBy: "2", dateCreated: "2020-02-06T05:22:41.132Z", userImage:defaultURL, body: "Fellow is a Great place", rating: 4), Review(postedBy: "3", dateCreated: "2020-02-06T05:22:41.132Z", userImage:defaultURL, body: "Going to Fellow is worth it", rating: 5)],
    rating: 4.5,
    isDatabase: false)
]

var FeedPlaces = [Feed]()  

var MapConvert: [GetMapResponse] = [GetMapResponse(place: PlaceReturn(tags: [""], reviews: [""], _id: "", name: "", image: "", city: "", state: "", address1: "", address2: "", zip_code: "", latitude: 0, longitude: 0, price: ""), averageRating: 0, friend_images: [""], reviews:[] )]

var searchConvert = GetMapResponse(place: PlaceReturn(tags: [""], reviews: [""], _id: "", name: "", image: "", city: "", state: "", address1: "", address2: "", zip_code: "", latitude: 0, longitude: 0, price: ""), averageRating: 0, friend_images: [""], reviews:[])


