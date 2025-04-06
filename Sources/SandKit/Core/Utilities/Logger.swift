//
//  Logger.swift
//  SandKit
//
//  Created by Ritesh Pakala on 3/29/25.
//

import Foundation
package enum SandLogLevel: Int32, CustomStringConvertible {
    case panic = 0
    case fatal = 8
    case error = 16
    case warning = 24
    case info = 32
    case verbose = 40
    case debug = 48
    case trace = 56

    package var description: String {
        switch self {
        case .panic:
            return "panic"
        case .fatal:
            return "fault"
        case .error:
            return "error"
        case .warning:
            return "warning"
        case .info:
            return "info"
        case .verbose:
            return "verbose"
        case .debug:
            return "debug"
        case .trace:
            return "trace"
        }
    }
}

package extension SandLogLevel {
    static var level: SandLogLevel = .debug
}

@inline(
    __always
) package func SandLog(
    _ message: CustomStringConvertible,
    level: SandLogLevel = .debug,
    file: String = #file,
    function: String = #function,
    line: Int = #line
) {
    if level.rawValue <= SandLogLevel.level.rawValue {
        let fileName = (file as NSString).lastPathComponent
        print("[SandKit] | \(level) | \(fileName):\(line) \(function) | \(message)")
    }
}
