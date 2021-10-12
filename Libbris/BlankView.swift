//
//  BlankView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-15.
//

import SwiftUI

struct MyTextView: UIViewRepresentable {
    var text: NSMutableAttributedString

    

    func updateUIView(_ uiView: UILabel, context: UIViewRepresentableContext<MyTextView>) {
        uiView.attributedText = text
    }
    var width: CGFloat

    func makeUIView(context: Context) -> UILabel {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = width
        label.attributedText = text
        label.font = UIFont.systemFont(ofSize: 20.0)
        return label
    }


}

struct BlankView: View {
    var body: some View {
        //GeometryReader { geometry in
           // MyTextView(width: geometry.size.width)
    //}
        let screenSize: CGRect = CGRect(x: 0, y: 0, width: 2000, height: 200)

       let testInput = NSMutableAttributedString(string: "Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello, World!Hello,  ",attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20.0)])
       
        let framesetter = CTFramesetterCreateWithAttributedString(testInput as! CFAttributedString)
        let path = CGPath(rect: screenSize, transform: nil)
        var range = CFRangeMake(0, 0)
        var rangeOffset = 0
        var rangeArray = [NSRange]()
        
        MyTextView(text: testInput as! NSMutableAttributedString, width: 200).frame(width: 200, height: 200).onAppear(perform: {repeat{
            let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(rangeOffset, 0), path, nil)
            range = CTFrameGetVisibleStringRange(frame)
            rangeArray.append(NSMakeRange(rangeOffset, range.length))
            rangeOffset += range.length
            print(rangeArray)
         
            
        }while(range.location + range.length < testInput.string.count)})
    }
}

struct BlankView_Previews: PreviewProvider {
    static var previews: some View {
        BlankView()
    }
}
