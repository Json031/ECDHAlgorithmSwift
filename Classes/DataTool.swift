//
//  DataTool.swift
//
//  Created by MorganChen on 2025/3/26.
//


enum CurveCryptoECDHKeyCompressType: UInt8 {
    case notCompress = 0x04
}

class DataTool: NSObject {
    
    class func dataFromHexStr(hexStr: String) -> Data? {
        let data = NSMutableData(capacity: hexStr.count)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: hexStr, options: [], range: NSMakeRange(0, hexStr.count)) { match, flags, stop in
            let byteString = (hexStr as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)
            data?.append(&num, length: 1)
        }
        return data as Data?
    }
}
