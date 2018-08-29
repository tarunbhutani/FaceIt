//
//  EmotionsViewController.swift
//  FaceIt
//
//  Created by InSynchro M SDN BHD on 13/08/2018.
//  Copyright © 2018 Tarun Bhutani. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {

    
    private let emotionalExpression = ["angrySegue" : FacialExpression(eye: .Closed, eyeBrows: .Furrowed, mouth: .Frown),
                                       "happySegue": FacialExpression(eye: .Open, eyeBrows: .Normal, mouth: .Smile),
                                       "worriedSegue": FacialExpression(eye: .Open, eyeBrows: .Relaxed, mouth: .Smirk),
                                       "mischieviousSegue": FacialExpression(eye: .Open, eyeBrows: .Furrowed, mouth: .Grin)]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

 
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navCon = segue.destination as? UINavigationController , let faceVC = navCon.visibleViewController as? FaceViewController{
            if let identifier = segue.identifier{
                if let expression = emotionalExpression[identifier]{
                    faceVC.expression = expression
                    if let button = sender as? UIButton{
                        faceVC.navigationItem.title = button.currentTitle ?? ""
                    }
                    
                }
            }
        }
    }
    
    

}
