//
//  Feed.swift
//  Pulp
//
//  Created by Bryan Wong on 5/2/20.
//  Copyright © 2020 Aryan Arora. All rights reserved.
//

import Foundation

// Reviews up to NUM_DAYS_RECENT days old will be shown
let NUM_DAYS_RECENT = 3

// Dummy default date, until API is fixed to make date a mandatory parameter
let DEFAULT_DATE = "2020-02-06T05:22:41.132Z"

let loadFeedDispatch = DispatchGroup()

func GetFeed() {
    // Get comparison date
    let daysAgo = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    
    loadFeedDispatch.enter()
    GetMapPlaces(fromMap: false)
    loadFeedDispatch.notify(queue: .main) {
        FeedPlaces.removeAll()
        for place in FriendPlaces {
            for review in place.reviews {
                let dateString  = review.dateCreated ?? DEFAULT_DATE
                let index = dateString.index(dateString.startIndex, offsetBy: 19)
                let reviewDate = formatter.date(from: String(dateString[..<index]))
                
                if(Calendar.current.compare(reviewDate!, to: daysAgo, toGranularity: .second) == .orderedDescending) {
                    FeedPlaces.append(Feed(
                        userPhoto: review.userImage ?? defaultURL,
                        userName: review.postedBy ?? "",
                        placeName: place.name,
                        placeTags: place.tags,
                        placeImage: place.image ?? "",
                        reviewText: review.body ?? "",
                        reviewDate: review.dateCreated ?? DEFAULT_DATE
                    ))
                }
            }
        }
                
        
                FeedPlaces.append(Feed(userPhoto: "https://scontent.fdel1-2.fna.fbcdn.net/v/t1.0-1/p320x320/97892448_2944918605592188_6927749280279035904_n.jpg?_nc_cat=104&_nc_sid=dbb9e7&_nc_oc=AQnleCCvajsNe7vr_lMXsArCxHYRaSdZetdgpFqmwYXQCH-h6BTX3HuVuw4KQn8t1pg&_nc_ht=scontent.fdel1-2.fna&_nc_tp=6&oh=f64f9f7a8926ab7204d50e69bdbc218f&oe=5EFFF702", userName: "Tiffany Guo", placeName: "Toranj", placeTags: ["Persian", "Iranian", "Dining"], placeImage: "https://s3-media2.fl.yelpcdn.com/bphoto/Co8TInZe18L8ZIBiqDf7vg/o.jpg", reviewText: "Love this place! We heard a lot of good things so we decided to check it out. It's located in the prime location of Westwood but since it's in a side street there's always plenty of parking.The menu had a lot of variety including some dishes that other Persian restaurants usually don't have which was exciting! ", reviewDate: "06-04-2020"))
                FeedPlaces.append(Feed(userPhoto: "https://scontent.fdel1-4.fna.fbcdn.net/v/t1.0-1/p320x320/97217064_1177623855910429_169865866362486784_n.jpg?_nc_cat=102&_nc_sid=dbb9e7&_nc_oc=AQnbVM2Yvuq8BRxq-apcvCENbuOt1CUCZNnrPw2yrdu9QZxMiYcJFVAm2I8-H9SJSHo&_nc_ht=scontent.fdel1-4.fna&_nc_tp=6&oh=03515cb4ea354af1bc70d16cd908d072&oe=5EFD338F", userName: "Saarthak Sharma", placeName: "Emporium Thai", placeTags: ["Thai", "Restaurant"], placeImage: "https://b.zmtcdn.com/data/reviews_photos/47c/342d68152140a8f319f9877c71d4d47c_1474337382.JPG", reviewText: "They probably have the best Thai food near UCLA", reviewDate: "06-04-2020"))
                FeedPlaces.append(Feed(userPhoto: "https://scontent.fdel1-4.fna.fbcdn.net/v/t1.0-1/p320x320/83405622_2819532658090015_4540248944084516864_n.jpg?_nc_cat=100&_nc_sid=dbb9e7&_nc_oc=AQlZ3xmy2e6GLeiu65eUpkOKmRvvfXEuRirv6_ga_6pRhZeCnTZXOc1Fl87h65hpLYg&_nc_ht=scontent.fdel1-4.fna&_nc_tp=6&oh=170ef5a7354617a73dc0fbc53c65ebfb&oe=5EFFAC89", userName: "Bryan Wong", placeName: "Fellow", placeTags: ["Cocktail Bars", "Venues & Event Spaces"], placeImage: "https://s3-media1.fl.yelpcdn.com/bphoto/43cR4WiWIzUYb22NCbmF2A/o.jpg", reviewText: "This place really is a gem in Westwood, L.A. I love the decor, and the food is incredible. They have changed the menu several times since they opened. I wish they still had the pork belly, but hopefully it will come back soon!", reviewDate: "06-04-2020"))
                
        
        //        FeedPlaces.append(Feed(userPhoto: "", userName: "", placeName: "", placeTags: ["", ""], placeImage: "", reviewText: "", reviewDate: "06-04-2020"))
        //        FeedPlaces.append(Feed(userPhoto: "", userName: "", placeName: "", placeTags: ["", ""], placeImage: "", reviewText: "", reviewDate: "06-04-2020"))
        
        
        
        FeedPlaces.append(Feed(userPhoto: "https://www.cs.ucla.edu/wp-content/uploads/cs/smallberg.jpg",
            userName: "David Smallberg", placeName: "Diddy Riese", placeTags: ["Desert", "Ice Cream"],
            placeImage: "https://www.diddyriese.com/wp-content/uploads/2017/01/Screen-Shot-2017-01-17-at-9.33.59-PM.png",
            reviewText: "I like ice cream. Maybe even more than I like pointers", reviewDate: "06-03-2020"))
        FeedPlaces.append(Feed(userPhoto: "https://docplayer.net/docs-images/62/48147733/images/46-0.jpg", userName: "Paul Eggert", placeName: " The Emacs Burger", placeTags: ["Burgers", "American", "Fast Food"], placeImage: "http://www.newsauvergne.com/_fichiers/actus/1430387738_burger-king-web.jpg", reviewText: "It is an amazing place to grab a quick byte. I often get a nice burger and ruin students’life on the side.", reviewDate: "06-04-2020"))
        

        
        
        feedDispatchGroup.leave()
    }
}
