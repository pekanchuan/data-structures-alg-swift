//
//  File.swift
//  data-structures-alg-swift
//
//  Created by Chia on 2023/6/26.
//

import Foundation

public class QueueNode<T> {
    
    public var value: T
    public var next: QueueNode<T>?
    public var previous: QueueNode<T>?
    
    public init(value: T) {
        self.value = value
    }
}

extension QueueNode: CustomStringConvertible {
    public var description: String {
        String(describing: value)
    }
}

public class DoublyLinkedList<T> {
    private var head: QueueNode<T>?
    private var tail: QueueNode<T>?
    
    public init() {}
    
    public var isEmpty: Bool {
        head == nil
    }
    
    public var first: QueueNode<T>? {
        head
    }
    
    public func append(_ value: T) {
        let newNode = QueueNode(value: value)
        
        guard let tailNode = tail else {
            head = newNode
            tail = newNode
            return
        }
        
        newNode.previous = tailNode
        tailNode.next = newNode
        tail = newNode
    }
    
    public func remove(_ node: QueueNode<T>) -> T {
        let prev = node.previous
        let next = node.next
        
        if let prev {
            prev.next = next
        } else {
            head = next
        }
        
        next?.previous = prev
        
        if next == nil {
            tail = prev
        }
        
        node.previous = nil
        node.next = nil
        
        return node.value
    }
}

extension DoublyLinkedList: CustomStringConvertible {
    public var description: String {
        var string = ""
        var current = head
        while let node = current {
            string.append("\(node.value) -> ")
            current = node.next
        }
        return string + " end"
    }
}
