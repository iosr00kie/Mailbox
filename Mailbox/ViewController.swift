//
//  ViewController.swift
//  Mailbox
//
//  Created by Deepak Deshpande on 10/18/15.
//  Copyright © 2015 walmart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var feedScrollView: UIScrollView!
    
    @IBOutlet weak var messageBackView: UIView!
    
    @IBOutlet weak var singleMessageImage: UIImageView!
    
    @IBOutlet weak var laterImage: UIImageView!
    
    @IBOutlet weak var deleteIcon: UIImageView!
    
    @IBOutlet weak var archiveIcon: UIImageView!
    

    @IBOutlet weak var reschedView: UIView!
    
    @IBOutlet weak var reschedImage: UIImageView!
    
    
    var singleMessageInitialCenter: CGPoint!
    
    var laterImageCenter: CGPoint!
    
    var archiveImageCenter: CGPoint!
    
    var deleteImageCenter: CGPoint!
    
    var listImageCenter: CGPoint!
    

    @IBOutlet weak var mainView: UIView!
    
    var mainViewCenter: CGPoint!
    
    
    @IBOutlet weak var menuImage: UIImageView!
    
    
    @IBOutlet weak var listImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        feedScrollView.contentSize = CGSize(width: 320, height: 2200)
        
        //Set centers of all images
        singleMessageInitialCenter = singleMessageImage.center
        laterImageCenter = laterImage.center
        archiveImageCenter = archiveIcon.center
        deleteImageCenter = deleteIcon.center
        listImageCenter = listImage.center
        mainViewCenter = mainView.center
        
        //Hide all background images
        menuImage.alpha = 0
        reschedImage.alpha = 0
        reschedView.alpha = 0
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
    @IBAction func didSwipeMenu(sender: UIPanGestureRecognizer) {
        
        
        var mainTranslation = sender.translationInView(view)
        print("In DidSwipeMenu: \(mainTranslation)")
        
        
        if(sender.state == UIGestureRecognizerState.Began){
            menuImage.alpha = 1
        }
        else if(sender.state == UIGestureRecognizerState.Changed){
            if(mainTranslation.x > 0){
                mainView.center.x = mainViewCenter.x + mainTranslation.x
                self.menuImage.alpha = 1
            }
            else {
                UIView.animateWithDuration(0.5, animations: { () -> Void in
                    self.mainView.center = self.mainViewCenter
                    
                    if(self.mainView.center == self.mainViewCenter){
                        self.menuImage.alpha = 0
                    }
                    
                })
                
            }
        }
        else if(sender.state == UIGestureRecognizerState.Ended){
            if(mainView.center == mainViewCenter){
                menuImage.alpha = 0
                
            }
        }
    }
    
    
    

    @IBAction func didPressPan(sender: UIPanGestureRecognizer) {
        
        
        var location = sender.locationInView(view)
        
        var translation = sender.translationInView(view)
        
        var velocity = sender.velocityInView(view)
        
        print("Velocity: \(velocity)")
        print("Translation.x: \(translation.x)")
        print("later icon Initial center: \(laterImageCenter)")
        
        
        
        
        if(sender.state == UIGestureRecognizerState.Changed){
        
        UIView.animateWithDuration(0) { () -> Void in
            
            if(translation.x > 0 && translation.x < 60) {
                
                //User swipes to the right less than 60 pts
                
                self.singleMessageImage.center.x = self.singleMessageInitialCenter.x + translation.x
                self.messageBackView.backgroundColor = UIColor.grayColor()
                self.deleteIcon.hidden = true
                self.archiveIcon.hidden = false
                self.laterImage.hidden = true
                self.listImage.hidden = true
            }
            else if (translation.x > 60 && translation.x < 260){
                
                // user swipes to the right more than 60 but less than 260
                
                self.deleteIcon.hidden = true
                self.archiveIcon.hidden = false
                self.laterImage.hidden = true
                self.listImage.hidden = true
                self.singleMessageImage.center.x = self.singleMessageInitialCenter.x + translation.x
                self.archiveIcon.center.x = self.archiveImageCenter.x + translation.x - 60
                self.deleteIcon.center.x = self.deleteImageCenter.x + translation.x - 60
                
                self.messageBackView.backgroundColor = UIColor.greenColor()
            }
            else if(translation.x > 260) {
                
                // user swipes to the right more than 260
                
                self.deleteIcon.hidden = false
                self.archiveIcon.hidden = true
                self.laterImage.hidden = true
                self.listImage.hidden = true
                self.singleMessageImage.center.x = self.singleMessageInitialCenter.x + translation.x
                self.archiveIcon.center.x = self.archiveImageCenter.x + translation.x - 60
                self.deleteIcon.center.x = self.deleteImageCenter.x + translation.x - 60
                self.messageBackView.backgroundColor = UIColor.redColor()
            }
            else if (translation.x < 0 && translation.x > -60){
                
                // user swipes to the left less than 60 pts
                
                self.deleteIcon.hidden = true
                self.archiveIcon.hidden = true
                self.laterImage.hidden = false
                self.listImage.hidden = true
                self.singleMessageImage.center.x = self.singleMessageInitialCenter.x + translation.x
                self.messageBackView.backgroundColor = UIColor.grayColor()
            }
            else if (translation.x < -60 && translation.x > -230){
                
                //user swipes to the left between 60 and 260
                
                self.deleteIcon.hidden = true
                self.archiveIcon.hidden = true
                self.laterImage.hidden = false
                self.listImage.hidden = true
                self.singleMessageImage.center.x = self.singleMessageInitialCenter.x + translation.x
                self.laterImage.center.x = self.laterImageCenter.x + translation.x + 60
                self.listImage.center.x = self.listImageCenter.x + translation.x + 60
                self.messageBackView.backgroundColor = UIColor.orangeColor()
            }
            else if(translation.x < -230 && translation.x > -260){
                
                // user swipes to the left more than 260
                print("Negative translation now is: \(translation.x)")
                self.deleteIcon.hidden = true
                self.archiveIcon.hidden = true
                self.laterImage.hidden = true
                self.listImage.hidden = false
                self.singleMessageImage.center.x = self.singleMessageInitialCenter.x + translation.x
                self.laterImage.center.x = self.laterImageCenter.x + translation.x + 60
                self.listImage.center.x = self.listImageCenter.x + translation.x + 60
                self.messageBackView.backgroundColor = UIColor.brownColor()
                
                
            }
            else if (translation.x < -260){
                UIView.animateWithDuration(1, animations: { () -> Void in
                    self.reschedImage.alpha = 1
                    self.reschedView.alpha = 1
                })
                
            }
            
            
            
            
            }
        
        } else if(sender.state == UIGestureRecognizerState.Ended){
            print("On Gesture End - Translation.x: \(translation.x)")
            if((translation.x < 0 && translation.x > -260) || (translation.x > 0)) {
                UIView.animateWithDuration(0.5) { () -> Void in
                    self.singleMessageImage.center.x = self.singleMessageInitialCenter.x
                    self.laterImage.center = self.laterImageCenter
                    self.listImage.center = self.laterImageCenter
                    self.messageBackView.backgroundColor = UIColor.whiteColor()

                    
                }
            }
        }
        
        }


    @IBAction func didTapReschedImage(sender: AnyObject) {
        reschedView.alpha = 0
        reschedImage.alpha = 0
        self.singleMessageImage.center.x = self.singleMessageInitialCenter.x
    }


}


