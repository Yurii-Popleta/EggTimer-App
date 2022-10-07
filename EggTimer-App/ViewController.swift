
import UIKit
import AVFoundation

 class ViewController: UIViewController {
    
    var player: AVAudioPlayer!
    
    let eggTimes = ["Soft": 5, "Medium": 7, "Hard": 12]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    @IBOutlet weak var labelnumber: UILabel!
    @IBOutlet weak var progreslabel: UIProgressView!
    
   
     @IBOutlet weak var soft: UIImageView!
     @IBOutlet weak var medium: UIImageView!
     @IBOutlet weak var hard: UIImageView!
     
    
    @IBAction func hardnessSelected(_ sender: UIButton) {

        updateToStartAppearance()
        
        labelnumber.text = sender.currentTitle!
        totalTime = eggTimes[sender.currentTitle!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)

    }
                        
    @objc func updateTimer() {
     
        if secondsPassed <= totalTime {
            
            progreslabel.progress = Float(secondsPassed) / Float(totalTime)
            updateAlphaOfEggs()
            print(secondsPassed)
            secondsPassed += 1
            
        } else {
            progreslabel.progress = 0.0
            timer.invalidate()
            secondsPassed = 0
            playSound()
            labelnumber.text = "Done!"
        }
    }
  
    func playSound(){
        
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try!AVAudioPlayer(contentsOf: url!)
        player.play()
        
    }

     
     func updateToStartAppearance() {
         
         timer.invalidate()
         secondsPassed = 0
         soft.alpha = 1
         medium.alpha = 1
         hard.alpha = 1
   
         if player?.isPlaying == true {
             player.stop()
         }
         
     }

     func updateAlphaOfEggs() {
         switch totalTime {
         case 5:
             soft.alpha = CGFloat(Float(secondsPassed) / Float(totalTime)) + 0.2
         case 7:
             medium.alpha = CGFloat(Float(secondsPassed) / Float(totalTime)) + 0.2
         case 12:
             hard.alpha = CGFloat(Float(secondsPassed) / Float(totalTime)) + 0.2
         default:
             return
         }
     }
     
     
 }







        
              
