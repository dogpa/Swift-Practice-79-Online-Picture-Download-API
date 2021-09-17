//
//  FourNasaImageViewController.swift
//  Swift Practice # 79 Online Picture Download API
//
//  Created by Dogpa's MBAir M1 on 2021/9/17.
//

import UIKit

class FourNasaImageViewController: UIViewController {

    
    @IBOutlet var nasaImageCollection: [UIImageView]!
    
    let fourNasaWebLink = "https://imagine.gsfc.nasa.gov/hst_bday/images/"
    var fourstarArray = [
        "january-3-2019-ngc-4302-and-ngc-4298.png",
        "january-30-2019-galaxy-ngc-5584.jpg",
        "february-5-2019-asteroid-6478-gault.png",
        "february-28-2019-galactic-center.jpg",
        "march-4-2019-galaxy-fornax-a.jpg",
        "march-22-2019-saturn.jpg",
        "april-8-2019-galaxy-ngc-4650a.jpg",
        "april-29-2019-nebula-n-180b.jpg",
        "may-9-2019-red-spots-on-jupiter.jpg",
        "may-23-2019-galaxy-cluster-abell-2744.jpg",
        "june-10-2019-galaxy-ngc-7674.jpg",
        "june-21-2019-galaxy-cluster-abell-1689.jpg",
        "july-13-2019-star-cluster-ngc-346.jpg",
        "july-18-2019-interacting-galaxies-am-1316-241.jpg",
        "august-15-2019-triangulum-galaxy.png",
        "august-25-2019-herbig-haro-32.jpg",
        "september-7-2019-hubble-x-nebula.jpg",
        "september-24-2019-galaxy-eso-243-49.jpg",
        "october-1-2019-galaxy-ngc-3949.jpg",
        "october-8-2019-galaxy-hercules-a.jpg",
        "november-13-2019-nebula-n44c.jpg",
        "november-29-2019-mars.jpg",
        "december-2-2019-whirlpool-galaxy-in-infrared.jpg",
        "december-31-2019-galaxy-m81.jpg"
    ]
    var saveFourImageLinkArray:[String] = []
    var fourNasaTimer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("\nviewDidLoad讀入時間\(Date())")
        fourstarArray.shuffle()
        
        for i in 0...3 {
            saveFourImageLinkArray.append(fourNasaWebLink+fourstarArray[i])
            if let url = URL(string: saveFourImageLinkArray[i]){
                URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                   
                    if let data = data, let image = UIImage(data: data){
                       
                        DispatchQueue.main.async {
                            self.nasaImageCollection[i].image = image
                            
                        }
                        print("show出第\(i)次照片時間\(Date())")
                    }
                }.resume()
                print("執行第\(i)次URLSession.shared.dataTask時間\(Date())")
            }
            
        }
        print(saveFourImageLinkArray)
        

        
    }
    
    
    
    @IBAction func fourNasaChangePhoto(_ sender: UISwitch) {
        if sender.isOn == true {
            print("\n啟動四頁自動輪播時間\(Date())")
            self.fourNasaTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true, block: { Timer in
                self.fourstarArray.shuffle()
                self.saveFourImageLinkArray = []
                for x in 0...3 {
                    self.saveFourImageLinkArray.append(self.fourNasaWebLink+self.fourstarArray[x])
                    if let fourUrl = URL(string: self.saveFourImageLinkArray[x]) {
                        URLSession.shared.dataTask(with: fourUrl) { data, URLResponse, Error in
                            if let data = data, let image = UIImage(data: data){
                                DispatchQueue.main.async {
                                    self.nasaImageCollection[x].image = image
                                }
                                print("show出輪播第\(x)張照片時間\(Date())")
                            }
                        }.resume()
                    }
                }
            })
        }else{
            self.fourNasaTimer?.invalidate()
        }
    }
    
    
    @IBAction func touchToChangeFourPhoto(_ sender: UIButton) {
        print("\nButton按下時間\(Date())")
        fourstarArray.shuffle()
        saveFourImageLinkArray = []
        for y in 0...nasaImageCollection.count - 1{
            self.saveFourImageLinkArray.append(fourNasaWebLink+fourstarArray[y])
            if let nasaButtonUrl = URL(string: saveFourImageLinkArray[y]) {
                print("第\(y)次取得Url時間\(Date())")
                nasaImageCollection[y].kf.setImage(with: nasaButtonUrl)
                print("第\(y)次照片設定完成時間\(Date())")
            }
        }
        
        
    }
    
    
 
}
