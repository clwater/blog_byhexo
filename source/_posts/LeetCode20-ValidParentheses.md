---
title: 'LeetCode20-ValidParentheses(有效的括号)'
date: 2019-02-16 16:06:44
tags: ["算法" , "LeetCode"]
categories : "LeetCode"
---

# LeetCode20:ValidParentheses(有效的括号)

[LeetCode:https://leetcode-cn.com/problems/valid-parentheses/](https://leetcode.com/problems/valid-parentheses/)

[LeetCodeCn:https://leetcode-cn.com/problems/valid-parentheses/](https://leetcode-cn.com/problems/valid-parentheses/)

## 题目描述
给定一个只包括 '('，')'，'{'，'}'，'['，']' 的字符串，判断字符串是否有效。

有效字符串需满足：
* 左括号必须用相同类型的右括号闭合。
* 左括号必须以正确的顺序闭合。
* 注意空字符串可被认为是有效字符串。

  <!-- more -->

## 示例
* 示例 1:
  * 输入: "()"
  * 输出: true

* 示例 2:
  * 输入: "()[]{}"
  * 输出: true

* 示例 3:
  * 输入: "(]"
  * 输出: false

* 示例 4:
  * 输入: "([)]"
  * 输出: false

* 示例 5:
  * 输入: "{[]}"
  * 输出: true

## 解题方法-栈辅助
通过题目的描述中我们可以知道括号需要有序的闭合,也就是每次开括号后遇到的一个闭括号序号和开括号对应,每次对应后就不需要再次验证,后出现的开括号需要先验证,这种情况下,很符合栈的特点,后进先出.

我们可以再遇到开括号的时候将其放入栈中,在遇到闭括号的时候出栈并验证两者时候匹配.

## 图解相关思路
下面针对"{[[]{}]}()"子串进行校验

当i=0时,通过c去的当前位置的字符.我们看到此时c={, {属于开括号 **(,[,{** 之一,将{入栈即可,此时栈(stack顶为{)
![i=0](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216173040.png)

类似的当i=2时,栈中从顶到底元素分别为[[{
![i=2](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216173454.png)

当i=3是,c为],]属于闭括号 **),],}**,此时stack非空,我们出去栈顶元素为[,此时栈顶元素'['和c']'匹配,则继续检测.
若此时栈顶元素和c不匹配,则返回false,此字符串中的括号并不是有效的
![i=3](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216181107.png)

类似的,当i=4时继续入栈元素
![i=4](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216181504.png)

当i=9时,此时栈中元素全部验证并出栈.
![i=9](https://update-image.oss-cn-shanghai.aliyuncs.com/upImage/20190216181725.png)

最后我们要检测一下stack中是否还包含未出栈的元素,当stack中包含元素时说明存在开括号未出现与其匹配的闭括号,此串不包含有效括号

## 代码实现
```java
public boolean isValid(String s) {
    Stack<Character> stack = new Stack<>();
    for (int i = 0; i < s.length(); i++){
        char c = s.charAt(i);
        if (c == '(' || c == '[' || c == '{'){
            stack.push(c);
        }else if (stack.empty()){
            return false;
        }else {
            switch (c) {
                case ')':
                    if (stack.pop() != '('){
                    return false;
                }
                break;
                case ']':
                    if (stack.pop() != '[') {
                        return false;
                    }
                    break;
                case '}':
                    if (stack.pop() != '{') {
                        return false;
                    }
                    break;
            }
        }
    }
    return stack.empty();
}
```

[相关代码](https://github.com/clwater/Code/blob/master/src/ValidParentheses.java)欢迎大家关注并提出改进的建议
