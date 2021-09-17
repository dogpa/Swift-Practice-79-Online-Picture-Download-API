//
//  ViewController.swift
//  Swift Practice # 79 Online Picture Download API
//
//  Created by Dogpa's MBAir M1 on 2021/9/17.
//

import UIKit

import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var starPhotoImageView: UIImageView!
    
    let NasaWebLink = "https://imagine.gsfc.nasa.gov/hst_bday/images/"
    let starArray = [
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
    
    
    var nasaTimer: Timer?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //無套件寫法
        
        //列印時間
        print("\nviewDidLoad讀入時間\(Date())")
        //指派starForViewDidLoad取得starArray內隨機網址
        let starForViewDidLoad = self.NasaWebLink + (self.starArray.randomElement())!
        //指派url嘗試將剛剛取得的starForViewDidLoad轉型成為網址，若沒有網址回傳空字串
        if let url = URL(string: starForViewDidLoad ) {
            //透過URLSession.shared.dataTask帶入網址url
            URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                //嘗試將date指派為剛剛的透過 URLSession.shared.dataTask轉型的url
                //並嘗試image指派為UIImage類別的值，內容透過(data: data)來取得網路資料
                if let data = data, let image = UIImage(data: data){
                    //於主執行緒來將剛剛取得的image指派到self.starPhotoImageView上
                    DispatchQueue.main.async {
                        self.starPhotoImageView.image = image
                        
                    }
                    //列印時間
                    print("show出照片時間\(Date())")
                }
            }.resume()
            //列印時間
            print("執行URLSession.shared.dataTask時間\(Date())")
        }
         
        
        //自動無限輪播網路抓圖
        /*
        Timer.scheduledTimer(withTimeInterval: 10, repeats: true) { Timer in
            let star = self.starArray.randomElement()
            if let url = URL(string: star ?? "") {
                URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                    if let data = data, let image = UIImage(data: data){
                        DispatchQueue.main.async {
                            self.starPhotoImageView.image = image
                            print("show時間\(Date())")
                        }
                        
                    }
                }.resume()
                print("執行時間\(Date())")
            }
        }
        print("載入時間\(Date())")
        */
        
        

        

    }
    
    
    @IBAction func autoChageNasaPhoto(_ sender: UISwitch) {
        
        //判斷是否有開啟開關
        if sender.isOn == true {
            //列印時間
            print("\n執行自動輪播時間\(Date())")
            //nasaTimer指派為開啟自動輪播
            self.nasaTimer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { Timer in
                //指派autoPlatNasaLink取得字串
                let autoPlatNasaLink = self.NasaWebLink + (self.starArray.randomElement())!
                //if let 嘗試指派url使用autoPlatNasaLink
                if let url = URL(string: autoPlatNasaLink) {
                    //使用 URLSession.shared.dataTask取得資料
                    URLSession.shared.dataTask(with: url) { data, URLResponse, Error in
                        //if let 如果有資料 以及image能指派為UIImage
                        if let data = data, let image = UIImage(data: data){
                            //透果主執行緒將starPhotoImageView照片顯示為取得的data
                            print("\n執行時間DispatchQueue.main.\(Date())")
                            DispatchQueue.main.async {
                                self.starPhotoImageView.image = image
                                print("show出照片時間\(Date())")
                            }
                        }
                    }.resume()
                    
                }
            }
            
        }else{
            self.nasaTimer?.invalidate()
        }
        
        
    }
    
    
    
    @IBAction func changeNasaImag(_ sender: UIButton) {
        print("\nButton按下時間\(Date())")
        let buttonStar = self.NasaWebLink + (self.starArray.randomElement())!
        if let url = URL(string: buttonStar) {
            print("指派 URL抓資料時間\(Date())")
            //透過kimgfisher的套件直接指派照片
            starPhotoImageView.kf.setImage(with: url)       //透過kimgfisher的套件直接指派照片
            print("執行完畢時間\(Date())")
        }
        
    }
    

}

