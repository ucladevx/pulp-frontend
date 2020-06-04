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
        FeedPlaces.append(Feed(userPhoto: "https://www.cs.ucla.edu/wp-content/uploads/cs/smallberg.jpg",
            userName: "David Smallberg", placeName: "Diddy Riese", placeTags: ["Desert", "Ice Cream"],
            placeImage: "https://www.diddyriese.com/wp-content/uploads/2017/01/Screen-Shot-2017-01-17-at-9.33.59-PM.png",
            reviewText: "I like ice cream. Maybe even more than I like pointers", reviewDate: "06-03-2020"))
        FeedPlaces.append(Feed(userPhoto: "https://docplayer.net/docs-images/62/48147733/images/46-0.jpg", userName: "Paul Eggert", placeName: "The Emacs Burger", placeTags: ["Burgers", "American", "Fast Food"], placeImage: "", reviewText: "It is an amazing place to grab a quick byte. I often get a nice burger and ruin students’life on the side.", reviewDate: "06-04-2020"))
        
        
        feedDispatchGroup.leave()
    }
}
