//
//  GameViewController.swift
//  Accelerometer
//
//  Created by Sakai Aoi on 2021/02/07.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController {
    
    @IBOutlet var awaImageView: UIImageView!
    let motionManager = CMMotionManager()
    var accelerationX: Double = 0.0
    var accelerationY: Double = 0.0
    var accelerationZ: Double = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let maxWidth :CGFloat = self.awaImageView.frame.size.width
        print(maxWidth)
        self.awaImageView.frame.size.width = 5
        
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.01
            motionManager.startAccelerometerUpdates(to: OperationQueue.current!){data, error in
                self.accelerationX = (data?.acceleration.x)!
                self.accelerationY = (data?.acceleration.y)!
                self.accelerationZ = (data?.acceleration.z)!
                print(self.accelerationZ)
                self.awaImageView.center.x += CGFloat(self.accelerationX*20)
                self.awaImageView.center.y += CGFloat(self.accelerationY*(-20))
                
                
                if self.awaImageView.frame.origin.x < 20 {
                    self.awaImageView.frame.origin.x = 20
                }
                
                if self.awaImageView.frame.origin.x > 240 {
                    self.awaImageView.frame.origin.x = 240
                }
                
                if self.awaImageView.frame.origin.y < 20 {
                    self.awaImageView.frame.origin.y = 20
                }
                
                if self.awaImageView.frame.origin.y > 500 {
                    self.awaImageView.frame.origin.y = 500
                }
                
                //print(self.awaImageView.frame.size.width)
                if 0.95 < fabs(self.accelerationZ) && fabs(self.accelerationZ) < 1.05 {
                    self.awaImageView.frame.size.width = maxWidth
                }else{
                    self.awaImageView.frame.size.width = 5
                }
                
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultViewController: ResultViewController = segue.destination as! ResultViewController
        resultViewController.accelerationX = self.accelerationX
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

