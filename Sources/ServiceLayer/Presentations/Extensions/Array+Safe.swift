//
//  Array+Safe.swift
//  Tonywin
//
//  Created by Andrey Polyashev on 9/29/23.
//

import Foundation

extension Array {
    
    public subscript(safe index: Int) -> Element? {
        if 0..<count ~= index {
            return self[index]
        }
        return nil
    }
}
