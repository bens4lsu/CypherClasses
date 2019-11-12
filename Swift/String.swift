//
//  String.swift
//  CypherMate
//
//  Created by Ben Schultz on 9/6/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import Foundation

extension String {
    
    subscript (i: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: i)]
    }
    
    func transformVigenere(byKeyword keyword: String) -> String {
        if self.count == 0 { return "" }
        let transformer = CharacterTransformVigenere(withKeyword: keyword)
        var encrypted = ""
        for i in (0...self.count - 1) {
            encrypted += String(transformer.transformCharacter(self[i], atPosition: i))
        }
        return encrypted
    }
    
    func unTransformVigenere(byKeyword keyword: String) -> String {
        if self.count == 0 { return "" }
        let transformer = CharacterTransformVigenere(withKeyword: keyword)
        var decrypted = ""
        for i in (0...self.count - 1) {
            decrypted += String(transformer.unTransformCharacter(self[i], atPosition: i))
        }
        return decrypted
    }
}
