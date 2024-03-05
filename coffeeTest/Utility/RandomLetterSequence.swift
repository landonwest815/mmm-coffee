//
//  RandomLetterSequence.swift
//  coffeeTest
//
//  Created by Landon West on 3/5/24.
//

import Foundation

// Adjust letter frequencies to use Character keys directly for simplicity
let letterFrequencies: [Character: Int] = [
    "A": 42, "B": 10, "C": 23, "D": 17, "E": 56, "F": 9, "G": 12, "H": 15, "I": 38,
    "J": 1, "K": 6, "L": 27, "M": 15, "N": 33, "O": 36, "P": 16, "Q": 1, "R": 38,
    "S": 29, "T": 35, "U": 18, "V": 5, "W": 6, "X": 1, "Y": 9, "Z": 1
]

// Define vowels as Characters for consistency
let vowels: [Character] = ["A", "E", "I", "O", "U"]

// Function to generate a weighted list of letters
func generateWeightedList(from frequencies: [Character: Int]) -> [Character] {
    var list: [Character] = []
    for (letter, count) in frequencies {
        list += Array(repeating: letter, count: count)
    }
    return list
}

// Filter out consonant frequencies using Characters
let consonantsFrequencies = letterFrequencies.filter { !vowels.contains($0.key) }

// Generate weighted lists for vowels and consonants
var vowelsList = generateWeightedList(from: letterFrequencies.filter { vowels.contains($0.key) })
var consonantsList = generateWeightedList(from: consonantsFrequencies)

func randomLetter(vowelsNeeded: Int, consonantsNeeded: Int) -> String {
    var selectedLetters: [Character] = []
    
    // Select vowels
    for _ in 0..<vowelsNeeded {
        if let vowel = vowelsList.randomElement() {
            selectedLetters.append(vowel)
            vowelsList.removeAll(where: { $0 == vowel }) // Ensure uniqueness
        }
    }
    
    // Select consonants
    for _ in 0..<consonantsNeeded {
        if let consonant = consonantsList.randomElement() {
            selectedLetters.append(consonant)
            consonantsList.removeAll(where: { $0 == consonant }) // Ensure uniqueness
        }
    }
    
    // Shuffle the selected letters to randomize order
    selectedLetters.shuffle()
    
    // Convert array back to string
    return String(selectedLetters)
}
