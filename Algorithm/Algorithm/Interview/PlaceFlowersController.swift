//
//  PlaceFlowersController.swift
//  Algorithm
//
//  Created by cyd on 2021/4/8.
//
/**
 假设有一个很长的花坛，一部分地块种植了花，另一部分却没有。可是，花不能种植在相邻的地块上，它们会争夺水源，两者都会死去。

 给你一个整数数组  flowerbed 表示花坛，由若干 0 和 1 组成，其中 0 表示没种植花，1 表示种植了花。另有一个数 n ，能否在不打破种植规则的情况下种入 n 朵花？能则返回 true ，不能则返回 false。

 示例 1：
    输入：flowerbed = [1,0,0,0,1], n = 1
    输出：true
 
 示例 2：
    输入：flowerbed = [1,0,0,0,1], n = 2
    输出：false
  
 提示：

    1 <= flowerbed.length <= 2 * 104
    flowerbed[i] 为 0 或 1
    flowerbed 中不存在相邻的两朵花
    0 <= n <= flowerbed.length

 来源：力扣（LeetCode）
 链接：https://leetcode-cn.com/problems/can-place-flowers
 著作权归领扣网络所有。商业转载请联系官方授权，非商业转载请注明出处。
 
 */
import UIKit

class PlaceFlowersController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.touchesBeganBlock = { [weak self] in
            guard let self = self else { return }
            logDebug(self.canPlaceFlowers([1,0,0,0,1], 3))
        }
        
    }
    func canPlaceFlowers(_ flowerbed: [Int],
                         _ n: Int) -> Bool {
        
        
        return true
    }
}
