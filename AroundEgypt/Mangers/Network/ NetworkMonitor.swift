//
//   NetworkMonitor.swift
//  AroundEgypt
//
//  Created by Ahmed Mostafa on 30/08/2025.
//

import Foundation
import Network



protocol NetworkMonitorContract {
    var isConnected: Bool { get }
}

final class NetworkMonitor: NetworkMonitorContract {
    private let monitor: NWPathMonitor
    private let queue = DispatchQueue(label: "NetworkMonitor")
    private(set) var isConnected: Bool = false
    
    init() {
        monitor = NWPathMonitor()
        startMonitoring()
    }
    
    private func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
        }
        monitor.start(queue: queue)
    }
}
