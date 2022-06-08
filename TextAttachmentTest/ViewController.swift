//
//  ViewController.swift
//  TextAttachmentTest
//
//  Created by Jay Lyerly on 6/7/22.
//

import UIKit
import Foundation

var count = 0

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSTextAttachment.registerViewProviderClass(MyAttachmentViewProvider.self,
                                                   forFileType: "public.data")
        
        redraw(self)
    }

    @IBAction func redraw(_ sender: Any?) {
        textView.attributedText = attrString
        count += 1
    }
    
    var attrString: NSAttributedString {
        let attrString = NSMutableAttributedString(string: "Hello\n")
        
        let attachment = MyTextAttachment(data: Data(), ofType: "public.data")
        let pdString = NSMutableAttributedString(attachment: attachment)
        attrString.append(pdString)
        
        attrString.append(NSAttributedString(string: "\nWorld!  Count: \(count)\n"))
        
        return attrString
    }

}

class MyAttachmentViewProvider: NSTextAttachmentViewProvider {
    
    let colors: [UIColor] = [
        .systemPurple,
        .systemRed,
        .systemBlue,
        .systemGreen,
        .systemYellow,
        .systemOrange
    ]
    
    override func loadView() {
                
        view = MyView()
        view?.backgroundColor = colors[count % colors.count]
    }

}

class MyView: UIView {}

class MyTextAttachment: NSTextAttachment {
            
    override func attachmentBounds(for textContainer: NSTextContainer?,
                                   proposedLineFragment lineFrag: CGRect,
                                   glyphPosition position: CGPoint,
                                   characterIndex charIndex: Int) -> CGRect {
                
        return CGRect(x: 0, y: 0, width: 150 + 10 * count, height: 100 + 10 * count)
    }
        
}

