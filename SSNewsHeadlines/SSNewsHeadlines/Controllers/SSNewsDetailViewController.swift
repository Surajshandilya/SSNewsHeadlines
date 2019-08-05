//
//  SSNewsDetailViewController.swift
//  SSNewsHeadlines
//
//  Created by Suraj Shandil on 8/5/19.
//  Copyright © 2019 Suraj Shandil. All rights reserved.
//

import UIKit

class SSNewsDetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var headlineLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var models: NewsDetails?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        guard let obj = models else { return }
        if let title = obj.title {
            headlineLabel.text = title
        }
        if let publishAt = obj.publishedAt {
            categoryLabel.text = publishAt
        }
        if let description = obj.description {
            summaryLabel.text = description
        }
        guard let imageStr = obj.urlToImage else {
            return
        }
        SSUtilis.dowloadImageFromServer(link: imageStr, imageView: backgroundImageView)
    }   
    
    @IBAction func popVC(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
