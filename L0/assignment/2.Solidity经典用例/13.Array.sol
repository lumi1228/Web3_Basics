// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// Array

// Array can have a compile-time fixed size or a dynamic size.
// 数组可以具有编译时固定大小或动态大小



// contract Array {
//     // Several ways to initialize an array 
//     // 初始化数组的几种方法：

//     uint256[] public arr;
//     uint256[] public arr2 = [1,2,3];

//     // Fixed sized array, all elements initialize to 0
//     // 固定大小的数组，所有元素初始化为0
//     uint256[10] public myFixedSizeArr;

//     function get(uint256 i) public view returns(uint256){
//         return  arr2[i];
//     }

//     // Solidity can return the entire array.But this function should be avoided for
//     // Solidity可以返回整个数组。但是函数应该避免使用这个
//     // arrays that can grow indefinitely in length.
//     // 数组长度可以无限增长的
//     function getArr() public view returns(uint256[] memory){
//         return arr2;
//     }

//     function push(uint256 i) public {
//         arr2.push(i); //追加到数组,这将使数组长度增加1。
//     }
//     function pop() public {
//         arr2.pop(); //从数组中移除最后一个元素，这将使数组长度减少1
//     }

//     function getLength() public view returns(uint256){
//         return arr2.length;
//     }

//      function remove(uint256 _i) public {
//         // Delete does not change the array length.
//         // Delete不会改变数组的长度。

//         // It resets the value at index to it's default value,in this case 0;
//         // 将索引处的值重置为默认值；在本例中为0
//         delete arr2[_i];
//     }

//     function examples() external pure {
//         // create array in memory, only fixed size can be created
//         // 在内存中创建数组，只能创建固定大小的数组
//         uint256[] memory a = new uint256[](5);
//     }
// }


// Examples of removing array element
// 删除数组元素的例子


// Remove array element by shifting elements from right to left
// 通过从右向左移动元素来移除数组元素

contract ArrayRemoveByShifting{
    // [1, 2, 3] -- remove(1) --> [1, 3, 3] --> [1, 3]
    // [1, 2, 3, 4, 5, 6] -- remove(2) --> [1, 2, 4, 5, 6, 6] --> [1, 2, 4, 5, 6]
    // [1, 2, 3, 4, 5, 6] -- remove(0) --> [2, 3, 4, 5, 6, 6] --> [2, 3, 4, 5, 6]
    // [1] -- remove(0) --> [1] --> []

    uint256[] public arr;

    function remove(uint256 _index) public {
        require(_index < arr.length, "index out of bound");

        for (uint256 i = _index; i < arr.length - 1; i++) {
            arr[i] = arr[i + 1];
        }
        arr.pop();
    }
    function test() external {
        arr = [1, 2, 3, 4, 5];
        remove(2);
        // [1, 2, 4, 5]
        assert(arr[0] == 1);
        assert(arr[1] == 2);
        assert(arr[2] == 4);
        assert(arr[3] == 5);
        assert(arr.length == 4);

        arr = [1];
        remove(0);
        // []
        assert(arr.length == 0);
    }

}

// Remove array element by copying last element into to the place to remove
// 通过将最后一个元素复制到要删除的位置来删除数组元素
contract ArrayReplaceFromEnd {
    uint256[] public arr;

    // Deleting an element creates a gap in the array.
    // 删除一个元素会在数组中创建一个空白。
    // One trick to keep the array compact is to move the last element into the place to delete.
    // 保持数组紧凑的一个技巧是将最后一个元素移到要删除的位置。
    
    function remove(uint256 index) public {
    //
        // Move the last element into the place to delete
        arr[index] = arr[arr.length - 1];
        // Remove the last element
        arr.pop();
    }

    function test() public {
        arr = [1, 2, 3, 4];

        remove(1);
        // [1, 4, 3]
        assert(arr.length == 3);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
        assert(arr[2] == 3);

        remove(2);
        // [1, 4]
        assert(arr.length == 2);
        assert(arr[0] == 1);
        assert(arr[1] == 4);
    }
}