//
//  AVPlayer+Ding.swift
//  Scrumdinger
//
//  Created by Cyrus on 4/4/2022.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else {
            fatalError("Failed to find the sound file – ding.wav")
        }
        return AVPlayer(url:url)
    }()
}
