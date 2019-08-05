//
//  SSUtilis.swift
//  SSNewsHeadlines
//
//  Created by Suraj Shandil on 8/6/19.
//  Copyright © 2019 Suraj Shandil. All rights reserved.
//

import Foundation
import UIKit

class SSUtilis: NSObject {
   class func dowloadFromServer(url: URL, imageView: UIImageView ) {
        //        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                //                Data will sometimes come back as 0 bytes in the debugger; add a print with debug description to ensure you're getting data. In this case it was a failure of the debugger mixed with a later serialization error that caused it to appear to be broken.
                // For more follow: https://stackoverflow.com/questions/53147559/urlsession-datatask-returns-0-bytes-of-data
                else { return }
            DispatchQueue.main.async() {
                imageView.image = image
            }
            }.resume()
    }
    
    class func dowloadImageFromServer(link: String, imageView: UIImageView) {
        guard let url = URL(string: link) else { return }
        dowloadFromServer(url: url, imageView: imageView)
    }
}
