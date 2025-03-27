//
//  EcdhDataExtension.swift
//
//  Created by MorganChen on 2025/3/26.
//

extension Data {
    
    static func data(byte: UInt8) -> Data {
        return Data(bytes: [byte], count: 1)
    }
}
