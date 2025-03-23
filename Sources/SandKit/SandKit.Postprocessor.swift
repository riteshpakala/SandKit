//
//  SandKit.Prompts.swift
//  
//
//  Created by Ritesh Pakala Rao on 5/5/23.
//

import Foundation

// TODO: support to visualize the thinking process.
public struct Postprocessor {
    static var tags: [String] = ["</think>"]
    static var currentTag: String? = nil
    
    static public func sanitize(_ input: String, visualize: Bool = true) -> String? {
        guard let tag = currentTag ?? tags.first(where: { input.contains($0) }) else {
            return visualize ? input : nil
        }
        
        currentTag = tag
        
        return input.components(separatedBy: tag).last
    }
    
    static func clean() {
        currentTag = nil
    }
}
