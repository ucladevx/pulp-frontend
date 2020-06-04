//
//  File.swift
//  Pulp
//
//  Created by Aryan Arora on 11/14/19.
//  Copyright © 2019 Pulp Inc. All rights reserved.
//

import Foundation
import Moya

var TempPlaces: [PlacesList] = [PlacesList(id: "", name: "", rating: 0, image_url: "", distance: 0, location: Address(city: "", state: "", address1: "", address2: "", zip_code: ""), categories: [Tag(title: "")], coordinates: Coordinate(latitude: 0, longitude: 0), price: "") ]
struct Return: Codable{
    let businesses: [PlacesList]
}


