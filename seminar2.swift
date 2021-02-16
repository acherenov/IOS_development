import Foundation


//var prices = readLine()!.components(separatedBy: " ").map{(a: String)->(Int) in
//    return Int(a)!
//}

var prices: [Int] = [10, 13, 11, 8, 12, 17, 15, 15, 14]
var N: Int = prices.count - 1
var max_price = prices[0]
var profit = 0
var stack = 0

for i in 0...N-1 {
    let price = prices[i]
    if (price > prices[i + 1]) {
        if(price  > max_price) {
            profit = price * (i + 1)
            max_price = price
            stack = 0        
        } else {
            profit = profit + (stack + 1) * price
            stack = 0
        }
    } else {
        stack = stack + 1
    }
}
profit = profit + (stack + 1) * prices[N]
print(profit)