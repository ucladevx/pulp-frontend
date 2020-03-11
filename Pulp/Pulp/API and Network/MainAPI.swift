//
//  moya.swift
//  pulp_swift
//
//  Created by Aryan Arora on 5/20/19.
//  Copyright © 2019 Aryan Arora. All rights reserved.
//
import Foundation
import Moya
import Alamofire

class CustomServerTrustPoliceManager : ServerTrustPolicyManager {
    override func serverTrustPolicy(forHost host: String) -> ServerTrustPolicy? {
        return .disableEvaluation
    }
    public init() {
        super.init(policies: [:])
    }
}

let manager = Manager(
    configuration: URLSessionConfiguration.default,
    serverTrustPolicyManager: CustomServerTrustPoliceManager()
)


let service = MoyaProvider<APICall>(manager: manager, plugins: [NetworkLoggerPlugin(verbose: true)])

var YelpPlaceID = "VQz6yZBj3l_T2XX-4mLV-Q"


public enum APICall: TargetType {
    case NewUser(firstName: String, lastName: String, photo: String, fbID: String, friends:[String], accessToken: String) // returns user_id
    case GetUser(userID: String)
    case GetMap(userId: String)
    
    case CreatePlace(name:String, city: String, state:String ,latitude:Double ,longitude:Double ,tags: [String],address1:String ,address2: String , zip_code: String, image: String )
    case GetPlace(placeID:String)
    case AddReview(userID:String, placeID:String, rating:Double, body:String)
    case PlaceNameSearch(placeName: String, placeLat: Double, placeLong: Double)
    
    case YelpTest(lat: Double, long: Double, term: String, limit: Int)
    case YelpReview()
    
    public var sampleData: Data {
        return Data()
    }

    public var headers: [String : String]? {
        switch self {
        case .YelpTest:
            return ["Authorization": "Bearer \(apiKey)"]
        case .YelpReview:
            return ["Authorization": "Bearer \(apiKey)"]
            
        default:
            return ["Content-Type" : "application/json"]
        }
    }

    public var baseURL: URL {
        switch self {
        
        case .YelpTest:
            return URL(string: "https://api.yelp.com/v3/businesses")!
        case .YelpReview:
            return URL(string: "https://api.yelp.com/v3/businesses")!
        default:
            return URL(string: "https://ec2-3-135-205-131.us-east-2.compute.amazonaws.com:80/api")!
                //https://ec2-3-15-239-224.us-east-2.compute.amazonaws.com:80/api")!
        }
    }
    
    
    public var path: String {
        switch self {
        case .NewUser:
            return "/new_user"
        case .GetUser:
            return "/find_user"
        case .GetMap:
            return "/get_map"
            
        case .CreatePlace:
            return "/create_place"
        case .GetPlace:
            return "/get_place"
        case .AddReview:
            return "/add_review"
        case .PlaceNameSearch:
            return "/search_place_if_exists"
        
        case .YelpTest:
            return "/search"
        case .YelpReview:
            return "/" + YelpPlaceID + "/reviews"
        }
    }
    public var method: Moya.Method {
        switch self {
        case .NewUser:
            return .post
        case .GetUser:
            return .get
        case .GetMap:
            return .get
            
        case .CreatePlace:
            return .post
        case .AddReview:
            return .post
        case .GetPlace:
            return .get
        case .PlaceNameSearch:
            return .get
            
        case .YelpTest:
            return .get
        case .YelpReview:
            return .get
        }
    }
    public var task: Task {
        switch self {
            
            
            
            
            
        // Current implementation routes start here
            
            
        case let .NewUser(firstName, lastName, photo, fbID, friends, accessToken): //imp
            return .requestParameters(parameters: ["first_name" : firstName, "last_name" : lastName, "photo" : photo, "facebook_id" : fbID, "friends": friends, "access_token": accessToken], encoding: JSONEncoding.default)

        case let .GetMap(userId): //imp
            return .requestParameters(parameters: ["user_id" : userId], encoding: URLEncoding.queryString)
            
        case let .CreatePlace(name, city, state, latitude, longitude, tags, address1, address2, zip_code, image):  //imp
            return .requestParameters(parameters: ["name" : name, "city" : city, "state" : state ,"latitude" :latitude ,"longitude" : longitude ,"tags": tags, "address1" : address1 , "address2": address2 , "zip_code" : zip_code,  "image": image], encoding: JSONEncoding.default)
       
        case let .AddReview(userID, placeID, rating, body):  //imp
            return .requestParameters(parameters: ["user_id" : userID, "place_id" : placeID, "rating" : rating, "body" : body, "user_photo" : USER_Photo], encoding: JSONEncoding.default)
            
        case let .PlaceNameSearch(placeName, placeLat, placeLong):  //imp
            return .requestParameters(parameters: ["place_name" : placeName, "user_id" : USERID, "latitude" : placeLat, "longitude" : placeLong], encoding: URLEncoding.queryString)
            
        
         // Current implementation routes end here
        
        
        
        
        
        case let .GetUser(userID):
            return.requestParameters(parameters: ["user_id" : userID], encoding: URLEncoding.queryString)
            
        case let .GetPlace(placeID):
                       return .requestParameters(parameters: ["placeID" : placeID], encoding: URLEncoding.queryString)
            
        case let .YelpTest(lat,long,term,limit):
            return .requestParameters(parameters: ["latitude" : lat,"longitude" : long, "limit" : limit, "term" : term], encoding: URLEncoding.queryString)
        case .YelpReview():
            return .requestPlain
        }
    }
}

private let apiKey = "ru0Facr6eDDUlKnur9Lzax8r9wtiuog0lvxGNEkVJVOondxQvqJleAjEBJE-Aiqkx0gZ5O9PwLoUhDBEY2lFW765D88IEfQB7k7X3gO7jKmQgD4dvpByXifNJQPNXXYx"


