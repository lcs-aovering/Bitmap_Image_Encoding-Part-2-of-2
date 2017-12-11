//: [Previous](@previous) / [Next](@next)
//: # Decoding an Image
//: The following two statements are required to make the playground run. Please do not remove.
import Cocoa
import PlaygroundSupport
/*:
 ## Decoding the text
 Now we will (at last!) decode the image.
 
 Recall, our rules are:
 
 * If a line starts with a 0, the first pixel is black.
 * If a line does not start with a 0, the first pixel is white.
 * When a comma is encountered, a new number begins, and the colour switches.
 * When a newline character is encountered, go to a new row in the image.
 * Once we have a new number, we draw that many pixels in the current colour.
 
 First, copy and paste your encoded image string to this page.
*/

// Copy your encoded image string here...
let encodedBitmap = """
b9,5,b6
b8,1,5,1,b5
b7,1,7,1,b4
b4,3,9,1,b3
b3,1,4,1,4,1,1,2,b3
b1,2,5,1,3,1,1,4,b2
b1,2,9,1,1,4,b2
b2,1,9,1,1,4,b2
b3,1,8,1,1,4,b2
b4,2,6,1,1,4,b2
b6,3,2,1,b1,1,1,2,b3
b8,r3,b3,2,b4
b7,1,3,1,b8
b6,1,2,1,1,1,b8
b1,2,b3,1,2,1,1,1,b8
b1,1,1,1,b1,1,3,1,2,1,b7
b1,1,1,1,b1,1,3,1,2,1,b7
b1,1,2,2,4,2,b8
b1,1,4,1,4,2,b7
b1,1,2,2,b1,1,5,1,b6
b1,3,b4,1,1,3,b7
b6,2,3,1,b8
b5,1,6,1,b7
b5,8,b7
"""

// Make a canvas
let canvas = Canvas(width: 402, height: 482)

// Make a grid
// NOTE: The code that builds the grid was tucked away in something called a *function* to keep things tidy. We'll learn about functions later.
drawGrid(on: canvas)

// Start drawing at left
var x = 0

// Set the size of a "pixel"
let cellSize = 20

// Keep track of current colour
var currentColor = "white"

// Start drawing at top of grid
var y = canvas.height - cellSize - 2

// Store the current number of pixels to draw
var drawThisManyPixels = 0

// Iterate over each character in the encoded bitmap string
for character in encodedBitmap {
    
    // Set colour at start of a line
    if character == "0" {
        
        canvas.fillColor = Color.black
        currentColor = "black"

    } else if character == "," {
        
        // We have a new number
        // Are we past the first pixel in a row?
        if x > 0 {

            // Toggle the pixel colour
            if currentColor == "black" {
                currentColor = "white"
                canvas.fillColor = Color.white
            } else {
                currentColor = "black"
                canvas.fillColor = Color.black
            }

        }
    
        
    } else if character == "b" {
        //we want the color to be the color of the sky for every value with b in front
        canvas.fillColor = Color.init(hue: 200, saturation: 90, brightness: 70, alpha: 100)
    } else if character == "r" {
        //we want the color to be the color of the sky for every value with b in front
        canvas.fillColor = Color.init(hue: 0, saturation: 100, brightness: 100, alpha: 100)
        
    } else if character == "\n" {
        
        // We are on a new line, so reduce the vertical position
        // and reset the horizontal position
        y = y - cellSize
        x = 0
        
        // Default colour after new line is white
        canvas.fillColor = Color.white
        currentColor = "white"
        
    } else {
        
        // Get the new number of pixels to draw
        drawThisManyPixels = Int(String(character))!
        
        // Draw the pixels
        for _ in 1...drawThisManyPixels {

            // Draw the enlarged "pixel"
            canvas.drawRectangle(bottomLeftX: x, bottomLeftY: y, width: cellSize, height: cellSize)
            
            // Increase x so that the next pixel is drawn to the right of this one
            x += cellSize

        }

    }
    
}

/*:
 ### Check the results
 Does the output match what you'd expect, based on the values in the encoded string?
 
 How do you know?
 
 Write your ideas in the code comment below.
 */

// I notice that once i change the numbers to match those on my plaaning, my image does indeed show up
// I know this because I can see the results match my initial drawing 

/*:
 ## Extension
 Now that you have an understanding of how if statements (also called *selection* statements or *conditional* statements) work... extend this code.
 
 How could you adjust the rules so that pixels can be rendered in colour?
 
 What additions or changes would you need to make to the code above?
 
 Work with a partner to discuss possibilities and then make the changes in code.
 */


/*:
 Now, **remember to commit and push your work**.
 */
/*:
 ## Template code
 The code below is necessary to see results in the Assistant Editor at right. Please do not remove.
 */
PlaygroundPage.current.liveView = canvas.imageView
