//
//  BlinkingFaceViewController.swift
//  FaceIt
//
//  Created by InSynchro M SDN BHD on 27/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import UIKit

class BlinkingFaceViewController: FaceViewController {

    private struct BlinkRate {
        static let closedDuration = 0.4
        static let openDuration = 2.5
    }
    var blinking:Bool = false {
        didSet{
            startBlink()
        }
    }
    @objc func startBlink(){
        if blinking{
            faceView.eyesOpen = false
            Timer.scheduledTimer(timeInterval: BlinkRate.closedDuration, target: self, selector: #selector(BlinkingFaceViewController.endBlink), userInfo: nil, repeats: false)
        }
    }
    @objc func endBlink()  {
        faceView.eyesOpen = true
        
        Timer.scheduledTimer(timeInterval: BlinkRate.openDuration, target: self, selector: #selector(BlinkingFaceViewController.startBlink), userInfo: nil, repeats: false)
    }
 
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        blinking = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        blinking = false
    }
}
