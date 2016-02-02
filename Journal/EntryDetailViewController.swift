//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Douglas Goodwin on 12/3/15.
//  Copyright © 2015 Dr.G. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation
import AVKit
import MobileCoreServices

class EntryDetailViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet var recordButton: UIButton!
    

    
    private var data : NSURL?
    var entry: Entry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func recordButtonTapped(sender: AnyObject) {
        
        // Check to see if this is a new video entry. If it is not, then present an alertView with options
        if self.entry != nil {
            let alert = UIAlertController(title: "Overwrite Video?", message: "Are you sure you wish to overwrite the current entry? This can't be undone.", preferredStyle: UIAlertControllerStyle.ActionSheet)
            alert.addAction(UIAlertAction(title: "Overwrite", style: UIAlertActionStyle.Destructive, handler: { (alert) -> Void in
                if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                    self.presentCamera()
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Play", style: UIAlertActionStyle.Default, handler: { (alert) -> Void in
                if let entry = self.entry {
                    self.performSegueWithIdentifier("avPlayerSegue", sender: nil)
                }
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            //if it is a new entry, check to see if camera is available, if so, present video camera
            if (UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)) {
                self.presentCamera()
            } else {
                let alert = UIAlertController(title: "No Camera Available", message: "There doesn't appear to be a functional camera aboard this ship.", preferredStyle: UIAlertControllerStyle.Alert)
                alert.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alert, animated: true, completion: nil)
                print("No camera available")
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let videoURL = info[UIImagePickerControllerMediaURL] as! NSURL
        let videoData = NSData(contentsOfURL: videoURL)
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory: AnyObject = paths[0]
        let dataPath = documentsDirectory.stringByAppendingPathComponent("/vid.MOV")
        let url = NSURL(string: dataPath)
        print("This is the url for the video:\(url!)")
        videoData?.writeToURL(url!, atomically: false)
//        let fileData = NSData(contentsOfFile: dataPath)
//        print("\(data)")
        if let url = url {
            self.data = url
        }
        if let unwrappedEntry = self.entry {
            unwrappedEntry.videoClip = url?.path
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if let entry = self.entry {
            entry.title = self.titleTextField.text!
            entry.text = self.bodyTextView.text
            entry.timestamp = NSDate()
            entry.videoClip? = (String?.None)!
            
        } else {
            if let data = self.data {
                if let path = data.path {
                    let newEntry = Entry(title: self.titleTextField.text!, text: self.bodyTextView.text, videoClip: path)
                    EntryController.sharedController.addEntry(newEntry)
                    self.entry = newEntry
                }
            }
        }
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func clearButtonTapped(sender: AnyObject) {
        
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    func updateWithEntry(entry: Entry) {
        self.entry = entry
        
        self.titleTextField.text = entry.title
        self.bodyTextView.text = entry.text
        
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()

        return true
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "avPlayerSegue" {
            let destination = segue.destinationViewController as? AVViewController
            let url = NSURL(string: (self.entry!.videoClip)!)
            destination?.videoURL = url
            let data = NSData(contentsOfFile: (url?.path)!)
            print("\(data)")
            destination?.player = AVPlayer(URL: url!)
//            destination.player?.play()
        }
    }
    
    func presentCamera() {
        let mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(UIImagePickerControllerSourceType.Camera)
        if let mediaTypes = mediaTypes {
            if mediaTypes.contains("public.movie") {
                let camera = UIImagePickerController()
                camera.sourceType = UIImagePickerControllerSourceType.Camera
                camera.mediaTypes = [kUTTypeMovie as String]
                camera.delegate = self
                self.presentViewController(camera, animated: true, completion: nil)
            }
        }
    }
}
