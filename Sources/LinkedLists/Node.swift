//
//  Node.swift
//  
//
//  Created by Chia on 2023/6/20.
//

import Foundation

enum LinkedLists {}

extension LinkedLists {
    public class Node<Value> {
        public var value: Value
        public var next: Node?
        
        public init(value: Value, next: Node? = nil) {
            self.value = value
            self.next = next
        }
    }
}

extension LinkedLists.Node: CustomStringConvertible {
    public var description: String {
        guard let next else {
            return "\(value)"
        }
        return "\(value) -> " + String(describing: next) + " "
    }
}
