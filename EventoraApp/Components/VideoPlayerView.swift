//
//  VideoPlayerView.swift
//  EventoraApp
//
//  Created by Abhinand K J on 13/02/25.
//

import SwiftUI
import AVKit

// MARK: - VideoPlayerView
struct VideoPlayerView: UIViewRepresentable {
    var videoName: String

    func makeUIView(context: Context) -> PlayerUIView {
        let view = PlayerUIView(videoName: videoName)
        return view
    }

    func updateUIView(_ uiView: PlayerUIView, context: Context) {
        // Update if needed
    }
}

// MARK: - PlayerUIView
class PlayerUIView: UIView {
    // MARK: - Properties
    private var playerLayer = AVPlayerLayer()
    private var player: AVPlayer?

    // MARK: - Initializer
    init(videoName: String) {
        super.init(frame: .zero)
        setupPlayer(with: videoName)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: - Setup Player
    private func setupPlayer(with videoName: String) {
        // Load video from bundle
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            print("Error: Video file not found")
            return
        }

        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill  // Adjust video gravity as needed
        layer.addSublayer(playerLayer)

        // Loop the video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { _ in
            self.player?.seek(to: .zero)
            self.player?.play()
        }

        player?.play()
    }

    // MARK: - Layout Subviews
    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds  // Update frame to match the SwiftUI-provided size
    }
}

//import SwiftUI
//import AVKit
//
//struct VideoPlayerView: UIViewRepresentable {
//    var videoName: String
//
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//
//        // Get the path to the video file
//        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
//            print("Error: Video file not found")
//            return view
//        }
//        print("Video file found at path: \(path)")
//
//        // Create an AVPlayer with the video URL
//        let url = URL(fileURLWithPath: path)
//        let player = AVPlayer(url: url)
////        player.actionAtItemEnd = .none
//
//        // Create an AVPlayerLayer and add it to the view
//        let playerLayer = AVPlayerLayer(player: player)
//        playerLayer.frame = UIScreen.main.bounds
//        playerLayer.videoGravity = .resizeAspectFill
//        view.layer.addSublayer(playerLayer)
//
//        // Loop the video
//        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
//            player.seek(to: .zero)
//            player.play()
//        }
//
//        // Start playing the video
//        player.play()
//
//        return view
//    }
//
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // Update the view if needed
//    }
//}
//
//


//struct VideoBackgroundView: View {
//    var body: some View {
//        if let url = Bundle.main.url(forResource: "vid-splash", withExtension: "mp4") {
//            let player = AVPlayer(url: url)
//            VideoPlayer(player: player)
//                .onAppear {
//                    player.play()
//                    // Loop the video
//                    NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
//                        player.seek(to: .zero)
//                        player.play()
//                    }
//                }
//                .aspectRatio(contentMode: .fill)
//                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
//                .overlay(Color.black.opacity(0.2))
//                .edgesIgnoringSafeArea(.all)
//        } else {
//            Color.black // Fallback in case video fails to load
//        }
//    }
//}
