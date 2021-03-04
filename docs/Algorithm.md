# 算法


## 常用的排序算法
 <details>
  <summary>冒泡排序: 两个for循环，以此比较相邻的数据，将小数据放在前，大数据放在后</summary>
  
  ```
  void bubbleSort(NSMutableArray *arr_M) {
    for (int i = 0; i < arr_M.count; ++i) {
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        NSLog(@"第 %d 轮冒泡:",i + 1);
        for (int j = 0; j < arr_M.count - 1 - i; ++j) {
            NSLog(@"第 %d 轮排序:",j + 1);
            //根据索引的`相邻两位`进行`比较`
            if ([arr_M[j] compare:arr_M[j+1]] == NSOrderedDescending) {
                [arr_M exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
    }
    NSLog(@"最终结果：%@",arr_M);
}
/// 优化后算法-从第一个开始排序，空间复杂度相对更大一点
void bubbleSortOptimize(NSMutableArray *arr) {
    for (int i = 0; i < arr.count; ++i) {
        NSLog(@"第 %d 轮冒泡:",i + 1);
        bool flag = false;
        //遍历数组的每一个`索引`（不包括最后一个,因为比较的是j+1）
        for (int j = 0; j < arr.count-1-i; ++j) {
            NSLog(@"第 %d 轮排序:",j + 1);
            //根据索引的`相邻两位`进行`比较`
            if ([arr[j+1] intValue] < [arr[j] intValue]) {
                flag = true;
                [arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
            }
        }
        if (!flag) {
            NSLog(@"跳出 %d",i);
            break;//没发生交换直接退出，说明是有序数组
        }
    }
    NSLog(@"最终结果：%@",arr);
}
  ```
</details>

<details>
  <summary>选择排序:在选择排序过程中，数组被分为有序和无序两个部分。而选择排序中的**“选择”**指的是不断从无序序列中选择最小的值放入都有序序列的最后一个位置，换句话说就是从现有的无序序列中找出最小的值，然后与无序序列的第一个值进行交换，并缩小无序序列的范围。因为有序序列的最后一个值与无序序列的第一个值紧挨着，交换后，这个无序序列的第一个值就变为了有序序列的最后一个值。重复这个选择的过程，我们的数组就会变为有序的了</summary>
  
  ```
  void selectionSort(NSMutableArray *arr_M) {
    
    for (int i = 0; i < arr_M.count; i++) {
        // 默认当前第一个元素为最小值（有序数列），剩下的元素中找到一个最小值 然后交换有序最后一个与无序数列最小值的位置
        // 重复下来后有序数列就是从小到大的排序了
        // 记录最小值
        NSInteger min = [arr_M[i] integerValue];
        // 记录最小值位置
        int minIndex = i;
        for (int j = i + 1; j < arr_M.count; j++) {
            NSInteger current = [arr_M[j] integerValue];
            // 无序数列中找到最小值
            if (current < min) {
                minIndex = j;
                min = current;
            }
        }
        // 交换
        [arr_M exchangeObjectAtIndex:i withObjectAtIndex:minIndex];
    }
    NSLog(@"%@",arr_M);
}
  ```
 </details>
 
 <details>
  <summary>插入排序:也是将要排序的数组分为两部分。前部分是已经排好序的，后部分是无序的。插入排序中的**"插入"**指的是**从无序数列中取出第一个值，插入到有序数列的相应位置**。其实这个插入的过程就是不断比较和交换的过程。</summary>
  
  ```
  void insertSort(NSMutableArray *arr_M) {
    // 循环无序数列
    for (int i = 1; i < arr_M.count; i++) {
        NSLog(@"第 %d 轮插入  插入的数值为 %ld",i,(long)[arr_M[i] integerValue]);
        // 倒序循环有序数列
        int j = i; // 1 .. arr_M.count
        while (j > 0) {
            // 遍历有序数列插入相应的值
            // arr_M[1] < arr_M[0]
            if ([arr_M[j] integerValue] < [arr_M[j - 1] integerValue]) {
                // 交换
                [arr_M exchangeObjectAtIndex:j withObjectAtIndex:j - 1];
                j -= 1;
            } else {
                break;
            }
        }
    }
    NSLog(@"%@",arr_M);
}
  ```
  </details>
  
  <details>
  <summary>希尔排序:希尔排序又叫缩小增量排序，是插入排序的升级版。大体步骤为先将无序序列按照一定的步长(增量)分为几组，分别将这几组中的数据通过插入排序的方式将其进行排序。然后缩小步长(增量)分组，然后将组内的数据再次进行排序，直到增量为1为止。经过上述步骤，我们的序列就是有序的了，插入排序就是增量为1的希尔排序.**时间复杂度----O(n^(3/2))**</summary>
  
  ```
  void HillSorting(NSMutableArray *arr_M) {
    // 设置增量
    int count = (int)arr_M.count;
    int step = count / 2;
    while (step > 0) {
        for (int i = 0; i < count; i++) {
            int j = i + step;
            while (j >= step && j < count) {
                NSInteger right = [arr_M[j] integerValue];
                NSInteger left = [arr_M[j - step] integerValue];
                if (right < left) {
                    [arr_M exchangeObjectAtIndex:j withObjectAtIndex:j - step];
                    j = j - step;
                } else{
                    break;
                }
            }
        }
        // 缩小增量
        step = step/2;
    }
    NSLog(@"%@",arr_M);
}
  
  ```
  </details>
  
  <details>
  <summary>快速排序:1.先从数列中取出一个数作为基准数；2.分区过程，将比这个数大的数全放到它的右边，小于或等于它的数全放到它的左边；3.再对左右区间重复第二步，直到各区间只有一个数。</summary>
  > 快速排序之所比较快，因为相比冒泡排序，每次交换是跳跃式的。每次排序的时候设置一个基准点，将小于等于基准点的数全部放到基准点的左边，将大于等于基准点的数全部放到基准点的右边。这样在每次交换的时候就不会像冒泡排序一样每次只能在相邻的数之间进行交换，交换的距离就大的多了。因此总的比较和交换次数就少了，速度自然就提高了。当然在最坏的情况下，仍可能是相邻的两个数进行了交换。因此快速排序的最差时间复杂度和冒泡排序是一样的都是O(N2)，它的平均时间复杂度为O(NlogN)。

```
// 快排的思想：
// 1. 选出一个基数 quickSortStepTwo 保证左边比基数小，右边比基数大
// 2. 递归调用就好
void quickSort(NSMutableArray *arr_M,int indexL,int indexH) {
    //元素比较少时采用插入排序
     if (indexL >= indexH) return;
     // 取出每次分段的位置
     int index = quickSortStep(arr_M, indexL, indexH);
     NSLog(@"index = %d == %ld",index,[arr_M[index] integerValue]);
     // 左
     //对从最低位索引indexL到分界处索引index前一位的元素递归进行分割操作
     quickSort(arr_M, indexL, index-1);
     // 右
     //对分界处索引index的后一位到末尾索引indexH进行递归分割操作
     quickSort(arr_M, index + 1, indexH);
    NSLog(@"%@",arr_M);
}
/// 对arr[indexL...indexH]部分进行partition操作
//  返回index, 使得arr[indexL...p-1] < arr[index] ; arr[p+1...indexH] > arr[index]
int quickSortStep(NSMutableArray *arr_M,int indexL,int indexH) {
    // 记录基准位置
    int index = indexL;
    // 记录基准参数
    NSInteger key = [arr_M[indexL] integerValue];
    for (int i = indexL + 1; i <= indexH; i++) {
        //如果当前元素小于开始选取的第一个元素，则交换索引index+1和index的元素，同时index自增1.
        if ([arr_M[i] integerValue] < key) {
            [arr_M exchangeObjectAtIndex:index + 1 withObjectAtIndex:i];
            index++;
        }
    }
    //全部遍历完成后，交换索引indexL与j的元素，将第一个元素放到正确的位置
    [arr_M exchangeObjectAtIndex:indexL withObjectAtIndex:index];
    NSLog(@"-----%d",index);
    return index;
}


```
  </details>
  
  <details>
  <summary>双路快排序:</summary>
  
  ```
void dualQuickSort(NSMutableArray *arr_M) {
    dualQuickSortOne(arr_M, 0, (int)arr_M.count-1);
    NSLog(@"%@",arr_M);
}
void dualQuickSortOne(NSMutableArray *arr_M,int low,int height) {
    //元素比较少时采用插入排序
    if (low >= height) return;
    // 取出索引
    int index = dualQuickSortTwo(arr_M, low, height);
    dualQuickSortOne(arr_M, low, index-1);
    dualQuickSortOne(arr_M, index + 1, height);
}
int dualQuickSortTwo(NSMutableArray *arr_M,int low,int height) {
    // 标记两个索引 左右两边同时开始
    int left = low + 1;
    int right = height;
    // 参数 基准
    NSInteger key = [arr_M[low] integerValue];
    while (true) {
        // 从左边开始 都要小于key
        while (left <= height && [arr_M[left] integerValue] < key) {
            left++;
        }
        // 右边开始  都要大于 key
        while (right >= low+1 && [arr_M[right] integerValue] > key) {
            right--;
        }
        // 跳出循环
        if (left > right) {
            break;
        }
        // 交换left 和 right的数值
        [arr_M exchangeObjectAtIndex:left withObjectAtIndex:right];
        left++;
        right--;
    }
    // 交换
    [arr_M exchangeObjectAtIndex:low withObjectAtIndex:right];
    return right;
}


  ```
  </details>
  
  <details>
  <summary>三路快排序:</summary>
  
  ```
void quickSort3(NSMutableArray *array) {
    quickSort3One(array, 0,(int)array.count-1);
    NSLog(@"%@",array);
}

void quickSort3One(NSMutableArray *array,int left, int right){
    //元素比较少时采用插入排序
//    if (right - left <= 15) {
        //元素比较少时采用插入排序
//        [self insertionSort3:array left:left right:right];
//        return;
//    }
    if (left >= right)  return;

    //lt是小于V的最后一个元素索引，gt是大于V的第一个索引也就是说lt和gt是分水岭
    int lt = left;
    int gt = right + 1;
    int i = left + 1;
    //快速排序第二个优化 标定点取随机数
//    int randonNum = arc4random() % (right - left + 1) + left;
//    [array exchangeObjectAtIndex:left withObjectAtIndex:randonNum];
    //定义标定点
    NSInteger V = [array[left] integerValue];
    //当i小于gt时 就一直循环，当i >= gt证明所有元素考察结束了
    while (i < gt) {
        if ([array[i] integerValue] < V) {//小于V时将考察的元素放到lt的下一个位置
            [array exchangeObjectAtIndex:lt + 1 withObjectAtIndex:i];
            //继续往后走
            i++;
            //维护lt索引
            lt++;
        }else if ([array[i] integerValue] > V){//当大于V时就要元素放置到大于V的部分
            [array exchangeObjectAtIndex:gt - 1 withObjectAtIndex:i];
            //维护gt索引
            gt--;
        }else {//这里就是等于V的部分 ，只需要让i继续往后走即可
            i++;
        }
    }
    //将基准点放置到它合适的位置
    [array exchangeObjectAtIndex:left withObjectAtIndex:lt];
    //继续将小于V的
    quickSort3One(array, left, lt);
    //继续大于V的部分
    quickSort3One(array, gt, right);
}

  ```
  </details>

