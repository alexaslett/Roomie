//
//  PostController.swift
//  Roomie
//
//  Created by Kaitlyn Barker on 9/20/17.
//  Copyright © 2017 One Round Technology. All rights reserved.
//

import Foundation
import CloudKit

class PostController {
    
    static let shared = PostController()
    
    let cloudKitManager: CloudKitManager = {
       return CloudKitManager()
    }()
    
    var posts: [Post] = []
    
    var post: Post?
    
    // MARK: - Create
    
    func createPost(author: CKReference, group: CKReference, timestamp: Date = Date(), text: String, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let post = Post(author: author, group: group, timestamp: timestamp, text: text)
        let postRecord = CKRecord(post: post)
        
        cloudKitManager.saveRecord(postRecord) { (record, error) in
            defer { completion(error) }
            
            if let error = error { NSLog("Error saving record \(#file) \(#function) \(error.localizedDescription)"); return }
            
            guard record != nil else { NSLog("cannot create post"); return }
            
            self.posts.append(post)
        }
    }
    
    // MARK: - Retreive/Fetch
    
    func fetchPosts(completion: @escaping ((Error?) -> Void) = { _ in }) {
        let sortDescriptors = [NSSortDescriptor(key: Post.timestampKey, ascending: false)]
        
        cloudKitManager.fetchRecords(ofType: Post.recordType, withSortDescriptors: sortDescriptors) { (records, error) in
            
            defer { completion(error) }
            
            if let error = error {
                NSLog("Error fetching data. \(#file) \(#function) \n\(error.localizedDescription)")
                return
            }
            guard let records = records else { return }
            
            self.posts = records.flatMap { Post(ckRecord: $0) }
        }
    }
    
    // MARK: - Update
    
    func updatePosts(post: Post?, author: CKReference, group: CKReference, timestamp: Date = Date(), text: String, completion: @escaping ((_ success: Bool) -> Void) = { _ in }) {
        
        guard let post = post else { return }
        
        post.author = author
        post.group = group
        post.timestamp = timestamp
        post.text = text
        
        let postRecord = CKRecord(post: post)
        
        cloudKitManager.saveRecords([postRecord], perRecordCompletion: { (_, error) in
            if let error = error {
                NSLog("Error updating post. \(#file) \(#function) \n\(error.localizedDescription)")
                return
            }
        }) { (records, error) in
            let success = records != nil
            completion(success)
        }
    }
    
    // MARK: - Delete
    
    func delete(recordID: CKRecordID, completion: @escaping ((Error?) -> Void) = { _ in }) {
        cloudKitManager.deleteRecordWithID(recordID) { (ckRecordID, error) in
            defer { completion(error) }
            
            if let error = error {
                NSLog("Error deleting post. \(#file) \(#function) \(error.localizedDescription)")
                return
            }
        }
    }
    
    func deletePost(post: Post) {
        let record = CKRecord(post: post)
        cloudKitManager.deleteOperation(record) { 
            guard let index = self.posts.index(of: post) else { return }
            self.posts.remove(at: index)
        }
    }
}
