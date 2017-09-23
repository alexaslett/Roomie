//
//  Post.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class Post {
    
    static let authorKey = "author"
    static let authorUserNameKey = "authorUserName"
    static let groupKey = "group"
    static let timestampKey = "timestamp"
    static let textKey = "text"
    static let recordTypeKey = "Post"
    
    var author: CKReference
    var authorUserName: String
    var group: CKReference
    var timestamp: Date
    var text: String
    
    var ckRecordID: CKRecordID?
    
    init(author: CKReference, authorUserName: String, group: CKReference, timestamp: Date = Date(), text: String) {
        self.author = author
        self.authorUserName = authorUserName
        self.group = group
        self.timestamp = timestamp
        self.text = text
    }
    
    init?(ckRecord: CKRecord) {
        guard let author = ckRecord[Post.authorKey] as? CKReference,
            let authorUserName = ckRecord[Post.authorUserNameKey] as? String,
            let group = ckRecord[Post.groupKey] as? CKReference,
            let timestamp = ckRecord[Post.timestampKey] as? Date,
            let text = ckRecord[Post.textKey] as? String else { return nil }
        
        self.author = author
        self.authorUserName = authorUserName
        self.group = group
        self.timestamp = timestamp
        self.text = text
        self.ckRecordID = ckRecord.recordID
    }
}

extension Post: Equatable {
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.author == rhs.author && lhs.authorUserName == rhs.authorUserName && lhs.group == rhs.group && lhs.timestamp == rhs.timestamp && lhs.text == rhs.text
    }
}

extension CKRecord {
    convenience init(post: Post) {
        let recordID = post.ckRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: Post.recordTypeKey, recordID: recordID)
        
        self.setValue(post.authorUserName, forKey: Post.authorUserNameKey)
        self.setValue(post.author, forKey: Post.authorKey)
        self.setValue(post.group, forKey: Post.groupKey)
        self.setValue(post.timestamp, forKey: Post.timestampKey)
        self.setValue(post.text, forKey: Post.textKey)
    }
}
