# YouTube Quiz Generator 🎥❓  

A Swift-based iOS app that generates quiz questions from YouTube videos using AI.  
Simply provide a YouTube video link, and the app fetches the transcript, processes it with OpenAI, and returns quiz questions.  

## 🚀 Features  
- 🎮 Fetches **YouTube video transcripts** automatically  
- 🧠 Uses **OpenAI GPT** to generate quiz questions  
- 🔐 Securely **stores API keys** in `Secrets.plist`  
- 📱 Designed for **iOS (Swift)** with async networking  

---

## 🛠️ Setup & Installation  

### 1️⃣ Clone the Repository  
```sh
git clone https://github.com/yourusername/YouTubeQuizGenerator.git
cd YouTubeQuizGenerator
```

### 2️⃣ Open in Xcode  
- Open `YouTubeQuizGenerator.xcodeproj` in Xcode  

### 3️⃣ Add API Keys Securely  
Create a `Secrets.plist` file to store API keys securely:  

1. **In Xcode:** Go to **File → New → Property List**  
2. Name it **Secrets.plist**  
3. Add the following keys:  
   - **Key:** `OpenAIAPIKey` → **Type:** String → **Value:** `"your_openai_api_key_here"`  
   - **Key:** `YouTubeTranscriptAPIKey` → **Type:** String → **Value:** `"your_transcript_api_key_here"`  

🚨 **Important:** Add `Secrets.plist` to `.gitignore` to prevent exposing API keys!

---

## 📝 File Structure  

```
📂 YouTubeQuizGenerator
 ┓ 📂 YouTubeQuizGenerator
 ┃ ┓  AIService.swift          # Handles OpenAI API for quiz generation
 ┃ ┓  YouTubeService.swift     # Fetches video transcript via API
 ┃ ┓  Secrets.plist            # Stores API keys (DO NOT SHARE)
 ┃ ┓  ViewController.swift     # UI & Logic to fetch quiz questions
 ┓  README.md                  # Documentation
 ┓  .gitignore                  # Ignores Secrets.plist & other sensitive files
```

---

## 📼 API Integration  

### **1️⃣ Fetching YouTube Transcript**  
Implemented in `YouTubeService.swift`:
```swift
YouTubeService.fetchTranscript(videoID: "dQw4w9WgXcQ") { transcript in
    print(transcript ?? "Failed to fetch transcript")
}
```

### **2️⃣ Generating Quiz Questions**  
Implemented in `AIService.swift`:
```swift
AIService.generateQuiz(from: "Transcript text here") { questions in
    print(questions ?? "No questions generated")
}
```

---

## 📌 Next Steps  
👉 Improve UI for better user experience 🎨  
👉 Add caching for faster responses ⚡  
👉 Implement **Dark Mode** support 🌙  

---

## 📄 License  
This project is **open-source** under the MIT License.  
Feel free to **contribute & enhance**! 🚀  

---

👨‍💻 **Developed by [Shinjan Saha](https://github.com/yourusername)**  
🔗 **GitHub Repo:** [YouTubeQuizGenerator](https://github.com/yourusername/YouTubeQuizGenerator)  

