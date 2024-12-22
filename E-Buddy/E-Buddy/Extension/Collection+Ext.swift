//
//  Collection+Ext.swift
//  E-Buddy
//
//  Created by Achmad Fauzan on 22/12/2024.
//

import Foundation

extension Collection {
    public subscript(safe index: Index) -> Element? {
        get {
            guard self.indices.contains(index) else { return nil }
            return self[index]
        }
    }
}
