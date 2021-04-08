//
//  DivingBoardController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/7.
// https://leetcode-cn.com/problems/diving-board-lcci/
/**
 你正在使用一堆木板建造跳水板。有两种类型的木板，其中长度较短的木板长度为shorter，长度较长的木板长度为longer。你必须正好使用k块木板。编写一个方法，生成跳水板所有可能的长度。

 返回的长度需要从小到大排列。
    输入：
        shorter = 1
        longer = 2
        k = 3
        输出： [3,4,5,6]
    解释：
        可以使用 3 次 shorter，得到结果 3；使用 2 次 shorter 和 1 次 longer，得到结果 4 。以此类推，得到最终结果。

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/diving-board-lcci
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 */
import UIKit

class DivingBoardController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.divingBoard(2, 2, 0))
            
        }
    }
    func divingBoard(_ shorter: Int, _ longer: Int, _ k: Int) -> [Int] {
        if k <= 0 {
            return [Int]()
        }
        if shorter == longer {
            return [k * shorter]
        }
        var shorterNum = k
        var nums: [Int] = []
        // shorter * shorterNum + longer * longerNum
        for index in 0..<k+1 {
            nums.append(shorter * shorterNum + longer * index)
            shorterNum -= 1
        }
        return nums
    }


}
