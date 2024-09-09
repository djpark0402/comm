/*
 * Copyright 2024 Raonsecure
 */

import Foundation

public enum CommunicationLogLevel: String {
    case verbose = "VERBOSE"
    case debug = "DEBUG"
    case info = "INFO"
    case warning = "WARNING"
    case error = "ERROR"
}

public class CommunicationLogger {
    
    public static let shared = CommunicationLogger()
    
    private var logLevel: CommunicationLogLevel = .debug
    private var onOff: Bool = false
    
    private init() {}
    
    public func setEnable(_ onOff: Bool) {
        self.onOff = onOff
    }
    
    public func setLogLevel(_ level: CommunicationLogLevel) {
        self.logLevel = level
    }
    
    public func debug(_ message: String, function: String = #function) {
        log(message, level: .debug, function: function)
    }
    
    public func info(_ message: String, function: String = #function) {
        log(message, level: .info, function: function)
    }
    
    public func warning(_ message: String, function: String = #function) {
        log(message, level: .warning, function: function)
    }
    
    public func verbose(_ message: String, function: String = #function) {
        log(message, level: .verbose, function: function)
    }
    
    public func error(_ message: String, function: String = #function) {
        log(message, level: .error, function: function)
    }
    
    
    private func log(_ message: String, level: CommunicationLogLevel, function: String) {
        if self.onOff == false { return }
        guard shouldLog(level: level) else { return }
        print("▶️[\(level.rawValue)]◀️ \(function): \(message)")
    }
    
    private func shouldLog(level: CommunicationLogLevel) -> Bool {
        let levels: [CommunicationLogLevel] = [.verbose, .debug, .info, .warning, .error]
        guard let currentIndex = levels.firstIndex(of: logLevel) else { return false }
        guard let levelIndex = levels.firstIndex(of: level) else { return false }
        return levelIndex >= currentIndex
    }
}
