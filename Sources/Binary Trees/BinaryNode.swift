//
//  File.swift
//  
//
//  Created by Chia on 2023/6/27.
//

import Foundation

public class BinaryNode<Element> {
    public var value: Element
    public var leftChild: BinaryNode?
    public var rightChild: BinaryNode?
    
    public init(value: Element) {
        self.value = value
    }
}

extension BinaryNode: CustomStringConvertible {
    public var description: String {
        diagram(for: self)
    }
    
    private func diagram(for node: BinaryNode?,
                         _ top: String = "",
                         _ root: String = "",
                         _ bottom: String = "") -> String {
        guard let node else {
            return root + "nil\n"
        }
        
        if node.leftChild == nil && node.rightChild == nil {
            return root + "\(node.value)\n"
        }
        
        return diagram(for: node.rightChild,
                       top + " ", top + "┌──", top + "│ ")
        + root + "\(node.value)\n"
        + diagram(for: node.leftChild,
                  bottom + "│ ", bottom + "└──", bottom + " ")
    }
}

extension BinaryNode {
    public func traverseInOrder(visit: (Element) -> Void) {
        leftChild?.traverseInOrder(visit: visit)
        visit(value)
        rightChild?.traverseInOrder(visit: visit)
    }
}

extension BinaryNode {
    public func traversePreOrder(visit: (Element) -> Void) {
        visit(value)
        leftChild?.traversePreOrder(visit: visit)
        rightChild?.traversePreOrder(visit: visit)
    }
}

extension BinaryNode {
    public func traversePostOrder(visit: (Element) -> Void) {
        leftChild?.traversePostOrder(visit: visit)
        rightChild?.traversePostOrder(visit: visit)
        visit(value)
    }
}

extension BinaryNode where Element: Comparable {
    
    var isBinarySearchTree: Bool {
        isBST(self, min: nil, max: nil)
    }
    
    private func isBST(_ tree: BinaryNode<Element>?, min: Element?, max: Element?) -> Bool {

        guard let tree else {
            return true
        }
        
        if let min, tree.value <= min {
            return false
        } else if let max, tree.value > max {
            return false
        }
        
        let left = isBST(tree.leftChild, min: min, max: tree.value)
        let right = isBST(tree.rightChild, min: tree.value, max: max)
        return left && right
    }
}
