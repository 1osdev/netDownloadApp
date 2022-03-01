//
//  ViewController.swift
//  netDownloadApp
//
//  Created by Дмитрий Смирнов on 28.02.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let URLString = [
        "1https://i.pinimg.com/originals/df/c0/ec/dfc0ec844718275d1e4ed1a6e56491ef.jpg",
        "https://kwinsy.com.ua/image/catalog/tovar/kartini/KHO2153.jpg",
        "https://images-na.ssl-images-amazon.com/images/I/A1dRh330y5L.jpg",
        "https://upload.wikimedia.org/wikipedia/commons/1/14/Van_Gogh_-_Blühender_Pfirsichbaum.jpeg",
        "https://cp16.nevsepic.com.ua/279/27907/1475831065-vyatskie-zhuravli.jpg"
    ]




    override func viewDidLoad() {
        super.viewDidLoad()
        if statusLbl.text != nil {
            statusLbl.text = "No Image Download"
        }

    }

    @IBAction func downloadBtn(_ sender: UIButton) {
        statusLbl.text = ""
        self.activityIndicator.startAnimating()
        downloadImage()
    }

    func downloadImage() {
        let urlString = selectUrlString(number: randomImage())

        guard let imageURL = URL(string: urlString) else { return }

        let task = URLSession.shared.dataTask(with: imageURL) {
            (data, response, error) in

            var displayImage: UIImage?

            if let error = error {
                print(error.localizedDescription)
                //print("500 Internal Server Error \(error)")
                displayImage = UIImage (named: "error500")
            }
            if let imageData = data {
                displayImage = UIImage(data: imageData)
            }
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.imageView.image = displayImage
            }
        }
        task.resume()
    }

    func randomImage() -> Int {
        return Int(arc4random_uniform(5))
    }
    func selectUrlString(number: Int) -> String {
        return URLString[number]
    }
}
