//
//  DetailsViewController.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 23/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    weak var collection: Collection!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = collection.title
        
        if let imgUrlString = collection.imgUrl {
            if let imgUrl = URL(string: imgUrlString) {
                imageView.af_setImage(withURL: imgUrl)
            }
        }
        
        textView.text = ""
        if let description = collection.description {
            textView.text = description
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func shareButtonTapped(_ sender: UIBarButtonItem) {
        let activityController = UIActivityViewController(activityItems: [collection.share_url!], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    @IBAction func openInSafari(_ sender: UIBarButtonItem) {
        UIApplication.shared.open(URL(string: collection.url!)!, options: [:])
    }
}
