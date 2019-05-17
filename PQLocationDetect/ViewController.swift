//
//  ViewController.swift
//  PQLocationDetect
//
//  Created by RengTsai on 2019/5/14.
//  Copyright © 2019 RengTsai. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation
import SwiftOSC

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let motionManager = CMMotionManager()
    var timer: Timer!
    var client = OSCClient(address: "192.168.0.100", port: 8080)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        motionManager.startAccelerometerUpdates()
        motionManager.startGyroUpdates()
        motionManager.startMagnetometerUpdates()
        motionManager.startDeviceMotionUpdates()
        
        timer = Timer.scheduledTimer(timeInterval: 1.0/30.0, target: self, selector: #selector(ViewController.update), userInfo: nil, repeats: true)
    }
    
    @objc func update() {
//        if let accelerometerData = motionManager.accelerometerData {
//            print(accelerometerData.acceleration)
//            let message = OSCMessage(
//                OSCAddressPattern("/pos"),
//                accelerometerData.acceleration.x,
//                accelerometerData.acceleration.y,
//                accelerometerData.acceleration.z
//            )
//            client.send(message)
//        }
        let gyroData = motionManager.gyroData;
        let magnetometerData = motionManager.magnetometerData;
        
        let deviceMotion = motionManager.deviceMotion;
        
//        print(deviceMotion);
        
        let message = OSCMessage(
            OSCAddressPattern("/acc"),
            deviceMotion?.userAcceleration.x,
            deviceMotion?.userAcceleration.y,
            deviceMotion?.userAcceleration.z,
            deviceMotion?.attitude.pitch,
            deviceMotion?.attitude.roll,
            deviceMotion?.attitude.yaw
        );
        //print(message);
        client.send(message)
            
        
      
    }
}

