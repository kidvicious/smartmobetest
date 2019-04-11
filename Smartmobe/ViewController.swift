//
//  ViewController.swift
//  Smartmobe
//
//  Created by Asmin Ghale on 4/10/19.
//  Copyright © 2019 default. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var resultsCollectionView: UICollectionView!
    
    var result = [MediaResult](){
        didSet{
            self.resultsCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsCollectionView.dataSource = self
        resultsCollectionView.delegate = self
        getImages()
    }

    
    fileprivate func getImages() {
        APIHandler.shared.getImages(completion: { (result) in
            if let _result = result as? NSDictionary{
                print(_result)
                self.result = Media.parseResult(data: _result)
            }else{
                print("failed to parse result.")
            }
        }) { (error) in
            if let err = error{
                print(err.localizedDescription)
            }else{
                print("An error occurred.")
            }
        }
    }

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ResultMediaCollectionViewCell", for: indexPath) as! ResultMediaCollectionViewCell
        cell.media = result[indexPath.row]
        return cell
    }
    
    
}
