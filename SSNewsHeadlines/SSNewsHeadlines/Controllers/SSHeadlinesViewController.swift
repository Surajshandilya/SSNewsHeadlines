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
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
