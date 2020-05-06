//
//  Models.swift
//  Pulp
//
//  Created by Aryan Arora on 11/16/19.
//  Copyright © 2019 Pulp Inc. All rights reserved.
//

import Foundation

struct Root: Codable{
    let places : [Place]
}

struct Place: Codable{
    //  Required Param
    let name: String
    let city: String
    let state: String
    let latitude: Double
    let longitude: Double
    let tags: [String]
     
    // Optional Param
    let address1: String?
    let address2: String?
    let zip_code: String?
    let image: String?
    let price: String?
    
    // Returned
    let id: String
    let fbvisitors: [String]
    var reviews: [Review]
    let rating: Double
    
    let isDatabase: Bool
}

struct PlacesList: Codable{
    let id: String?
    let name: String?
    let rating: Double?
    let image_url: String?
    let distance: Double?
    let location: Address?
    let categories: [Tag]
    let coordinates: Coordinate
    let price: String?
}
 
struct Tag: Codable{
    let title: String
}

struct Coordinate: Codable{
    let latitude: Double
    let longitude: Double
}

struct Address: Codable{
let city: String?
let state: String?
let address1: String?
let address2: String?
let zip_code: String?
}


struct Review: Codable{
    var postedBy: String?
    var dateCreated: String?
    var userImage: String?
    var body: String?
    var rating: Double?
    
}


struct GetMapResponse: Codable{

        let place: PlaceReturn
        let averageRating: Double
        let friend_images: [String]
        let reviews: [TempReview]
}

struct PlaceReturn: Codable{
    let tags: [String]
    let reviews: [String]?
    let _id: String
    let name: String
    let image: String?
    let city: String
    let state: String
    let address1: String?
    let address2: String?
    let zip_code: String?
    let latitude: Double
    let longitude: Double
    let price: String?

}


struct NewReview: Codable{
    let text: String
    let rating: Double
}

struct Reviews: Codable{
    let reviews: [NewReview]
}


struct TempReview: Codable{
    //let user_photo: String?
    let postedBy:String
    let dateCreated: String
    let rating: Double
    let body: String?
}

struct Feed: Codable {
    let userPhoto: String?
    let userName: String
    let placeName: String
    let placeTags: [String]
    let placeImage: String
    let reviewText: String
    let reviewDate: String
}

struct UserReturn: Codable{
    let photo: String
}
