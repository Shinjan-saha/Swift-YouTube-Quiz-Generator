//
//  AIService.swift
//  YouTubeQuizGenerator
//
//  Created by Shinjan Saha on 23/02/25.
//

import Foundation

struct AIService {
    
    
    static var apiKey: String {
        if let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
           let dict = NSDictionary(contentsOfFile: path),
           let key = dict["OpenAIAPIKey"] as? String {
            return key
        }
        return ""
    }

   
    static func generateQuiz(from transcript: String, completion: @escaping ([String]?) -> Void) {
        let apiURL = "https://api.openai.com/v1/completions"
        let prompt = "Generate 5 quiz questions from the following transcript:\n\n\(transcript)"
        
        let parameters: [String: Any] = [
            "model": "text-davinci-003",
            "prompt": prompt,
            "max_tokens": 200,
            "temperature": 0.7
        ]
        
        guard let url = URL(string: apiURL) else {
            print("Invalid API URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            print("Error encoding JSON: \(error.localizedDescription)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error making API request: \(error.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data received")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let text = choices.first?["text"] as? String {
                    let questions = text.components(separatedBy: "\n").filter { !$0.isEmpty }
                    completion(questions)
                } else {
                    print("Invalid API response")
                    completion(nil)
                }
            } catch {
                print("Error parsing JSON: \(error.localizedDescription)")
                completion(nil)
            }
        }.resume()
    }
}
