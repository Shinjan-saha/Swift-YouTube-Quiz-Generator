//
//  YouTubeService.swift
//  YouTubeQuizGenerator
//
//  Created by Shinjan Saha on 23/02/25.
//

import Foundation

struct YouTubeService {
    static func fetchTranscript(videoID: String, completion: @escaping (String?) -> Void) {
        let apiURL = "https://youtubetranscript.com/?video_id=\(videoID)"
        
        guard let url = URL(string: apiURL) else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching transcript:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }
            
            if let transcript = String(data: data, encoding: .utf8) {
                completion(transcript)
            } else {
                completion(nil)
            }
        }.resume()
    }
}

