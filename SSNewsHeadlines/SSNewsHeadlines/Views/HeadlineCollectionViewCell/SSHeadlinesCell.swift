//
//  SSHeadlinesCell.swift
//  SSNewsHeadlines
//
//  Created by Suraj Shandil on 7/24/19.
//  Copyright © 2019 Suraj Shandil. All rights reserved.
//

import UIKit

class SSHeadlinesCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var healineLabel: UILabel!
    @IBOutlet weak var subHeadlineLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupNewsCell(model: NewsDetails?) {
        guard let obj = model else { return }
        if let content = obj.content {
            self.healineLabel.text = content
        }
        if let title = obj.publishedAt {
            self.subHeadlineLabel.text = title
        }
        guard let imageUrl = obj.urlToImage else {
            DispatchQueue.main.async() {
                self.backgroundImageView.image = UIImage(named: "Img5")
            }
            return
        }
        SSUtilis.dowloadImageFromServer(link: imageUrl, imageView: self.backgroundImageView)
//        dowloadFromServer(link: imageUrl)
    }
}

//extension SSHeadlinesCell {
//    func dowloadFromServer(url: URL) {
//        //        contentMode = mode
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            guard
//                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
//                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
//                let data = data, error == nil,
//                let image = UIImage(data: data)
//                //                Data will sometimes come back as 0 bytes in the debugger; add a print with debug description to ensure you're getting data. In this case it was a failure of the debugger mixed with a later serialization error that caused it to appear to be broken.
//                // For more follow: https://stackoverflow.com/questions/53147559/urlsession-datatask-returns-0-bytes-of-data
//                else { return }
//            DispatchQueue.main.async() {
//                self.backgroundImageView.image = image
//            }
//            }.resume()
//    }
//
//    func dowloadFromServer(link: String) {
//        guard let url = URL(string: link) else { return }
//        dowloadFromServer(url: url)
//    }
//}
