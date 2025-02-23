//
//  AIService.swift
//  YouTubeQuizGenerator
//
//  Created by Shinjan Saha on 23/02/25.
//

import Foundation

struct AIService {
    static let apiKey = "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"  // Replace with your actual API key
    
    static func generateQuiz(from transcript: String, completion: @escaping ([String]?) -> Void) {
        let apiURL = "https://api.openai.com/v1/completions"
        let prompt = "Generate 5 quiz questions from the following transcript:\n\n\(transcript)"
        
        let parameters: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": prompt,
            "max_tokens": 200
        ]
        
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let choices = json["choices"] as? [[String: Any]],
               let text = choices.first?["text"] as? String {
                let questions = text.components(separatedBy: "\n").filter { !$0.isEmpty }
                completion(questions)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

