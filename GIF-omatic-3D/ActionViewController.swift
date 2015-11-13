//
//  ViewController.swift
//  SwiftAnimatedGif
//
//  Created by Etienne Martin on 2015-11-13.
//  Copyright © 2015 Etienne Martin. All rights reserved.
//

import UIKit
import FLAnimatedImage
import PureLayout

class ActionViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		if (gifData != nil) {
			let image = FLAnimatedImage(animatedGIFData: gifData)
			
			let imageView = FLAnimatedImageView()
			imageView.animatedImage = image
			imageView.backgroundColor = UIColor.redColor()
			self.view.addSubview(imageView);
			
			imageView.autoCenterInSuperview()
		}
		
		let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("dismissViewController"))
		self.view.userInteractionEnabled = true
		self.view.addGestureRecognizer(tapGestureRecognizer)
	}
	
	// MARK: Actions
	
	override func previewActionItems() -> [UIPreviewActionItem] {
		
		if (showActions) {
			let action : UIPreviewAction = UIPreviewAction(title: "Finish Him!", style: UIPreviewActionStyle.Default, handler: { (action, previewViewController) -> Void in
				UIApplication.sharedApplication().openURL(NSURL(string: "http://media0.giphy.com/media/Yg5bZNPimJMdy/giphy.gif")!)
			})
			
			return [action]
		}
		
		return []
	}
	
	func dismissViewController() {
		self.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
	}
	
	var gifData:NSData? = nil
	internal var showActions : Bool = false
}