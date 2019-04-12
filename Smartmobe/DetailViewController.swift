//
//  DetailViewController.swift
//  Smartmobe
//
//  Created by Asmin Ghale on 4/11/19.
//  Copyright © 2019 default. All rights reserved.
//

import UIKit
import Kingfisher

class DetailViewController: UIViewController {
    
    var media: MediaResult!
    var source: MediaSource?{
        didSet{
            nameLabel.text = source?.name ?? source?.message ?? ""
        }
    }
    
    var tapGestureRecognizer: UITapGestureRecognizer?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSource()
        initImage()
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(profile))
        imageView.addGestureRecognizer(tapGestureRecognizer!)
        profileView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
    }
    
    
    @IBAction func dismissProfile(_ sender: Any) {
        UIView.animate(withDuration: 0.5) {[weak self] in
            self?.profileView.alpha = 0
        }
    }
    
    
    @objc func profile(){
            profileView.alpha = 0
            profileView.isHidden = false
            UIView.animate(withDuration: 0.5) {[weak self] in
                self?.profileView.alpha = 1
            }
    }
    
    func initImage(){
        if let url = media.largeURL{
            let _url = URL(string: url)
            let processor = DownsamplingImageProcessor(size: imageView.frame.size)
            imageView.kf.indicatorType = .activity
            imageView.kf.setImage(
                with: _url,
                placeholder: nil,
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            {
                result in
                switch result {
                case .success(let value):
                    print("Task done for: \(value.source.url?.absoluteString ?? "")")
                case .failure(let error):
                    print("Job failed: \(error.localizedDescription)")
                }
            }
        }
    }
    

    fileprivate func getSource() {
        if let sourceID = media.sourceID{
            APIHandler.shared.getSource(id: sourceID,completion: { (result) in
                if let _result = result as? NSDictionary{
                    print(_result)
                    self.source = Media.parseSource(data: _result)
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
        }else{
            print("source id null")
        }
    }

}
