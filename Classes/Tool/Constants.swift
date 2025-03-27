//
//  Constants.swift
//
//  Created by MorganChen on 2025/3/26.
//

//Default Settings
let defaultGMEllipticCurve: GMEllipticCurve = GMEllipticCurveSecp256r1
let defaultCompressedPublicKey: Bool = true

enum CurveCryptoECDHKeyCompressType: UInt8 {
    case notCompress = 0x04
}
