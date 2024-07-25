//
//  YouTubePlayerView.swift
//  Rolling
//
//  Created by Kevin Lu on 2024/6/13.
//

import SwiftUI
import YouTubeiOSPlayerHelper

struct YouTubePlayerView: UIViewRepresentable {
    let videoID: String
    
    func makeUIView(context: Context) -> YTPlayerView {
        let playerView = YTPlayerView()
        let playerVars = ["controls": "0", "rel": "0"]
        playerView.load(withVideoId: videoID, playerVars: playerVars)
        playerView.delegate = context.coordinator
        return playerView
    }
    
    func updateUIView(_ uiView: YTPlayerView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

class Coordinator: NSObject, YTPlayerViewDelegate {
    var slider = UISlider()
    var playerView: YTPlayerView!
    var parent: YouTubePlayerView
    
    init(_ parent: YouTubePlayerView) {
        self.parent = parent
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.playerView = playerView
        playerView.duration { duration, error in
            self.setupSlider(duration: Float(duration))
        }
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        slider.setValue(playTime, animated: true)
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        switch state {
        case .ended:
            slider.value = 0
        default:
            break
        }
    }
    
    func setupSlider(duration: Float) {
        let sliderThumb = UIImage(systemName: "circle.fill",
                                  withConfiguration: UIImage.SymbolConfiguration(pointSize: 10))
        playerView.addSubview(slider)
        slider.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            slider.leadingAnchor.constraint(equalTo: playerView.leadingAnchor),
            slider.trailingAnchor.constraint(equalTo: playerView.trailingAnchor),
            slider.bottomAnchor.constraint(equalTo: playerView.bottomAnchor, constant: 5)
        ])
        slider.setThumbImage(sliderThumb, for: .normal)
        slider.tintColor = .red
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .gray
        slider.maximumValue = duration
        slider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        playerView.seek(toSeconds: sender.value, allowSeekAhead: true)
    }
}

#Preview {
    YouTubePlayerView(videoID: "LEjhY15eCx0")
}
