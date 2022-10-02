//
//  ViewController.swift
//  DowloadImages
//
//  Created by Sufyan Arif on 29/09/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet var sliders : [UIProgressView]!
    @IBOutlet var lblPersent : [UILabel]!
    @IBOutlet weak var imageCollectionView: UICollectionView!
    
    var strURLs = ["https://file-examples.com/storage/fe4658769b6331540b05587/2017/10/file_example_PNG_500kB.png","https://file-examples.com/storage/fe4658769b6331540b05587/2017/10/file_example_PNG_500kB.png","https://file-examples.com/storage/fe4658769b6331540b05587/2017/10/file_example_PNG_500kB.png"]
    var imageArr = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func downloadTapped(_ sender: UIButton){
        for i in 0..<strURLs.count{
            sliders[i].isHidden = false
            downloadImages(urlString: strURLs[i], index: i)
        }
    }

    func downloadImages(urlString: String, index: Int){
        Alamofire.download(urlString)
            .downloadProgress { progress in
                print("Download Progress\(index): \(progress.fractionCompleted)")
                self.sliders[index].progress = Float(progress.fractionCompleted)
                self.lblPersent[index].text = "\(round(progress.fractionCompleted * 100)) %"
            }
        
            .responseData { response in
                if let data = response.result.value {
                    self.imageArr.append(UIImage(data: data)!)
                }
                print(self.imageArr)
                print(response)
            }
    }

}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = imageCollectionView.dequeueReusableCell(
            withReuseIdentifier: "imageViewCell",
            for: indexPath
        ) as! imageViewCell
        
        //let images = imageArr[indexPath]
        
        cell.imageViewcell.image = imageArr[indexPath.row]
        cell.backgroundColor = .black
        
        return cell
    }
}


class imageViewCell: UICollectionViewCell {
    @IBOutlet weak var imageViewcell: UIImageView!
}

