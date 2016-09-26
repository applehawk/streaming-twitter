//
//  ThreadSafeArray.swift
//  StreamingTwitter
//
//  Created by Hawk on 26/09/16.
//  Copyright © 2016 Hawk. All rights reserved.
//

import Foundation

public class ThreadSafeArray<T> {
    private var array: [T] = []
    private let accessQueue = DispatchQueue(label: "ThreadSafeArray")
    
    public func append(newElement: T) {
        accessQueue.async {
            self.array.append(newElement)
        }
    }
    
    public subscript(index: Int) -> T {
        set {
            accessQueue.async {
                self.array[index] = newValue
            }
        }
        get {
            var element: T!
            accessQueue.sync {
                element = self.array[index]
            }
            return element
        }
    }
}
