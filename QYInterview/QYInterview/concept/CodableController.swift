//
//  CodableController.swift
//  QYInterview
//
//  Created by cyd on 2021/3/8.
//

import UIKit
import HandyJSON

class CodableModel: Codable {
    var names: String = ""
    var age: Int = 0
    /// 自定义字段属性
    /// 注意 1.需要遵守Codingkey  2.每个字段都要枚举
    private enum CodingKeys: String, CodingKey {
        case names = "name"
        case age
    }
    
}

    
class HandyModel: HandyJSON {
    var names: String = ""
    var age: Int = 0
    required init() {}
    func mapping(mapper: HelpingMapper) {
        
        mapper <<<
            self.names <-- "name"
    }
    
}

class CodableController: BaseViewController {
    let json = """
    {
        "name": "xiaohong",
        "age": 10
    }
    """
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        testHandyJSON()
        testCodable()
    }
    func testHandyJSON() {
        let model = HandyModel.deserialize(from: json)
        logDebug(model?.age)
    }
    func testCodable() {
        do {
            let model = try JSONDecoder().decode(CodableModel.self, from: json.data(using: .utf8)!)
            logDebug(model.age)
        } catch  {
            logDebug(error.localizedDescription)
        }
    }
}
