//
//  Logger.swift
//  TestApp
//
//  Created by Kaushal Deo on 8/21/19.
//  Copyright © 2019 Scorpion. All rights reserved.
//

import Foundation
import os.log

class Logger {
    private static let model = OSLog(subsystem: "com.kaushal.logger", category: "TestApp")
    
    private static func isDebbugging() -> Bool {
        var info = kinfo_proc()
        var mib: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var size = MemoryLayout.stride(ofValue: info)
        let junk = sysctl(&mib, UInt32(mib.count), &info, &size, nil, 0)
        assert(junk == 0, "sysctl failed")
        return (info.kp_proc.p_flag & P_TRACED) != 0
    }
    
    private class func _log(_ items: Any..., type: OSLogType) {
        let string = items.reduce("") { (result, item) in
            guard let array = item as? [Any] else {
                return result + String(describing: item)
            }
            return array.reduce("", { $0 + String(describing: $1) + " " })
        }
        os_log("%@", log: self.model, type: type, string)
    }
    
    class func log(_ items: Any...) {
        self._log(items, type: .default)
    }
    
    class func info(_ items: Any...) {
        self._log(items, type: .info)
    }
    
    class func error(_ items: Any...) {
        self._log(items, type: .error)
    }
    
    class func debug(_ items: Any...) {
        self._log(items, type: .debug)
    }
    
    class func fault(_ items: Any...) {
        self._log(items, type: .debug)
    }
    
    class func add(path: String) {
        if self.isDebbugging() {
            return
        }
        guard let logPath = path.cString(using: .ascii) else { return }
        freopen(logPath, "a+", stderr)
    }
}

enum LogFile {
    case current
    
    var path: String {
        let string = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString
        return string.appendingPathComponent("Logs.log")
    }
}
