//
//  ViewController.swift
//  GIF-omatic-3D
//
//  Created by Etienne Martin (Work) on 2015-11-13.
//  Copyright © 2015 Etienne Martin (Work). All rights reserved.
//

import UIKit
import FLAnimatedImage

class ViewController: UIViewController, UIViewControllerPreviewingDelegate {

	// MARK: Inits
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}

	override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
		super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let forceImg = FLAnimatedImage(animatedGIFData: gifForce)
		theforce.animatedImage = forceImg
		theforce.backgroundColor = UIColor.redColor()
		
		if (self.isForceTouchAvailable()) {
			self.previewingContext = self.registerForPreviewingWithDelegate(self, sourceView: self.view)
		}
	}

	override func traitCollectionDidChange(previousTraitCollection: UITraitCollection?) {

		super.traitCollectionDidChange(previousTraitCollection)
		if (self.isForceTouchAvailable()) {
			if (previewingContext == nil) {
				self.previewingContext = self.registerForPreviewingWithDelegate(self, sourceView: self.view)
			}
		} else {
			if (previewingContext != nil) {
				self.unregisterForPreviewingWithContext(previewingContext!)
				previewingContext = nil;
			}
		}
	}

	// MARK: UIViewControllerPreviewingDelegate
	
	func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
		
		if (button1.state != UIControlState.Highlighted && button2.state != UIControlState.Highlighted) {
			return nil
		}
		
		let viewController:ActionViewController? = ActionViewController()
		
		if (button1.state == UIControlState.Highlighted) {
			
			previewingContext.sourceRect = button1.frame // Blur it baby!!!
			viewController!.gifData = gif1
			viewController!.showActions = true
			
		}
		else if (button2.state == UIControlState.Highlighted) {
			
			print("3D touching button 2")
			previewingContext.sourceRect = button2.frame // Blur it baby!!!
			viewController!.gifData = gif2
			
		}
		
		return viewController
	}
	
	func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
		self.presentViewController(viewControllerToCommit, animated: true, completion: nil)
	}
	
	// MARK: Helpers
	
	private func isForceTouchAvailable() -> Bool {
		if (self.traitCollection.respondsToSelector(Selector("forceTouchCapability"))) {
			return self.traitCollection.forceTouchCapability == UIForceTouchCapability.Available
		}
		return false
	}
	
	@IBOutlet weak var button1: UIButton!
	@IBOutlet weak var button2: UIButton!
	@IBOutlet var theforce: FLAnimatedImageView!
	
	private var previewingContext : UIViewControllerPreviewing?  /// <------- This is important ;)
	
	private var gif1 : NSData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("gif1", ofType: "gif")!)!
	private var gif2 : NSData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("gif2", ofType: "gif")!)!
	private var gifForce : NSData = NSData(contentsOfFile: NSBundle.mainBundle().pathForResource("gifForce", ofType: "gif")!)!
}

