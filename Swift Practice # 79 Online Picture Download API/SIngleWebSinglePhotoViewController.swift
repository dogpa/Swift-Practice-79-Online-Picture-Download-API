//
//  SIngleWebSinglePhotoViewController.swift
//  Swift Practice # 79 Online Picture Download API
//
//  Created by Dogpa's MBAir M1 on 2021/9/17.
//

import UIKit

class SIngleWebSinglePhotoViewController: UIViewController {

    @IBOutlet weak var showWebImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    var timer: Timer?
    @IBAction func touchToChangeView(_ sender: UIButton) {
        let randomWedsite = "https://picsum.photos/200"
        if let url = URL(string: randomWedsite) {
            URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                if let data = data, let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self.showWebImageView.image = image
                        print("show時間\(Date())")
                    }
                    
                }
            }.resume()
            print("執行時間\(Date())")
        }
    }
    
    @IBAction func autoChangePhoto(_ sender: UISwitch) {
        
        if sender.isOn == true {
            self.timer = Timer.scheduledTimer(withTimeInterval: 2, repeats: true) { Timer in
                let randomWedsiteForTimer = "https://picsum.photos/200"
                if let url = URL(string: randomWedsiteForTimer) {
                    URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                        if let data = data, let image = UIImage(data: data){
                            DispatchQueue.main.async {
                                self.showWebImageView.image = image
                                print("show時間\(Date())")
                            }
                        }
                    }.resume()
                    print("執行時間\(Date())")
                }
            }
            print("載入時間\(Date())")
        }else{
            self.timer?.invalidate()
        }
    }
    
    
    
}
