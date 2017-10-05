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
    
    // MARK: - Create
    
    //FIXME: Do we need to fix this to be a success completion instead of error?
    
    func createPost(author: CKReference, authorUserName: String, group: CKReference, timestamp: Date = Date(), text: String, completion: @escaping ((Error?) -> Void) = { _ in }) {
        
        let post = Post(author: author, authorUserName: authorUserName, group: group, timestamp: timestamp, text: text)
        let postRecord = CKRecord(post: post)
        
        cloudKitManager.saveRecord(postRecord) { (record, error) in
            defer { completion(error) }
            
            if let error = error { NSLog("Error saving record \(#file) \(#function) \(error.localizedDescription)"); return }
            
            guard let record = record else { completion(error); return }
            
            post.ckRecordID = record.recordID
            
            self.posts.append(post)
        }
    }
    
    // MARK: - Retreive/Fetch
    
    func fetchPostsByGroup(completion: @escaping (_ success: Bool) -> Void = { _ in }){
        
        let sortDescriptors = [NSSortDescriptor(key: Post.timestampKey, ascending: true)]
        
        guard let groupRecID = GroupController.shared.currentGroup?.cloudKitRecordID else { completion(false); return}
        
        let groupRef = CKReference(recordID: groupRecID, action: .none)
        
        let predicate = NSPredicate(format: "group == %@", groupRef)
        
        cloudKitManager.fetchRecordsWithType(Post.recordTypeKey, predicate: predicate, sortDescriptors: sortDescriptors, recordFetchedBlock: nil) { (records, error) in
            
            if let error = error {
                print(error.localizedDescription)
            }
            guard let groupPosts = records else { completion(false); return }
            let posts = groupPosts.flatMap { Post(ckRecord: $0) }
            
            self.posts = posts
            completion(true)
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
    } // ** check to see if the project still works without the above function
    
    func deletePost(post: Post) {
        let record = CKRecord(post: post)
        cloudKitManager.deleteOperation(record) { 
            guard let index = self.posts.index(of: post) else { return }
            self.posts.remove(at: index)
        }
    }
}
