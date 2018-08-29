//
//  ViewController.swift
//  FaceIt
//
//  Created by Tarun Bhutani on 10/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    @IBOutlet weak var faceView: FaceView!{
        didSet{
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(_:))))
            
            let happierSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(increaseHappiness))
            happierSwipeGestureRecognizer.direction = .up
            faceView.addGestureRecognizer(happierSwipeGestureRecognizer)
            
            let sadderSwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(sadderHappiness))
            sadderSwipeGestureRecognizer.direction = .down
            faceView.addGestureRecognizer(sadderSwipeGestureRecognizer)
            
            updateFaceView()
            
        }
    }
    
    @IBAction func toggleEyes(_ sender: UITapGestureRecognizer) {
        if sender.state == .ended{
            switch expression.eye{
            case .Closed: expression.eye = .Open
            case .Open: expression.eye = .Closed
            case .Squinting : break
            }
        }
    }
    
    private struct Animation {
        static let shakeAngle = CGFloat(M_PI/6)
        static let shakeDuration = 0.5
    }
    
    @IBAction func headShake(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: Animation.shakeDuration,
        animations: {
            self.faceView.transform = CGAffineTransform(rotationAngle: Animation.shakeAngle)
        },
        completion: { finished in
            if finished{
                UIView.animate(withDuration: Animation.shakeDuration,
                animations: {
                    self.faceView.transform = CGAffineTransform(rotationAngle: -Animation.shakeAngle)
                },
                completion: { finished in
                    if finished{
                        UIView.animate(withDuration: Animation.shakeDuration,
                        animations: {
                            self.faceView.transform = CGAffineTransform(rotationAngle: 0)
                        },
                        completion: { finished in
                            if finished{
                            }
                        })
                    }
                })
            }
        })
    }
    @objc func increaseHappiness()  {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    @objc func sadderHappiness()  {
        expression.mouth = expression.mouth.sadderMouth()
    }
    
    private var mouthCurvature = [FacialExpression.Mouth.Frown: -1.0, .Grin:0.5, .Smile:1.0,.Smirk: -0.5, .Neutral:0.0]
    
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Furrowed: -0.5, .Normal: 0.0]
    
    var expression = FacialExpression(eye : .Closed, eyeBrows : .Relaxed, mouth: .Smirk) {
        didSet { updateFaceView() }
    }
    
    private func updateFaceView(){
        if faceView == nil{ return }
        
        switch expression.eye {
        case .Open:
            faceView.eyesOpen = true
        case .Closed:
            faceView.eyesOpen = false
        case .Squinting:
            faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvature[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

