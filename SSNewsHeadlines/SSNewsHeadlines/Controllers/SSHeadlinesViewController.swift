//
//  SSHeadlinesViewController.swift
//  SSNewsHeadlines
//
//  Created by Suraj Shandil on 7/23/19.
//  Copyright © 2019 Suraj Shandil. All rights reserved.
//

import UIKit

class SSHeadlinesViewController: UIViewController {
    
    @IBOutlet weak var headlineCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        headlineCollectionView.register(UINib(nibName: "SSHeadlinesCell", bundle: nil), forCellWithReuseIdentifier: "HeadlinesCellIdentifier")
        let urlStr = "https://newsapi.org/v2/everything?q=bitcoin&from=2019-06-24&sortBy=publishedAt&apiKey=4ac114b3a21b4795a9100efc1106cc9e"
        guard let url = URL(string: urlStr) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

extension SSHeadlinesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlinesCellIdentifier", for: indexPath) as? SSHeadlinesCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = UIColor.white
        cell.accessibilityLabel = "Newly"
        return cell
    }
    
    
}

extension SSHeadlinesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 100.0)
    }
}
