#include <stdio.h>
#include <stdlib.h>

int* twoSum(int* nums, int numsSize, int target, int* returnSize) {
    for (int i = 0; i < numsSize; i++) {
        for (int j = i + 1; j < numsSize; j++) {
            if (nums[j] == target - nums[i]) {
                *returnSize = 2;
                int* res = (int*)malloc(2 * sizeof(int));
                res[0] = i;
                res[1] = j;
                return res;
            }
        }
    }
    *returnSize = 0;
    return NULL;
}

int main() {
    int nums[1000];
    int target;
    int n = 0;

    // 读取格式： [ 数字,数字,数字 ]
    char ch;
    // 吃掉 [
    scanf("%c", &ch);

    // 读取数组
    while (1) {
        scanf("%d", &nums[n++]);
        scanf("%c", &ch);
        if (ch == ']') break;
    }

    // 读取目标值
    scanf("%d", &target);

    int returnSize;
    int* res = twoSum(nums, n, target, &returnSize);

    if (res != NULL) {
        printf("[%d,%d]\n", res[0], res[1]);
        free(res);
    } else {
        printf("no solution\n");
    }

    return 0;
}