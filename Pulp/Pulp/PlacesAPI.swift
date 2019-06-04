//
//  PlacesAPI.swift
//  Pulp
//
//  Created by Aryan Arora on 5/27/19.
//  Copyright © 2019 Andy Cai. All rights reserved.
//

import Foundation
import Moya

<<<<<<< HEAD
struct ChatListResult: Codable {
    var chatListItems: [Match]
}

protocol ChatListDelegate {
    func didReceiveChatList(chatListData: [Match])
}

class ChatListAPI {
    
    var delegate: ChatListDelegate? = nil
    private let provider = MoyaProvider<MainAPI>()
    
    func getChatList(forUserWithID user: Int) {
        provider.request(.chatList(forUserWithID: user)) { result in
            switch result {
            case let .success(response):
                do {
                    let resultStruct = try JSONDecoder().decode([Match].self, from: response.data)
                    self.delegate?.didReceiveChatList(chatListData: resultStruct)
                } catch let err {
                    print ("Error parsing response JSON into ChatListResult struct")
                    print (err)
                }
            case let .failure(error):
                print ("Error acquiring chat list!")
                print (error.errorDescription ?? "")
            }
        }
    }
}

struct ChatListResult: Codable {
    var chatListItems: [Match]
}

protocol ChatListDelegate {
    func didReceiveChatList(chatListData: [Match])
}

class ChatListAPI {
    
    var delegate: ChatListDelegate? = nil
    private let provider = MoyaProvider<MainAPI>()
    
    func getChatList(forUserWithID user: Int) {
        provider.request(.chatList(forUserWithID: user)) { result in
            switch result {
            case let .success(response):
                do {
                    let resultStruct = try JSONDecoder().decode([Match].self, from: response.data)
                    self.delegate?.didReceiveChatList(chatListData: resultStruct)
                } catch let err {
                    print ("Error parsing response JSON into ChatListResult struct")
                    print (err)
                }
            case let .failure(error):
                print ("Error acquiring chat list!")
                print (error.errorDescription ?? "")
            }
        }
    }
}
=======
//struct PlacesResult: Codable {
//    var chatListItems: [Match]
//}
//
//protocol ChatListDelegate {
//    func didReceiveChatList(chatListData: [Match])
//}
//
//class ChatListAPI {
//
//    var delegate: ChatListDelegate? = nil
//    private let provider = MoyaProvider<MainAPI>()
//
//    func getChatList(forUserWithID user: Int) {
//        provider.request(.chatList(forUserWithID: user)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let resultStruct = try JSONDecoder().decode([Match].self, from: response.data)
//                    self.delegate?.didReceiveChatList(chatListData: resultStruct)
//                } catch let err {
//                    print ("Error parsing response JSON into ChatListResult struct")
//                    print (err)
//                }
//            case let .failure(error):
//                print ("Error acquiring chat list!")
//                print (error.errorDescription ?? "")
//            }
//        }
//    }
//}struct ChatListResult: Codable {
//    var chatListItems: [Match]
//}
//
//protocol ChatListDelegate {
//    func didReceiveChatList(chatListData: [Match])
//}
//
//class ChatListAPI {
//
//    var delegate: ChatListDelegate? = nil
//    private let provider = MoyaProvider<MainAPI>()
//
//    func getChatList(forUserWithID user: Int) {
//        provider.request(.chatList(forUserWithID: user)) { result in
//            switch result {
//            case let .success(response):
//                do {
//                    let resultStruct = try JSONDecoder().decode([Match].self, from: response.data)
//                    self.delegate?.didReceiveChatList(chatListData: resultStruct)
//                } catch let err {
//                    print ("Error parsing response JSON into ChatListResult struct")
//                    print (err)
//                }
//            case let .failure(error):
//                print ("Error acquiring chat list!")
//                print (error.errorDescription ?? "")
//            }
//        }
//    }
//}
>>>>>>> 577e4b11b55ce8b4dce168532810574bedf783dc
