//
//  ManagementControllerCell.swift
//  DateManagement
//
//  Created by 张非凡 on 11/26/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation


class SubRoomControllerCell:UITableViewCell{
    var title:UILabel?
    var player:AVPlayerLayer?
    var play:AVPlayer?
    var processBar:UISlider?
    var url:String? {
        didSet{
            if url?.isEmpty==false {
                self.renderCell()
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUpUI()
    }
    
    private func renderCell() {
        for layer in self.layer.sublayers!{
            if type(of: layer).isEqual(type(of: AVPlayerLayer())) {
                layer.removeFromSuperlayer()
                self.setUpPlayer()
                break
            }
        };for view in self.contentView.subviews {
            if type(of: view).isEqual(type(of: UISlider())) {
                view.removeFromSuperview()
                self.setUpProcessBar()
                break
            }
        };
    }
    
    private func setUpTitle() {
        if self.title == nil{
            //title配置
            self.title=UILabel.init()
            self.title?.backgroundColor=UIColor.clear;
            //frame的minY是指frame在Y轴上的起始位置，maxY是指Y轴的终止位置 x同理
            self.title?.frame=CGRect(x:20,y:0,width:self.frame.maxX,height:40)
            self.title?.font=UIFont.systemFont(ofSize: 18)
            self.title?.textColor=UIColor.black
            //自动换行
            self.title?.lineBreakMode=NSLineBreakMode.byWordWrapping
            self.title?.numberOfLines=0
            self.contentView.addSubview(self.title!)
        }
    }
    
    private func setUpProcessBar() {
        //进度条设置
        self.processBar=UISlider.init()
        self.processBar?.frame=CGRect(x:30,y:260,width:self.frame.maxX-60,height:10)
        self.play?.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 1), queue: DispatchQueue.main) { [weak self](time) in
            //当前正在播放的时间
            let loadTime = CMTimeGetSeconds(time)
            //视频总时间
            let totalTime = CMTimeGetSeconds(self?.play?.currentItem?.duration ?? CMTimeMake(value: Int64(0), timescale: 1))
            //播放进度设置
            self?.processBar?.value = Float(loadTime/totalTime)
        };self.contentView.addSubview(self.processBar!)
        self.processBar?.isContinuous=false
        self.processBar?.addTarget(self,action: #selector(controlTime), for: UIControl.Event.valueChanged)
    }
    
    private func setUpPlayer() {
        //VideoUI播放配置
        //定义一个视频文件路径
        var filePath = Bundle.main.path(forResource: url  , ofType: "mov")
        if filePath == nil {
            filePath = Bundle.main.path(forResource: "Assign1"  , ofType: "mov")
        };let videoURL = URL(fileURLWithPath: filePath!)
        //定义一个视频播放器，通过本地文件路径初始化
        self.play = AVPlayer(url: videoURL)
        self.player = AVPlayerLayer(player: play)
        self.player?.frame = CGRect(x:0,y:50,width:self.frame.maxX,height:200)
        self.layer.addSublayer(self.player!)
        self.play?.pause()
    }
    
    func setUpUI() {
        self.setUpTitle()
        self.setUpPlayer()
        self.setUpProcessBar()
    }
    
    @objc func controlTime() {
        let duration = self.processBar!.value * Float(CMTimeGetSeconds(self.play!.currentItem!.duration))
        self.play?.seek(to: CMTimeMake(value: Int64(duration), timescale: 1))
        self.play?.play()
    }
    
}

