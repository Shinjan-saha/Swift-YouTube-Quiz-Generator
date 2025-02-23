//
//  YouTubeService.swift
//  YouTubeQuizGenerator
//
//  Created by Shinjan Saha on 23/02/25.
//

import Foundation

struct YouTubeService {
    static func fetchTranscript(videoID: String, completion: @escaping (String?) -> Void) {
        let apiURL = "https://your-transcript-api.com/get?video_id=\(videoID)"  // Replace with actual API
        
        guard let url = URL(string: apiURL) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let transcript = String(data: data, encoding: .utf8) {
                completion(transcript)
            } else {
                completion(nil)
            }
        }.resume()
    }
}
