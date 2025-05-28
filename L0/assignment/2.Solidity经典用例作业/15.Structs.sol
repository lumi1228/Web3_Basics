// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;


// Structs -结构体
// You can define your own type by creating a struct.
// 您可以通过创建结构来定义自己的类型。

// They are useful for grouping together related data.
// 它们对于将相关数据分组很有用。

// Structs can be declared outside of a contract and imported in another contract.
// 结构可以在合约外部声明，并在另一个合约中导入。


contract Todos {

    struct Todo {
        string text;
        bool completed;
    }

    // An array of 'Todo' structs
    Todo[] public todos;

    function create (string calldata _text) public {
        // 初始化结构的3种方法

        // 1、- calling it like a function-//像调用函数一样调用它
        todos.push(Todo(_text,false));

        // 2、key value mapping // 键值映射
        todos.push(Todo({text:"test", completed:true}));

        // 3、initialize an empty struct and then update it
        Todo memory todo;
        todo.text = _text; // todo.completed initialized to false
        todos.push(todo);
      

    }
   
    // Solidity自动为todos创建了一个getter，实际上你并不需要这个函数。
     function get(uint256 _index) public view returns (string  memory text ,bool completed) {
        Todo storage todo = todos[_index];
        return (todo.text, todo.completed);
    }
    
    // update text
    function updateText(uint256 _index, string calldata _text) public{
        Todo storage todo = todos[_index];
        todo.text = _text;
    }
     // update completed
     function toggleCompleted(uint256 _index) public{
        Todo storage todo = todos[_index];
        todo.completed = !todo.completed;
    }


}

// 声明和导入Struct
// This is saved 'StructDeclaration.sol'
// struct Todo {
//     string text;
//     bool completed;
// }
// // File that imports the struct above
// import "./StructDeclaration.sol";
// contract Todos {
//     // An array of 'Todo' structs
//     Todo[] public todos;
// }