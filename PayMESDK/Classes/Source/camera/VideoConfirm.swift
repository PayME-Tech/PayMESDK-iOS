//
//  VideoConfirm.swift
//  PayMESDK
//
//  Created by HuyOpen on 11/23/20.
//
import AVKit
import UIKit

class VideoConfirm: UIViewController {
    var avatarVideo : URL?
    var player: AVPlayer!
    var avpController = AVPlayerViewController()
    let screenSize:CGRect = UIScreen.main.bounds
    internal var onSuccessRecording: ((URL) -> ())? = nil
    
    let videoView: UIView = {
        let videoView = UIView()
        videoView.layer.masksToBounds = true
        videoView.layer.borderWidth = 7
        videoView.layer.borderColor = UIColor(226,226,226).cgColor
        videoView.translatesAutoresizingMaskIntoConstraints = false
        return videoView
    }()
    
    let confirmTitle : UILabel = {
        let confirmTitle = UILabel()
        confirmTitle.textColor = UIColor(24,26,65)
        confirmTitle.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        confirmTitle.translatesAutoresizingMaskIntoConstraints = false
        confirmTitle.textAlignment = .center
        confirmTitle.lineBreakMode = .byWordWrapping
        confirmTitle.numberOfLines = 0
        confirmTitle.text = "Giữ gương mặt và mặt trước giấy tờ tuỳ thân trước ống kính máy quay"
        return confirmTitle
    }()
    
    let titleLabel : UILabel = {
        let titleLabel = UILabel()
        titleLabel.textColor = UIColor(24,26,65)
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.text = "Xác nhận hình chụp"
        return titleLabel
    }()
    
    let backButton: UIButton = {
        let button = UIButton()
        let bundle = Bundle(for: KYCFrontController.self)
        let bundleURL = bundle.resourceURL?.appendingPathComponent("PayMESDK.bundle")
        let resourceBundle = Bundle(url: bundleURL!)
        let image = UIImage(named: "32Px", in: resourceBundle, compatibleWith: nil)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let captureAgain: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("LÀM LẠI", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(UIColor(10,146,32), for: .normal)
        return button
    }()
    
    let confirm: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.setTitle("HOÀN TẤT", for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backButton)
        view.addSubview(videoView)
        view.addSubview(titleLabel)
        view.addSubview(captureAgain)
        view.addSubview(confirm)
        view.addSubview(confirmTitle)
        view.backgroundColor = .white
        
        if #available(iOS 11, *) {
          let guide = view.safeAreaLayoutGuide
          NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.4),
            captureAgain.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -18),
            confirm.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -18)
           ])
        } else {
           let standardSpacing: CGFloat = 8.0
           NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
            titleLabel.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing + 5),
            captureAgain.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -standardSpacing),
            confirm.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -standardSpacing)
           ])
        }
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        captureAgain.heightAnchor.constraint(equalToConstant: 50).isActive = true
        captureAgain.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        captureAgain.widthAnchor.constraint(equalToConstant: (screenSize.width / 2) - 20).isActive = true
        
        confirm.heightAnchor.constraint(equalToConstant: 50).isActive = true
        confirm.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        confirm.widthAnchor.constraint(equalToConstant: (screenSize.width / 2) - 20).isActive = true
        
        videoView.widthAnchor.constraint(equalToConstant: (screenSize.width)*0.67).isActive = true
        videoView.heightAnchor.constraint(equalToConstant: (screenSize.width)).isActive = true
        videoView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        videoView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50).isActive = true
        
        
        confirmTitle.topAnchor.constraint(equalTo: videoView.bottomAnchor, constant: 21).isActive = true
        confirmTitle.leadingAnchor.constraint(equalTo: videoView.leadingAnchor).isActive = true
        confirmTitle.trailingAnchor.constraint(equalTo: videoView.trailingAnchor).isActive = true
        
        backButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
        
        backButton.addTarget(self, action: #selector(back), for: .touchUpInside)
        captureAgain.addTarget(self, action: #selector(back), for: .touchUpInside)
        confirm.addTarget(self, action: #selector(capture), for: .touchUpInside)
        
        player = AVPlayer(url: avatarVideo!)

        avpController.player = player

        avpController.view.frame.size.height = videoView.frame.size.height

        avpController.view.frame.size.width = videoView.frame.size.width
        
        avpController.videoGravity = AVLayerVideoGravity.resize



        self.videoView.addSubview(avpController.view)
        // Do any additional setup after loading the view.
    }
    @objc func back() {
        navigationController?.popViewController(animated: true)
    }
    @objc func capture() {
        onSuccessRecording!(avatarVideo!)
    }
    override func viewDidLayoutSubviews() {
        captureAgain.applyGradient(colors: [UIColor(hexString: PayME.configColor[0]).withAlphaComponent(0.3).cgColor, UIColor(hexString: PayME.configColor.count > 1 ? PayME.configColor[1] : PayME.configColor[0]).withAlphaComponent(0.3).cgColor], radius: 10)
        captureAgain.setTitleColor(UIColor(hexString: PayME.configColor[0]), for: .normal)
        confirm.applyGradient(colors: [UIColor(hexString: PayME.configColor[0]).cgColor, UIColor(hexString: PayME.configColor.count > 1 ? PayME.configColor[1] : PayME.configColor[0]).cgColor], radius: 10)
        confirm.setTitleColor(.white, for: .normal)
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
