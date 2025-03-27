//
//  EcdhStringExtension.swift
//
//  Created by MorganChen on 2025/3/26.
//
extension String {
    
    func hexStrToData() -> Data? {
        let data = NSMutableData(capacity: self.count)
        let regex = try! NSRegularExpression(pattern: "[0-9a-f]{1,2}", options: .caseInsensitive)
        regex.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.count)) { match, flags, stop in
            let byteString = (self as NSString).substring(with: match!.range)
            var num = UInt8(byteString, radix: 16)
            data?.append(&num, length: 1)
        }
        return data as Data?
    }
}
