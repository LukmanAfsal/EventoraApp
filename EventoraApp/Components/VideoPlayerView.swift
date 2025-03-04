//
//  VideoPlayerView.swift
//  EventoraApp
//
//  Created by jeboy on 13/02/25.
//




import SwiftUI
import AVKit

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

class PlayerUIView: UIView {
    private var playerLayer = AVPlayerLayer()
    private var player: AVPlayer?

    init(videoName: String) {
        super.init(frame: .zero)
        setupPlayer(with: videoName)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func setupPlayer(with videoName: String) {
        guard let path = Bundle.main.path(forResource: videoName, ofType: "mp4") else {
            print("Error: Video file not found")
            return
        }

        let url = URL(fileURLWithPath: path)
        player = AVPlayer(url: url)
        playerLayer.player = player
        playerLayer.videoGravity = .resizeAspectFill  // Change to .resize if you want it fully inside
        layer.addSublayer(playerLayer)

        // Loop the video
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player?.currentItem, queue: .main) { _ in
            self.player?.seek(to: .zero)
            self.player?.play()
        }

        player?.play()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        playerLayer.frame = bounds  // Update frame to match the SwiftUI-provided size
    }
}




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
