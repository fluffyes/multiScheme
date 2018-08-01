//
//  ViewController.swift
//  MultiScheme
//
//  Created by Soul on 01/08/2018.
//  Copyright © 2018 Fluffy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var foxImageView: UIImageView!
	
	@IBOutlet weak var loadingActivityIndicator: UIActivityIndicatorView!
	
	@IBOutlet weak var randomFoxButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		
		self.loadingActivityIndicator.stopAnimating()
		self.loadingActivityIndicator.isHidden = true
		
		self.loadRandomFox()
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// MARK: IBAction
	
	@IBAction func randomFoxTapped(_ sender: Any) {
		self.loadRandomFox()
	}
	
	// MARK: Networking
	func loadRandomFox() {
		self.randomFoxButton.setTitle("Loading...", for: .normal)
		self.randomFoxButton.isEnabled = false
		
		self.loadingActivityIndicator.startAnimating()
		self.loadingActivityIndicator.isHidden = false
		
		URLSession.shared.dataTask(with: Endpoints.randomFox(), completionHandler: { data, response, error in
			print("response received")
			// ensure there is no error for this HTTP response
			guard error == nil else {
				print ("error: \(error!)")
				return
			}
			
			// ensure there is data returned from this HTTP response
			guard let data = data else {
				print("No data")
				return
			}
			
			// Parse JSON into Fox struct using JSONDecoder
			guard let fox = try? JSONDecoder().decode(Fox.self, from: data) else {
				print("Error: Couldn't decode data into car")
				return
			}
			
			if let imageData = try? Data(contentsOf: fox.image) {
				// Use main queue to update image
				DispatchQueue.main.async {
					self.foxImageView.image = UIImage(data: imageData)
					self.loadingActivityIndicator.stopAnimating()
					self.loadingActivityIndicator.isHidden = true
					
					self.randomFoxButton.setTitle("Load Random Fox", for: .normal)
					self.randomFoxButton.isEnabled = true
				}
			}
			
		}).resume()
	}
}

