//
//  MainViewController.swift
//  Foodie Photos
//
//  Created by Rohan Sanap on 22/12/17.
//  Copyright © 2017 The Rohan Sanap Tech Studios. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var collections = [Collection]()
    var isLoading = false
    var backgroundMessage = ""
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Foodie Photos"
        collectionView.dataSource = self
        collectionView.delegate = self
        getCollections()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class func show() {
        let mainVC = UIStoryboard.main.instantiateViewController(withIdentifier: "mainVC")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = mainVC
    }
    
    @IBAction func logoutButtonTapped(_ sender: UIBarButtonItem) {
        UserDefaults.standard.removeObject(forKey: "loggedIn")
        LoginViewController.show()
    }
    
    func getCollections() {
        if !isLoading {
            isLoading = true
            
            APICaller.getCollections(success: { (collections) in
                self.collections = collections
                self.isLoading = false
                self.backgroundMessage = collections.isEmpty ? "No collections to display" : ""
                self.collectionView.reloadData()
            }) { (errorMessage) in
                self.backgroundMessage = errorMessage
                self.isLoading = false
                self.collectionView.reloadData()
            }
        }
    }
    
    func setLoadingView(_ collectionView: UICollectionView) {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.startAnimating()
        collectionView.backgroundView = activityIndicator
    }
    
    func setMessageView(_ collectionView: UICollectionView) {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = backgroundMessage
        collectionView.backgroundView = label
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "details" {
                if let collection = sender as? Collection {
                    let detailsVC = segue.destination as! DetailsViewController
                    detailsVC.collection = collection
                }
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if collections.isEmpty {
            if isLoading {
                setLoadingView(collectionView)
            }else {
                setMessageView(collectionView)
            }
        }else {
            collectionView.backgroundView = nil
        }
        
        return collections.isEmpty ? 0 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! PhotoCollectionViewCell
        cell.setDefault()
        cell.setFor(collections[indexPath.item])
        cell.backgroundColor = UIColor.black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let collection = collections[indexPath.item]
        performSegue(withIdentifier: "details", sender: collection)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width
        
        return CGSize(width: (width / 2.0) - 1.5, height: (width / 2.0) - 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }

}
