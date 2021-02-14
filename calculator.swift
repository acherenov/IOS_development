import Foundation

let operation = readLine()
var numbers = readLine()!.components(separatedBy: " ").map{(a: String)->(Int) in
    return Int(a)!
}
var result: Int = numbers[0]

var N: Int = numbers.count - 1

switch operation!
{
    case "+":
        for n in 1...N {
            result = result + numbers[n]    
        }
    case "-":
        for n in 1...N {
            result = result - numbers[n]    
        }
    case "*":
        for n in 1...N {
            result = result * numbers[n]    
        }
    case "/":
        for n in 1...N {
            result = result / numbers[n]    
        }
    default:
        print("Non-existent operand")
}

print("Result: \(result)")
