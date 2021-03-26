//
//  Block.c
//  Block
//
//  Created by cyd on 2021/3/25.
//

#include "Block.h"
int create() {
    __block int num = 10;
    void (^myBlock)(void) = ^{
        num++;
        printf("%d", num);
    };
    myBlock();
    return  0;
}

