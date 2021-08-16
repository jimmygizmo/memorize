import UIKit

16 / 10

var greeting = "Hello, playground"

var closure = {
    print(greeting)
}

print(type(of: closure))


func global_function(_ xyz: String) {
    print(xyz)
    // Global functions are closures that have a name and don't capture any values.
    // Is this because they don't NEED to capture? Because everything global is accessible anyhow?
    // I'm sure if we call it, it can print the value from global scope:
    print(greeting)
}

global_function(greeting)

print(type(of: global_function))

print(type(of: { (_ xyz: String) -> () in }))

16 % 10

16/10  // both integers causes integer division to happen

1 % 10

16.5 / 10  // dividend is a float and divisor is an int causes float division to happen

16 / 10.5  // dividend is an int and divisor is a float causes float division to happen

// Conclusion: / will do Int division (which floors the result, tossing any remainder) ONLY
// IF BOTH arguments are Ints.

5 / 2
6/3
6/3.0
6.0/3.0


struct Resolution {
    var width = 0
    var height = 0
}


class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}


let reso = Resolution.init()

let vidm = VideoMode.init()

print(vidm.resolution.width, vidm.resolution.height)

struct Size {
    var width = 0.0, height = 0.0
    // automatically receives a memberwise-initializer, so we can actually call:
    // Size.init(width: Double, height: Double)
}
let twoByTwo = Size.init(width: 2.0, height: 2.0)

let anotherTwoByTwo = Size()




