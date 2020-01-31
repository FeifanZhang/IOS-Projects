//
//  ViewController.swift
//  DateManagement
//
//  Created by 张非凡 on 11/25/18.
//  Copyright © 2018 张非凡. All rights reserved.
//

import UIKit


class ViewController: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var calender: UICollectionView!
    @IBOutlet weak var timeLabel: UILabel!
    var currentYear = Calendar.current.component(.year, from: Date())
    var currentMonth = Calendar.current.component(.month, from: Date())
    var months=["January","February","March","April","May","June",
                "July","August","September","October","November","December"]
    var manageDate=[String:[[String:String]]]()
        //["20181226":[["from":"06:00","to":"06:30","detail":"i have to get up to catch the bus.","eventName":"getUp","setUpAlarm":"false"],["from":"10:00","to":"10:30","detail":"i have to get up to catch another bus.","eventName":"getUpAgain","setUpAlarm":"false"]]]
    //这个变量的写法是一种可以计算出来的属性
    var numberOfDaysInThisMonth:Int{
        let date=Calendar.current.date(from: DateComponents(year:self.currentYear,month:self.currentMonth))!
        let range=Calendar.current.range(of: .day, in: .month, for: date)
        return range?.count ?? 0
    }
    
    var startOfTheMonth:Int{
        let date=Calendar.current.date(from: DateComponents(year:self.currentYear,month:self.currentMonth))!
        return Calendar.current.component(.weekday,from: date)
    }

    @IBAction func nextMonth(_sender:UIButton){
        self.currentMonth += 1
        if currentMonth==13{
            currentMonth=1
            self.currentYear+=1
        };setUp()
    }
    
    @IBAction func lastMonth(_sender:UIButton){
        self.currentMonth -= 1
        if currentMonth==0{
            currentMonth=12
            self.currentYear-=1
        };setUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserDefaults.standard.set(manageDate, forKey: "manageDate")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //返回一个ID为Cell的cell（如果已经存在就拿过来，如果没有，就创建一个）
        let cell=collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let isTheCurrentTime = currentYear==Calendar.current.component(.year, from: Date()) && currentMonth==Calendar.current.component(.month, from: Date()) && indexPath.row-startOfTheMonth+2==Calendar.current.component(.day, from: Date())
        if let textLable=cell.contentView.subviews[0] as? UILabel{
            if indexPath.row<self.startOfTheMonth-1{
                textLable.text=""
                cell.backgroundColor=UIColor.darkGray
            }else if isTheCurrentTime {
                textLable.text="\(indexPath.row-startOfTheMonth+2)"
                cell.backgroundColor=UIColor.red
            }else{
                textLable.text="\(indexPath.row-startOfTheMonth+2)"
                cell.backgroundColor=UIColor.darkGray
            }
        }
        return cell
    }
    //让cell可选与否
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        if indexPath.row<self.startOfTheMonth-1{
            return false
        }else{
            return true
        }
    }
   
    
    //每个section显示几个item
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfDaysInThisMonth+self.startOfTheMonth-1
    }
    
    //设置item左右间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //设置item上下间隔
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    //任意一种机型，每行显示7个cell
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width=collectionView.frame.width/7
        return CGSize(width: width, height: 40)
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func setUp(){
      timeLabel.text=self.months[self.currentMonth-1]+"  "+"\(currentYear)"
      let isTheCurrentTime = currentYear==Calendar.current.component(.year, from: Date()) && currentMonth==Calendar.current.component(.month, from: Date())
      if isTheCurrentTime{
          timeLabel.textColor=UIColor.red
      }else{
          timeLabel.textColor=UIColor.white
      };calender.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manageDate = (UserDefaults.standard.dictionary(forKey: "manageDate") as? [String : [[String : String]]]) ?? ["00000000":[["from":"00:00","to":"00:00","detail":"0","eventName":"0","setUpAlarm":"false"]]]
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationController?.navigationBar.largeTitleTextAttributes =
        [NSAttributedString.Key.foregroundColor:UIColor.white]
        // Do any additional setup after loading the view, typically from a nib.
        setUp()
    }
    
    //calender横屏时，重新计算cell大小的复写方法
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //机器横过来时，重新计算cell的大小，即呼叫 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath)方法
        self.calender.collectionViewLayout.invalidateLayout()
        calender.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier=="calendarAndManagement"{
            let date=self.calender.indexPathsForSelectedItems?[0][1]
            let key="\(currentYear)"+"\(currentMonth)"+"\(date!-startOfTheMonth+2)"
            if date!<self.startOfTheMonth-1{
                return
            }else if (manageDate[key] != nil){
                (segue.destination as! ManagementController).eventData=manageDate[key]!
            }
            (segue.destination as! ManagementController).viewController=self
            (segue.destination as! ManagementController).eventKey=key
            (segue.destination as! ManagementController).title="\(months[currentMonth-1])" +
            "  "+"\(date!-startOfTheMonth+2)"+"  "+"\(currentYear)"
        }
    }
    
    
}




