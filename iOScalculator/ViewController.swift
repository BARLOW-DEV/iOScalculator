
//
//  ViewController.swift
//  A02_Barlow_Aaron
//
//  Created by Aaron Barlow on 2/10/21.
//

import UIKit

class ViewController: UIViewController {

    var expression: String = ""
    var calculatorResults: String = ""
    var result: Double = 0.0
    
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelView: UILabel!
    
    @IBAction func zeroClick(_ sender: UIButton) {
        expression += "0"
        labelView.text = expression
    }
    
    @IBAction func oneClick(_ sender: UIButton) {
        expression += "1"
        labelView.text = expression
    }
    
    @IBAction func twoClick(_ sender: UIButton) {
        expression += "2"
        labelView.text = expression
    }
    
    @IBAction func threeClick(_ sender: UIButton) {
        expression += "3"
        labelView.text = expression
    }
    
    @IBAction func fourClick(_ sender: UIButton) {
        expression += "4"
        labelView.text = expression
    }
    
    @IBAction func fiveClick(_ sender: UIButton) {
        expression += "5"
        labelView.text = expression
    }
    
    @IBAction func sixClick(_ sender: UIButton) {
        expression += "6"
        labelView.text = expression
    }
    
    @IBAction func sevenClick(_ sender: UIButton) {
        expression += "7"
        labelView.text = expression
    }
    
    @IBAction func eightClick(_ sender: UIButton) {
        expression += "8"
        labelView.text = expression
    }
    
    @IBAction func nineClick(_ sender: UIButton) {
        expression += "9"
        labelView.text = expression
    }
    
    
    @IBAction func dotClick(_ sender: Any) {
        var deciCount = 0
        for i in expression {
            if i == "." {deciCount += 1}
            if i == "+" {deciCount = 0}
            if i == "-" {deciCount = 0}
            if i == "*" {deciCount = 0}
            if i == "/" {deciCount = 0}
        }
        if deciCount > 0 {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else {
            expression += "."
            labelView.text = expression
        }
    }
    
    @IBAction func plusClick(_ sender: UIButton) {
        var expressionArray: [Character] = []
        var stringCount = 0
        for character in expression {
            expressionArray.insert( character, at: stringCount )
            stringCount += 1
        }
        if expressionArray.isEmpty {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else if expressionArray.last == "+" ||
                  expressionArray.last == "-" ||
                  expressionArray.last == "*" ||
                  expressionArray.last == "/"  {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else {
            expression += "+"
            labelView.text = expression
        }
    }
    
    @IBAction func minusClick(_ sender: UIButton) {
        var expressionArray: [Character] = []
        var stringCount = 0
        if expression.isEmpty {
            expression += "-"
            labelView.text = expression
            return
        } else {
            for character in expression {
                expressionArray.insert( character, at: stringCount )
                stringCount += 1
            }
        }
        
        if expressionArray.last == "-" {
                viewBackground.backgroundColor = UIColor.red
                labelView.textColor = UIColor.white
                labelView.text = "0"
            return
        } else {
            expression += "-"
            labelView.text = expression
        }
    }
    
    @IBAction func multClick(_ sender: UIButton) {
        var expressionArray: [Character] = []
        var stringCount = 0
        for character in expression {
            expressionArray.insert( character, at: stringCount )
            stringCount += 1
        }
        if expressionArray.isEmpty {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else if expressionArray.last == "+" ||
                  expressionArray.last == "-" ||
                  expressionArray.last == "*" ||
                  expressionArray.last == "/"  {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else {
            expression += "*"
            labelView.text = expression
        }
    }
    
    @IBAction func divideClick(_ sender: UIButton) {
        var expressionArray: [Character] = []
        var stringCount = 0
        for character in expression {
            expressionArray.insert( character, at: stringCount )
            stringCount += 1
        }
        if expressionArray.isEmpty {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else if expressionArray.last == "+" ||
                  expressionArray.last == "-" ||
                  expressionArray.last == "*" ||
                  expressionArray.last == "/"  {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else {
            expression += "/"
            labelView.text = expression
        }
    }
    
    @IBAction func acClick(_ sender: UIButton) {
        expression = ""
        viewBackground.backgroundColor = UIColor.white
        labelView.textColor = UIColor.black
        labelView.text = expression
    }
    
    @IBAction func equalsClick(_ sender: UIButton) {
        calculatorResults = inFixToPostfix(expressionToConvert: expression)
        labelView.text = calculatorResults
        
        var numCharacters: Int  = 0
        for character in expression {
            numCharacters += 1
        }
        if expression.isEmpty {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        } else if isDivisionValid() {
            expression = inFixToPostfix(expressionToConvert: expression)
            result = postFixEvaluate(expressionToEvaluate: expression)
            if result < 0 {
                viewBackground.backgroundColor = UIColor.black
                labelView.textColor = UIColor.white
            } else if result >= 0 {
                viewBackground.backgroundColor = UIColor.white
                labelView.textColor = UIColor.black
            }
            let resultString = formatResult(result: result)
            calculatorResults = resultString
            expression = calculatorResults
            labelView.text = calculatorResults
            
        } else {
            viewBackground.backgroundColor = UIColor.red
            labelView.textColor = UIColor.white
            labelView.text = "0"
        }
    }
 
    struct characterStack {
        private var array: [Character] = []
        
        func peek() -> Bool {
            if array.isEmpty {
                return true
            } else {
                return false
            }
        }
        
        mutating func pop() -> Character {
            return array.removeFirst()
        }
        
        mutating func push(_ element: Character) {
            array.insert(element, at: 0)
        }
    }
    
    struct integerStack {
        private var array: [Double] = []
        var flag: Bool = false
        var num: Double = 0.0
        
        mutating func setFlagToFalse() {
            flag = false
        }
        
        mutating func setFlagToTrue() {
            flag = true
        }
        
        func peek() -> Bool {
            if array.isEmpty {
                return true
            } else {
                return false
            }
        }
        
        mutating func pop() -> Double {
            return array.removeFirst()
        }
        
        mutating func push(_ element: Double) {
            if flag == true {
                num = pop()
                array.insert(element + num * 10, at: 0)
            } else {
                array.insert(element, at: 0)
                flag = true
            }
        }
    }
    
    func getPrecedence(c: Character) -> Double {
        if c == "+" || c == "-" {
            return 1.0
        } else {
            return 2.0
        }
    }
        
    func inFixToPostfix(expressionToConvert: String) -> String {
        var postFixStack = characterStack()
        var postFixString: String = ""
        
        for c in expressionToConvert {
            if c != "+" && c != "-" && c != "*" && c != "/" {
                postFixString += String(c)
            } else if c == "+" || c == "-" || c == "*" || c == "/" {
                postFixString += " "
                if postFixStack.peek() {
                    postFixStack.push(c)  //isEmpty?
                } else {
                    while !postFixStack.peek() {
                        let t: Character = postFixStack.pop()
                        if getPrecedence(c: t) < getPrecedence(c: c) {
                            postFixStack.push(t)
                            break
                        } else {
                            postFixString += String(t)
                            postFixString += " "
                        }
                    }
                    postFixStack.push(c)                }
            }
        }
        while !postFixStack.peek() {
            postFixString += " "
            postFixString += String(postFixStack.pop())
        }
        return postFixString
    }
    
    func toCharArray(stringToConvert: String) -> [Character] {
        var convertedString: [Character] = []
        for c in stringToConvert {
            convertedString.append(c)
        }
        return convertedString
    }
    
    func getNumber(numberToGet: Character) -> Double {
        switch numberToGet {
        case "1":
            return 1.0
        case "2":
            return 2.0
        case "3":
            return 3.0
        case "4":
            return 4.0
        case "5":
            return 5.0
        case "6":
            return 6.0
        case "7":
            return 7.0
        case "8":
            return 8.0
        case "9":
            return 9.0
        default:
            return 0.0
        }
    }
    
    func checkIfDecimal(expressionToEvaluate: String) -> Bool {
        var subExpression: [Character] = []
        var isDec: Bool = false
        for c in expressionToEvaluate {
            subExpression.append(c)
        }
        for c in subExpression {
            if c >= "0" && c <= "9" {
                continue
            } else if c == "." {
                isDec = true
                continue
            } else {
                break
            }
        }
        return isDec
    }
    
    func getDecimal(subString: String) -> Double {
        var subExpression: [Character] = []
        var decString: String = ""
        var decimalNumber: Double = 0.0
        var isDec: Bool = false
        var postDecCount: Int = 0
        for c in subString {
            subExpression.append(c)
        }
        for c in subExpression {
            if c >= "0" && c <= "9" {
                postDecCount += 1
                continue
            } else if c == "." {
                isDec = true
                postDecCount += 1
                continue
            } else {
                break
            }
        }
        if isDec {
            decString = String(subString.dropLast(subExpression.count - postDecCount))
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let number = formatter.number(from: decString )
            decimalNumber = number as! Double
        }
        return decimalNumber
    }
    
    func getEndIndex(subString: String) -> Int {
        var subExpression: [Character] = []
        var postDecCount: Int = 0
        for c in subString {
            subExpression.append(c)
        }
        for c in subExpression {
            if c >= "0" && c <= "9" {
                postDecCount += 1
                continue
            } else if c == "." {
                postDecCount += 1
                continue
            } else {
                break
            }
        }
        return postDecCount
    }
    
    func doesNumBeginWithDec(stringToEvaluate: String) -> Bool {
        let index: Int = 0
        var doesBeginWithDec: Bool = false
        for c in stringToEvaluate {
            if c == "." && index == 0{
                doesBeginWithDec = true
            } else {
                break
            }
        }
        return doesBeginWithDec
    }
    
    func postFixEvaluate(expressionToEvaluate: String) -> Double {
        var evaluationStack = integerStack()
        var decimalNeedsDealingWith: Bool = true
        var count: Int = 0
        var x: Double = 0
        var y: Double = 0
        let expressionArray: [Character] = toCharArray(stringToConvert: expressionToEvaluate)
        var expressionToSend = expressionToEvaluate.dropFirst(count)
        var isDecimalUntilSpace: Bool = checkIfDecimal(expressionToEvaluate: String(expressionToSend))
        var decimalNumber: Double = 0.0
        var doesNumberBeginWithDecimal = doesNumBeginWithDec(stringToEvaluate: String(expressionToSend))
        for c in expressionArray {
            if c >= "0" && c <= "9"  {
                if count > 0 && expressionArray[count - 1] == " " {
                    expressionToSend = expressionToEvaluate.dropFirst(count)
                    isDecimalUntilSpace = checkIfDecimal(expressionToEvaluate: String(expressionToSend))
                    if isDecimalUntilSpace {
                    decimalNeedsDealingWith = true
                    }
                }
                if isDecimalUntilSpace || doesNumberBeginWithDecimal {
                    if decimalNeedsDealingWith {
                        decimalNumber = getDecimal(subString: String(expressionToSend))
                        evaluationStack.push(decimalNumber)//if decimal number...get number..put on stack
                        decimalNeedsDealingWith  = false
                    } else {
                        count += 1
                        continue
                    }
                } else {
                    evaluationStack.push(getNumber(numberToGet: c))
                    }
            } else if c == "." {
                if expressionArray[count - 1] >= "0" && expressionArray[count - 1] <= "9" {
                    count += 1
                    continue
                } else {
                    expressionToSend = expressionToEvaluate.dropFirst(count)
                    doesNumberBeginWithDecimal = checkIfDecimal(expressionToEvaluate: String(expressionToSend))
                    if doesNumberBeginWithDecimal {
                        decimalNumber = getDecimal(subString: String(expressionToSend))
                        evaluationStack.push(decimalNumber)//if first decimal number...get number..put on stack
                        decimalNeedsDealingWith  = false
                    }
                    count += 1
                    continue
                }
            } else if c == " " {
                decimalNeedsDealingWith = false
                isDecimalUntilSpace = false
                doesNumberBeginWithDecimal = false
                evaluationStack.setFlagToFalse()
            } else {
                evaluationStack.setFlagToFalse()
                y = evaluationStack.pop()
                x = evaluationStack.pop()
                switch c {
                case "+":
                    evaluationStack.push(x+y)
                case "-":
                    evaluationStack.push(x-y)
                case "*":
                    evaluationStack.push(x*y)
                case "/":
                    evaluationStack.push(x/y)
                default:
                    return 0
                }
            }
            count += 1
        }
        return evaluationStack.pop()
    }
    
    func isDivisionValid() -> Bool {
        var divisionArray: [Character] = []
        var divisionArrayCount = 0
        var stringCount = 0
        var divisionIndex = 0
        var divisionString = ""
        for character in expression {
            if character == "/" {
                divisionIndex = stringCount
            }
            if divisionIndex > 0 && stringCount > divisionIndex {       // checks to see if character after division is an operator
                if character == "/" ||
                   character == "*" ||
                   character == "+" {
                        break
                }
                if character == "-" {
                    continue
                } else {
                divisionArray.insert(character, at: divisionArrayCount)
                divisionArrayCount += 1
                }
            }
            stringCount += 1
        }
        
        for character in divisionArray {
            divisionString.append(character)
        }
        
        if divisionIndex > 0 {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        let number = formatter.number(from: divisionString )
        let decimalNumber = number as! Double
            if decimalNumber > 0 {
                return true
            } else {
                return false
            }
        } else {
            return true
        }
    }

    func formatResult(result: Double) -> String {
        if(result.truncatingRemainder(dividingBy: 1) == 0) {
            return String(format: "%.0f", result)
        } else {
            return String(format: "%.4f", result)
        }
    }
}

extension NSExpression {         // got this extension from stackoverflow.com/questions/14346056/nsexpression-1-2
    var floatifiedForDivisionIfNeeded: NSExpression {       // it changes NSExpression from integer division to floating point division
        if function == "divide:by:", let args = arguments, let last = args.last,
          let firstValue = args.first?.constantValue as? NSNumber {
            let newFirst = NSExpression(forConstantValue: firstValue.doubleValue)
            return NSExpression(forFunction: function, arguments: [newFirst, last])
        } else {
            return self
        }
    }
}


