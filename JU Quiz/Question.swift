//
//  Question.swift
//  JU Quiz
//
//  Created by hawkar on 2020-11-16.
//

import Foundation

struct Question: Decodable {
    
    enum QuestionType: String, Decodable{
        case multiple
    }
    
    enum Difficulty: String, Decodable{
        case easy, medium, hard
    }
    let category: String
    let type: QuestionType
    let difficulty: Difficulty
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]
    
}
