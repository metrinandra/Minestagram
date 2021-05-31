//
//  Models.swift
//  Minestagram_Andra
//
//  Created by Andra Metrina on 30/05/2021.
//

import Foundation

public struct UserPost{
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //video or photo
    let caption: String?
    let dateCreated: Date
}
public enum UserPostType{
    case photo,video
}
