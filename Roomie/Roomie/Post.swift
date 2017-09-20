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
    
    fileprivate static var authorKey: String { return "author" }
    fileprivate static var groupKey: String { return "group" }
    fileprivate static var timestampKey: String { return "timestamp" }
    fileprivate static var textKey: String { return "text" }
    static var recordType: String { return "Post" }
    
    let author: CKReference
    let group: CKReference
    let timestamp: Date
    let text: String
    
    var ckRecordID: CKRecordID?
    
    init(author: CKReference, group: CKReference, timestamp: Date = Date(), text: String) {
        self.author = author
        self.group = group
        self.timestamp = timestamp
        self.text = text
    }
    
    init?(ckRecord: CKRecord) {
        guard let author = ckRecord[Post.authorKey] as? CKReference,
        let group = ckRecord[Post.groupKey] as? CKReference,
        let timestamp = ckRecord[Post.timestampKey] as? Date,
            let text = ckRecord[Post.textKey] as? String else { return nil }
        
        self.author = author
        self.group = group
        self.timestamp = timestamp
        self.text = text
        self.ckRecordID = ckRecord.recordID
    }
}

extension Post: Equatable {
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.author == rhs.author && lhs.group == rhs.group && lhs.timestamp == rhs.timestamp && lhs.text == rhs.text
    }
}

extension CKRecord {
    convenience init(post: Post) {
        let recordID = post.ckRecordID ?? CKRecordID(recordName: UUID().uuidString)
        
        self.init(recordType: Post.recordType, recordID: recordID)
        self.setValue(post.author, forKey: Post.authorKey)
        self.setValue(post.group, forKey: Post.groupKey)
        self.setValue(post.timestamp, forKey: Post.timestampKey)
        self.setValue(post.text, forKey: Post.textKey)
    }
}
