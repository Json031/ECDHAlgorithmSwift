//
//  DataTool.swift
//
//  Created by MorganChen on 2025/3/26.
//

class DataTool: NSObject {
    
    class func clipData(data: Data, start: Int, endNotInclude: Int) -> Data {
        if start < 0 {
            return data
        }
        if data.count < endNotInclude {
            return data
        }
        return data.subdata(in: start..<endNotInclude)
    }
}
