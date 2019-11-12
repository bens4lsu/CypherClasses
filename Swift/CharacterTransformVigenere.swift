//
//  CharacterTransformVigenere.swift
//  CypherMate
//
//  Created by Ben Schultz on 9/6/19.
//  Copyright © 2019 com.concordbusinessservicesllc. All rights reserved.
//

import Foundation

class CharacterTransformVigenere {
    
    static let lcLetters: [Character] = {
        let aScalars = "a".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        let letters: [Character] = (0..<26).map {
            Character(UnicodeScalar(aCode + $0)!)
        }
        return letters
    }()
    
    static let ucLetters: [Character] = {
        let aScalars = "A".unicodeScalars
        let aCode = aScalars[aScalars.startIndex].value
        let letters: [Character] = (0..<26).map {
            Character(UnicodeScalar(aCode + $0)!)
        }
        return letters
    }()
    
    private let keyword: String
    
    private func characterSet(for char: Character) -> [Character] {
        switch char {
        case "A" ... "Z":
            return CharacterTransformVigenere.ucLetters
        case "a" ... "z":
            return CharacterTransformVigenere.lcLetters
        default:
            return []
        }
    }
    
    public init(withKeyword keyword: String){
        self.keyword = keyword.lowercased()
    }
    
    public func transformCharacter(_ char: Character, atPosition position: Int) -> Character {
        if keyword.count == 0 {return char}
        
        let letters = characterSet(for: char)
        
        // if it's a character not in one of our letter sets, just return that character back.
        guard let charIndex = letters.firstIndex(of: char) else {return char}

        let position = position % keyword.count
        
        // if our keyword has a character not in our lcLetters set, then just return the input character back without encrypting it.
        guard let letterOffset = CharacterTransformVigenere.lcLetters.firstIndex(of: keyword[position]) else {return char}
        
        let newOffset = charIndex + letterOffset >= 26 ? charIndex + letterOffset - 26 : charIndex + letterOffset
        
        print ("\(charIndex) \(letterOffset)")
        return letters[newOffset]
    }
    
    public func unTransformCharacter(_ char: Character, atPosition position: Int) -> Character {
        if keyword.count == 0 {return char}
        
        let letters = characterSet(for: char)
        
        // if it's a character not in one of our letter sets, just return that character back.
        guard let charIndex = letters.firstIndex(of: char) else {return char}
        
        let position = position % keyword.count
        
        // if our keyword has a character not in our lcLetters set, then just return the input character back without encrypting it.
        guard let letterOffset = CharacterTransformVigenere.lcLetters.firstIndex(of: keyword[position]) else {return char}
        
        let newOffset = charIndex - letterOffset < 0 ? charIndex - letterOffset + 26 : charIndex - letterOffset
        return letters[newOffset]
    }
}
