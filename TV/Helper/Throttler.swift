//
//  Throttler.swift
//  TV
//
//  Created by Oscar Sundin on 2019-01-17.
//  Copyright © 2019 Oscar Sundin. All rights reserved.
//

import Foundation

class Throttler {
    private let interval: TimeInterval
    private var callback: (() -> Void)?
    private var timer: Timer?

    init(interval: TimeInterval) {
        self.interval = interval
    }

    func call(with callback: @escaping (() -> Void)) {
        if timer == nil {
            self.callback = callback
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(fire), userInfo: nil, repeats: false)
        }
    }

    @objc private func fire() {
        timer?.invalidate()
        timer = nil

        callback?()
        callback = nil
    }

}
