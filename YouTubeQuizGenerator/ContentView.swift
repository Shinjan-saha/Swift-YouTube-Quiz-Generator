//
//  ContentView.swift
//  YouTubeQuizGenerator
//
//  Created by Shinjan Saha on 23/02/25.
//

import SwiftUI

struct ContentView: View {
    @State private var youtubeURL: String = ""
    @State private var quizQuestions: [String] = []
    @State private var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                TextField("Enter YouTube Video URL", text: $youtubeURL)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: fetchQuizQuestions) {
                    Text("Generate Quiz")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .disabled(isLoading)

                if isLoading {
                    ProgressView("Generating...")
                } else {
                    List(quizQuestions, id: \.self) { question in
                        Text(question)
                    }
                }
            }
            .navigationTitle("YouTube Quiz Generator")
            .padding()
        }
    }

    func fetchQuizQuestions() {
        guard let videoID = extractVideoID(from: youtubeURL) else {
            return
        }
        isLoading = true
        YouTubeService.fetchTranscript(videoID: videoID) { transcript in
            if let transcript = transcript {
                AIService.generateQuiz(from: transcript) { questions in
                    DispatchQueue.main.async {
                        self.quizQuestions = questions ?? []
                        self.isLoading = false
                    }
                }
            } else {
                isLoading = false
            }
        }
    }

    func extractVideoID(from url: String) -> String? {
        if let regex = try? NSRegularExpression(pattern: "v=([\\w-]+)", options: []) {
            let range = NSRange(location: 0, length: url.utf16.count)
            if let match = regex.firstMatch(in: url, options: [], range: range) {
                if let videoRange = Range(match.range(at: 1), in: url) {
                    return String(url[videoRange])
                }
            }
        }
        return nil
    }
}

