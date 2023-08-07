//
//  WebSocketClient.swift
//  StrawberryManager
//
//  Created by Nguyễn Ngọc Trần Tiến on 08/07/2023.
//

import Foundation
import Starscream

class WebSocketClient: WebSocketDelegate {
    let serverURL = URL(string: "ws://your-server-url")!
    var socket: WebSocket?
    
    init() {
        socket = WebSocket(url: serverURL)
        socket?.delegate = self
        socket?.connect()
    }
    
    func sendStats(stats: String) {
        if let socket = socket, socket.isConnected {
            let message = "{\"stats\": \"\(stats)\"}"
            socket.write(string: message)
        }
    }
    
    // WebSocketDelegate methods
    func websocketDidConnect(socket: WebSocketClient) {
        print("WebSocket connected")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("WebSocket disconnected: \(error?.localizedDescription ?? "Unknown error")")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        if let data = text.data(using: .utf8) {
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: String],
               let stats = json["stats"] {
                print("Received stats: \(stats)")
                // Update UI with the received stats
            }
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        // Handle received data, if needed
    }
    
    deinit {
        socket?.disconnect()
        socket?.delegate = nil
    }
}

// Usage:
let webSocketClient = WebSocketClient()
webSocketClient.sendStats(stats: "Sample stats")

