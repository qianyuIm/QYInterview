//
//  GenerateMatrixController.swift
//  QYInterview
//
//  Created by cyd on 2022/1/18.
// 59. 螺旋矩阵 II
// https://leetcode-cn.com/problems/spiral-matrix-ii/
/**
 
 给定一个正整数 n，生成一个包含 1 到  **n^2**  所有元素，且元素按顺时针顺序螺旋排列的正方形矩阵。

 示例:

 输入: 3 输出: [ [ 1, 2, 3 ], [ 8, 9, 4 ], [ 7, 6, 5 ] ]

 #
 */

import UIKit

class GenerateMatrixController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let new = generateMatrix(5)
        logDebug(new)
    }
    func generateMatrix(_ n: Int) -> [[Int]] {
        var result = [[Int]](repeating: [Int](repeating: 0, count: n), count: n)

        var startRow = 0
        var startColumn = 0
        var loopCount = n / 2
        let mid = n / 2
        var count = 1
        var offset = 1
        var row: Int
        var column: Int

        while loopCount > 0 {
            row = startRow
            column = startColumn

            for c in column ..< startColumn + n - offset {
                result[startRow][c] = count
                count += 1
                column += 1
            }

            for r in row ..< startRow + n - offset {
                result[r][column] = count
                count += 1
                row += 1
            }

            for _ in startColumn ..< column {
                result[row][column] = count
                count += 1
                column -= 1
            }

            for _ in startRow ..< row {
                result[row][column] = count
                count += 1
                row -= 1
            }

            startRow += 1
            startColumn += 1
            offset += 2
            loopCount -= 1
        }

        if (n % 2) != 0 {
            result[mid][mid] = count
        }
        return result
    }
    
}
