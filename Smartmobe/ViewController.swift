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
    lazy var searchBar:UISearchBar = UISearchBar(frame: (self.navigationController?.navigationBar.frame)!)
    
    
    var result = [MediaResult](){
        didSet{
            backgroundView()
            resultsCollectionView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsCollectionView.dataSource = self
        resultsCollectionView.delegate = self
        getImages()
        setupSearchBar()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.resignFirstResponder()
    }
    
    //MARK: - Methods
    
    fileprivate func getImages() {
        APIHandler.shared.getImages(completion: {[weak self] (result) in
            if let _result = result as? NSDictionary{
                print(_result)
                self?.result = Media.parseResult(data: _result)
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
    
    fileprivate func setupSearchBar() {
        searchBar.placeholder = "Search images/video"
        searchBar.enablesReturnKeyAutomatically = true
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        let leftNavBarButton = UIBarButtonItem(customView:searchBar)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
    }
    
    fileprivate func searchImage(query: String){
            APIHandler.shared.searchImages(query: query, completion: {[weak self] (result) in
                let mediaResult = Media.parseResult(data: result as! NSDictionary)
                self?.result = mediaResult
            }) { (error) in
                print(error?.localizedDescription)
            }
    }
    
    fileprivate func backgroundView() {
        if result.count == 0{
            let label = UILabel(frame: self.view.frame)
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 15)
            label.textColor = .black
            label.text = "No results"
            self.resultsCollectionView.backgroundView = label
        }else{
            self.resultsCollectionView.backgroundView = nil
        }
    }
    
    fileprivate func presentDetailVC(mediaItem: MediaResult){
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.media = mediaItem
        self.navigationController?.pushViewController(detailVC, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mediaItem = result[indexPath.row]
        presentDetailVC(mediaItem: mediaItem)
    }
}

extension ViewController: UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchImage(query: searchBar.text!)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        getImages()
    }
}
