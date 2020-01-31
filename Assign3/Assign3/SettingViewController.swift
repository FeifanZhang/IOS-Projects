
import UIKit

class SettingViewController: UIViewController {
    
    var red:Float=0.0
    var green:Float=0.0
    var blue:Float=0.0
    
    var redBall:Float=0
    var greenBall:Float=0
    var blueBall:Float=0
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var setSwitch:UISwitch!
    
    @IBOutlet var nameOfLable:UILabel!
    
    
    @IBAction func updateSliders(){
        if(self.setSwitch.isOn){
            self.redSlider.value = self.red
            self.greenSlider.value = self.green
            self.blueSlider.value = self.blue
            self.nameOfLable.text="Back Ground Color"
        }else{
            self.redSlider.value=self.redBall
            self.greenSlider.value = self.greenBall
            self.blueSlider.value=self.blueBall
            self.nameOfLable.text="Ball Color"
        }
    }
    
    @IBAction func modifyColor(){
        //isOn==true call modifyBackground
        if(setSwitch.isOn){
            modifyBackGroundColor()
            self.red = self.redSlider.value
            self.green=self.greenSlider.value
            self.blue=self.blueSlider.value
        }else{
            modifyBallColor()
            self.redBall = self.redSlider.value
            self.greenBall=self.greenSlider.value
            self.blueBall=self.blueSlider.value
        }
    }
    
    func modifyBallColor(){
        (self.view as! BounceView).ballColor=UIColor(red: CGFloat(self.redSlider.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(self.blueSlider.value), alpha: 1.0)
        (self.view as! BounceView).modifyColor()
    }
    
    func modifyBackGroundColor(){
        (self.view as! BounceView).color=UIColor(red: CGFloat(self.redSlider.value), green: CGFloat(self.greenSlider.value), blue: CGFloat(self.blueSlider.value), alpha: 1.0)
        (self.view as! BounceView).modifyColor()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        var position=CGPoint()
        var vel=CGPoint()
        vel.x=CGFloat(0)
        vel.y=CGFloat(7)
        position.y=(self.view.frame.origin.y + self.view.frame.size.height)/4
        position.x=(self.view.frame.origin.x+self.view.frame.size.width)/2
        (self.view as! BounceView).addParticle(at: position, with: vel)
        let timer = Timer(timeInterval: 1/30.0, repeats: true, block: {(v) -> Void in (self.view as! BounceView).updateParticles(bottom:self.view.frame.origin.y + self.view.frame.size.height, top:self.view.frame.origin.y,right:self.view.frame.origin.x+self.view.frame.size.width,left:self.view.frame.origin.x,gravity:CGFloat(1),damping:CGFloat(-0.0235))})
        RunLoop.current.add(timer, forMode: .defaultRunLoopMode)
        (self.view as! BounceView).color=UIColor(red: CGFloat(self.red), green: CGFloat(self.green), blue: CGFloat(self.blue), alpha: 1.0)
        (self.view as! BounceView).ballColor=UIColor(red: CGFloat(self.redBall), green: CGFloat(self.greenBall), blue: CGFloat(self.blueBall), alpha: 1.0)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if(self.setSwitch.isOn){
            self.redSlider.value = self.red
            self.greenSlider.value = self.green
            print("green is\(green)")
            print("greenSlider is\(greenSlider.value)")
            self.blueSlider.value = self.blue
        }else{
            self.redSlider.value=self.redBall
            self.greenSlider.value = self.greenBall
            self.blueSlider.value=self.blueBall
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! ViewController).red = self.red
        (segue.destination as! ViewController).green = self.green
        print("greenSlider pass is:\(greenSlider.value)")
         print("green pass is:\(self.greenBall)")
        (segue.destination as! ViewController).blue = self.blue
        (segue.destination as! ViewController).redBall=self.redBall
        (segue.destination as! ViewController).greenBall=self.greenBall
        (segue.destination as! ViewController).blueBall=self.blueBall
    }
}
