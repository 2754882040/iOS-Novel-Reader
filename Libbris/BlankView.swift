//
//  BlankView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-15.
//

import SwiftUI

struct BlankView: View {
    var body: some View {
        let screenSize: CGRect = CGRect(x: 0, y: 0, width: 50, height: 50)
        let testInput = "Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, "
        let nsattrInput = NSAttributedString(string: testInput)
        let framesetter = CTFramesetterCreateWithAttributedString(nsattrInput as! CFAttributedString)
        let path = CGPath(rect: screenSize, transform: nil)
        var range = CFRangeMake(0, 0)
        var rangeOffset = 0
        var rangeArray = [NSRange]()
        
        Text(testInput).frame(width: 50, height: 50).onAppear(perform: {repeat{
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(rangeOffset, 0), path, nil)
            range = CTFrameGetVisibleStringRange(frame)
            rangeArray.append(NSMakeRange(rangeOffset, range.length))
            rangeOffset += range.length
            print(rangeArray)
         
            print(testInput[testInput.index(testInput.startIndex,offsetBy: 1530)..<testInput.endIndex])
        }while(range.location + range.length < testInput.count)})
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
    }
}
