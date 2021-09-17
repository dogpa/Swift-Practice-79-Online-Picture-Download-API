//
//  FourAPIPhotoViewController.swift
//  Swift Practice # 79 Online Picture Download API
//
//  Created by Dogpa's MBAir M1 on 2021/9/17.
//

import UIKit

class FourAPIPhotoViewController: UIViewController {

    @IBOutlet var webAPIImageCollection: [UIImageView]!
   
    var fourAPITimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...webAPIImageCollection.count - 1 {
            let forAPIVDLLink = "https://picsum.photos/200"
            if let url = URL(string: forAPIVDLLink) {
                URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                    if let data = data, let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            self.webAPIImageCollection[i].image = image
                            print("show時間\(Date())")
                        }
                        
                    }
                }.resume()
            }
        }
        
    }
    
    
    @IBAction func autoFourAPIChange(_ sender: UISwitch) {
        if sender.isOn == true {
            self.fourAPITimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { Timer in
                
                
                for i in 0...self.webAPIImageCollection.count - 1 {
                    let fourAutoAPILink = "https://picsum.photos/200"
                    if let url = URL(string: fourAutoAPILink) {
                        URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                            if let data = data, let image = UIImage(data: data){
                                DispatchQueue.main.async {
                                    self.webAPIImageCollection[i].image = image
                                    print("show出第\(i)張時間\(Date())")
                                }
                                
                            }
                        }.resume()
                    }
                }
            }
        }else{
            self.fourAPITimer?.invalidate()
        }
    }
    
    
    @IBAction func changeFourAPIPhoto(_ sender: UIButton) {
        print("按下button時間\(Date())")

        for i in 0...webAPIImageCollection.count - 1 {
            let webAPIArray = ["https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200", "https://picsum.photos/200"]
            if let url = URL(string: webAPIArray[i]) {
                URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                    if let data = data, let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            self.webAPIImageCollection[i].image = image
                            print("show時間\(Date())")
                        }
                        
                    }
                }.resume()
            }
        }
        
        
        //迴圈在kingfisher用法內會無法換圖
        /*
         for z in 0...webAPIImageCollection.count - 1 {
             let fourAPIButtonLine = webAPIArray[z]
             if let fourAPIButtonURL = URL(string: fourAPIButtonLine) {
                 print("執行第\(z)次照片時間\(Date())")
                 webAPIImageCollection[z].kf.setImage(with: fourAPIButtonURL)
                 print("出現第\(z)次照片時間\(Date())")
             }
         }
         */
        
        
    }

}
