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
    var models: [NewsDetails]?
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetUp()
//        let urlStr: String = "https://helpdeskgeek.com/wp-content/pictures/2019/08/cropped-vpn-4046047_640.jpg"
        getNews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = false
    }
    private func initialSetUp() {
        headlineCollectionView.register(UINib(nibName: "SSHeadlinesCell", bundle: nil), forCellWithReuseIdentifier: "HeadlinesCellIdentifier")
    }
    
    fileprivate func getNews() {
        guard let url = URL(string: Constants.urlStr) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { data, response, error in
            
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode) else {
                print("Server error! check URL")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                guard let jsonArray = json as? [String: Any] else {
                    return
                }
                print(jsonArray)
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
//                let model = try decoder.decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
                let model = try decoder.decode(Articles.self, from:
                    data!) //Decode JSON Response Data
                self.models = model.articles
                print(model)
                DispatchQueue.main.async {
                    self.headlineCollectionView.reloadData()
                }
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
}

extension SSHeadlinesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HeadlinesCellIdentifier", for: indexPath) as? SSHeadlinesCell else {
            return UICollectionViewCell()
        }
            cell.backgroundColor = UIColor.white
        cell.accessibilityLabel = "Newly"
        cell.setupNewsCell(model: models?[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        guard let newsVC = storyBoard.instantiateViewController(withIdentifier: "SSNewsDetailViewControllerId") as? SSNewsDetailViewController else { return }
        newsVC.models = models?[indexPath.item]
        self.navigationController?.pushViewController(newsVC, animated: true)
    }
}

extension SSHeadlinesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width, height: 180.0)
    }
}
