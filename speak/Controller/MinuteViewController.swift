//
//  MinuteViewController.swift
//  speak
//
//  Created by Anya Akbar on 30/04/21.
//

import UIKit
import AVFoundation
import SoundAnalysis


class MinuteViewController: UIViewController {
    
// +++++++++++trial+++++++
    private let audioEngine = AVAudioEngine()
    private var soundClassifier = InterjectionRecognizer()
    
    var inputFormat: AVAudioFormat!
    var analyzer: SNAudioStreamAnalyzer!
    var resultsObserver = ResultsObserver()
    let analysisQueue = DispatchQueue(label: "com.custom.AnalysisQueue")
    var audioOn = false
    
    private func startAudioEngine() {
        do {
            let request = try SNClassifySoundRequest(mlModel: soundClassifier.model)
            try analyzer.add(request, withObserver: resultsObserver)
        } catch {
            print("Unable to prepare request: \(error.localizedDescription)")
            return
        }
       
        audioEngine.inputNode.installTap(onBus: 0, bufferSize: 8000, format: inputFormat) { buffer, time in
                self.analysisQueue.async {
                    self.analyzer.analyze(buffer, atAudioFramePosition: time.sampleTime)
                }
        }
        
        do{
        try audioEngine.start()
            audioOn = true
        }catch( _){
            print("error in starting the Audio Engine")
        }
    }
    
   
    @IBOutlet weak var inputLabel: UILabel!
    
    func setInputLabel() {
        inputLabel.font = UIFont.Bold(size: 20)
        inputLabel.numberOfLines = 0
        inputLabel.textColor = UIColor.bold
        inputLabel.textAlignment = .center
        inputLabel.text = "Tap the mic to start the timer and the speak analyzer"
    }
    
    func removeAudioEngine() {
        audioEngine.inputNode.reset()
        audioEngine.inputNode.removeTap(onBus: 0)
//        print("removed")
        
    }
    

//  +++++++++++trial+++++++
    
    let minuteData : [Challenge] = Challenge.generateDataChallenge()
    
    var choosenChallenge: Challenge = Challenge()
    
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var navItem: UINavigationItem!
    @IBOutlet weak var navMinuteBar: UINavigationBar!
    

    
    
    
    
    override func viewDidLoad() {
        resultsObserver.delegate = self
        inputFormat = audioEngine.inputNode.inputFormat(forBus: 0)
        analyzer = SNAudioStreamAnalyzer(format: inputFormat)
        
        setUI()
        setProggressBar()
        setInputLabel()
        
        super.viewDidLoad()
        
        }
    
    func setUI() {
        timerConstant = Double(choosenChallenge.secondsPerChallenge)
        timerTimeNow = timerConstant
        
        self.title = "\(choosenChallenge.title)"
//        Navigation bar
        navMinuteBar.barTintColor = UIColor.background
        let attribute = [NSAttributedString.Key.font: UIFont.Bold(size: 20), NSAttributedString.Key.foregroundColor: UIColor.bold]
        
        let attribute2 = [NSAttributedString.Key.font: UIFont.Bold(size: 20), NSAttributedString.Key.foregroundColor: UIColor.green]
        
        navMinuteBar.titleTextAttributes = attribute as [NSAttributedString.Key : Any]
        navItem.title = self.title
        
        navItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goTo))
        
        navItem.leftBarButtonItem?.title = "The Challenge"
        
//        navItem.leftBarButtonItem = UIBarButtonItem(title: "Practice Space", style: .plain, target: self, action: #selector(goTo))
        
        navItem.leftBarButtonItem?.setTitleTextAttributes(attribute2 as [NSAttributedString.Key : Any], for: .normal)
        
        navItem.leftBarButtonItem?.tintColor = UIColor.bold
        
        view.backgroundColor = UIColor.background
    
        
           

        }
    
    @objc func goTo() {
        self.performSegue(withIdentifier: "PracticeSegue", sender: self)
        timerOn = false
        removeAudioEngine()
    }
    
    //    setting timer
    var timerText = ""
    var timerConstant : Double = Double()
    var timerTimeNow : Double = Double()
    var timer : Timer?
    var timerOn = true
    
    func timerStart() {
        timer =  Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(printTimer), userInfo: nil, repeats: true)

    }
    
    @objc func printTimer() {
        if timerTimeNow > 0 && timerOn == true {
//            print(timerTimeNow)
            timerTimeNow -= 1
            let timeNowToString = String(format: "%.0f", timerTimeNow)
            textLayer.string = "\(timeNowToString)"
    
        } else {
            timer?.invalidate()
            keepCounting = false
            
    
        }
    }
    
    @IBOutlet weak var micImage: UIImageView!
    //    setting proggress Bar
    let shapeLayer = CAShapeLayer()
    let textLayer = CATextLayer()
    func setProggressBar() {
        upperView.frame = CGRect(x: 10, y: 90, width: view.frame.width-20, height: view.frame.height/2-80)
        upperView.layer.cornerRadius = 16
        
//      label  timer timeleft
        let timeNowToString = String(format: "%.0f", timerTimeNow)
        textLayer.string = "\(timeNowToString)"
        textLayer.frame = CGRect(x: 10, y:upperView.frame.height/2-40, width: upperView.frame.width-20, height: 40)
        textLayer.font = UIFont.Bold(size: 60)
        textLayer.foregroundColor = UIColor.bold?.cgColor
        textLayer.alignmentMode = CATextLayerAlignmentMode.center
        upperView.layer.addSublayer(textLayer)
        
        
//        set proggress Bar
        let progressRoundPosition = CGPoint(x: upperView.bounds.size.width/2, y: upperView.bounds.size.height/2)
        upperView.backgroundColor = UIColor.yellow
        
        let circularPath = UIBezierPath(arcCenter: progressRoundPosition , radius: 150 , startAngle: 0, endAngle: CGFloat.pi*2, clockwise: true)
        
        let outerLayer = CAShapeLayer()
        outerLayer.path = circularPath.cgPath
        outerLayer.strokeColor = UIColor.gray.cgColor
        outerLayer.lineWidth = 10
        outerLayer.lineCap = CAShapeLayerLineCap.round
        outerLayer.fillColor = UIColor.clear.cgColor
        upperView.layer.addSublayer(outerLayer)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.green?.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0
        shapeLayer.fillColor = UIColor.clear.cgColor
        upperView.layer.addSublayer(shapeLayer)
//        ImageMic
        micImage.image = UIImage(systemName: "mic.fill")
        micImage.tintColor = UIColor.green
        micImage.frame = CGRect(x: 10, y: upperView.frame.height+100, width: self.view.frame.width-20, height: self.view.frame.height/3-10)
        
//        test function
        micImage.isUserInteractionEnabled = true
        micImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(testTap)))
       
    }
    
    func requestAccess() {
        switch AVAudioSession.sharedInstance().recordPermission {
        case AVAudioSessionRecordPermission.granted:
            print("Permission granted")
        case AVAudioSessionRecordPermission.denied:
            print("Pemission denied")
        case AVAudioSessionRecordPermission.undetermined:
            print("Request permission here")
            AVAudioSession.sharedInstance().requestRecordPermission({ (granted) in
             
            })
        
        @unknown default:
            print("unknown")
        }
    }
    
    
    
   

    @objc func testTap() {
     
        if audioOn {
            removeAudioEngine()
        }
        
        timer?.invalidate()
        
        keepCounting = true
        
        requestAccess()
     
        timerOn = true
        
        timerStart()
        
        
        let animateProgress = CABasicAnimation(keyPath: "strokeEnd")
        
        animateProgress.toValue = 1
        
     
        
        animateProgress.duration = timerTimeNow
        
        animateProgress.isRemovedOnCompletion = false
        
        shapeLayer.add(animateProgress, forKey: "strokeAnimation")
        
        startAudioEngine()
        
        
    }
    
    var interjection = 0
    var keepCounting = true

}



extension MinuteViewController: SpeakClassifierDelegate {
    func displayPredictionResult(identifier: String, confidence: Double) {
        DispatchQueue.main.async {
            if identifier == "Inter" && self.keepCounting{
    
                self.interjection += 1
                self.inputLabel.text = "hmm, that's okay! keep going!\nInterjection:  \(self.interjection)"
                
            }
            
            if identifier == "Speak" && self.keepCounting{
                self.inputLabel.text = "you are doing really great! keep speaking"
            }
            
            if identifier == "Noise" && self.keepCounting {
                self.inputLabel.text = "What happen? Why don't you speak?"
            }
            if self.keepCounting == false {
                self.inputLabel.text = "Finish! Feel free to  practice again!\nTotal of Interjection:  \(self.interjection)"
                self.inputLabel.backgroundColor = UIColor.yellow
            }
            
//            self.inputLabel.text = ("Recognition: \(identifier)\nConfidence \(confidence)")
        }
    }
}



