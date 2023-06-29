//
//  File.swift
//
//
//  Created by Chia on 2023/6/27.
//

import Foundation

public struct BinarySearchTree<Element: Comparable> {
    public private(set) var root: BinaryNode<Element>?

    public init() {}
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        guard let root else {
            return "empty tree"
        }

        return String(describing: root)
    }
}

extension BinarySearchTree {
    public mutating func insert(_ value: Element) {
        root = insert(from: root, value: value)
    }

    private func insert(from node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element> {
        guard let node else {
            return BinaryNode(value: value)
        }

        if value < node.value {
            node.leftChild = insert(from: node.leftChild, value: value)
        } else {
            node.rightChild = insert(from: node.rightChild, value: value)
        }
        return node
    }
}

extension BinarySearchTree {
    public func contains(_ value: Element) -> Bool {
        var current = root

        while let node = current{
            if node.value == value {
                return true
            }
            
            if value < node.value {
                current = node.leftChild
            } else {
                current = node.rightChild
            }
        }
        
        return false
    }
}

private extension BinaryNode {
    var min: BinaryNode {
        leftChild?.min ?? self
    }
}

extension BinarySearchTree {
    public mutating func remove(_ value: Element) {
        root = remove(node: root, value: value)
    }
    
    private func remove(node: BinaryNode<Element>?, value: Element) -> BinaryNode<Element>? {
        guard let node else {
            return nil
        }
        if value == node.value {
            if node.leftChild == nil && node.rightChild == nil {
                return nil
            }
            if node.leftChild == nil {
                return node.rightChild
            }
            if node.rightChild == nil {
                return node.leftChild
            }
            
            node.value = node.rightChild!.min.value
            node.rightChild = remove(node: node.rightChild, value: node.value)
        } else if value < node.value {
            node.leftChild = remove(node: node.leftChild, value: value)
        } else {
            node.rightChild = remove(node: node.rightChild, value: value)
        }
        return node
    }
}

extension BinarySearchTree: Equatable {
    public static func == (lhs: BinarySearchTree, rhs: BinarySearchTree) -> Bool {
        isEqual(lhs.root, rhs.root)
    }
    
    private static func isEqual<Element: Equatable>(_ node1: BinaryNode<Element>?, _ node2: BinaryNode<Element>?) -> Bool {
        guard let leftNode = node1, let rightNode = node2 else {
            return node1 == nil && node2 == nil
        }
        
        return leftNode.value == rightNode.value &&
        isEqual(leftNode.leftChild, rightNode.leftChild) &&
        isEqual(leftNode.rightChild, rightNode.rightChild)
    }
}

extension BinarySearchTree where Element: Hashable {
    public func contains(_ subtree: BinarySearchTree) -> Bool {
        var set: Set<Element> = []
        root?.traverseInOrder {
            set.insert($0)
        }
        
        var isEqual = true
        
        subtree.root?.traverseInOrder {
            isEqual = isEqual && set.contains($0)
        }
        return isEqual
    }
}
