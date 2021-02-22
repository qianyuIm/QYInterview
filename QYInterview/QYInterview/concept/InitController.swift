//
//  InitController.swift
//  QYInterview
//
//  Created by cyd on 2021/2/1.
//

import UIKit

class ModelA {
    var name: String
    /// 指定初始化
    init(name: String) {
        self.name = name
    }
    /// 便利初始化
    convenience init() {
        self.init(name: "unKnow")
    }
    
}
class ModelB: ModelA {
    var quantity: Int
    /// 指定初始化
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    /// 便利初始化
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
    class func getMacAddress() -> String{
    let index  = Int32(if_nametoindex("en0"))
    let bsdData = "en0".data(using: .utf8)!
    var mib : [Int32] = [CTL_NET,AF_ROUTE,0,AF_LINK,NET_RT_IFLIST,index]
    var len = 0;
    if sysctl(&mib,UInt32(mib.count), nil, &len,nil,0) < 0 {
        print("Error: could not determine length of info data structure ")
        return "00:00:00:00:00:00"
    }
    var buffer = [CChar].init(repeating: 0, count: len)
    if sysctl(&mib, UInt32(mib.count), &buffer, &len, nil, 0) < 0 {
        print("Error: could not read info data structure");
        return "00:00:00:00:00:00"
    }
    let infoData = NSData(bytes: buffer, length: len)
    var interfaceMsgStruct = if_msghdr()
    infoData.getBytes(&interfaceMsgStruct, length: MemoryLayout.size(ofValue: if_msghdr()))
    let socketStructStart = MemoryLayout.size(ofValue: if_msghdr()) + 1
    let socketStructData = infoData.subdata(with: NSMakeRange(socketStructStart, len - socketStructStart))
    let rangeOfToken = socketStructData.range(of: bsdData, options: NSData.SearchOptions(rawValue: 0), in: Range.init(uncheckedBounds: (0, socketStructData.count)))
    let start = rangeOfToken?.count ?? 0 + 3
    let end = start + 6
    let range1 = start..<end
    var macAddressData = socketStructData.subdata(in: range1)
    let macAddressDataBytes: [UInt8] = [UInt8](repeating: 0, count: 6)
    macAddressData.append(macAddressDataBytes, count: 6)
    let macaddress = String.init(format: "%02X:%02X:%02X:%02X:%02X:%02X", macAddressData[0], macAddressData[1], macAddressData[2],
                                 macAddressData[3], macAddressData[4], macAddressData[5])
    return macaddress
    }

}
class View1: UIView {
   
    
    
}
class InitController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        let model2 = Model2(sex: 1)
//        logDebug(model2)
        let modelB = ModelB.getMacAddress()
        logDebug(modelB)
        let aa = UIDevice.current.identifierForVendor?.uuidString
        logDebug(aa ?? "")
        // 6E38FB95-E9EA-46A7-821F-0FABD8CB4CEF

    }
}

