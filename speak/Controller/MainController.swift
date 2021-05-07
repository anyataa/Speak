//
//  ViewController.swift
//  speak
//
//  Created by Anya Akbar on 28/04/21.
//

import UIKit

class MainController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
      
        setUpView()
        minuteCollectionView.delegate = self
        minuteCollectionView.dataSource = self
        
        setButtonView()
        setBottomView()
        
        
    }
    
    
    
    
    var challengeData : [Challenge] = Challenge.generateDataChallenge()
    var ChallengeMinute : Challenge = Challenge(labelMinute: 1/4, secondsPerChallenge: 15, title: "15 Seconds")
    var randomTopic : [String] = Challenge.generateRandomTopics()
    var randomNumber : Int = 0
    var choosenRandomTopic : String = "Book you like"
//    Button View
    
    @IBAction func practiceActionButton(_ sender: Any) {
        performSegue(withIdentifier: "toMinute", sender: sender)
    }
    @IBOutlet weak var practiceButtonView: UIButton!
    func setButtonView() {
        practiceButtonView.backgroundColor = UIColor.green

        practiceButtonView.frame = CGRect(x: 10, y: 420, width: self.view.frame.width-20, height: self.view.frame.height-770)

        practiceButtonView.setTitle("Start Practice", for: .normal)

        practiceButtonView.titleLabel?.font = UIFont.Bold(size: 28)

        practiceButtonView.setTitleColor(UIColor.bold, for: .normal)

        practiceButtonView.layer.cornerRadius = 15
        
    }


    
    
    @IBOutlet weak var minuteCollectionView: UICollectionView!
    
    let minuteData = Challenge.generateDataChallenge()
    
    
//    Collection View
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        minuteData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MinuteCell", for: indexPath) as! MinuteViewCell
        cell.configMinuteCell(number: minuteData[indexPath.row].labelMinute)
        if selectedPath == indexPath.row {
            cell.backgroundColor = UIColor.yellow
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 5
            cell.layer.borderColor = UIColor.bold?.cgColor
        } else { cell.backgroundColor = UIColor.yellow
            cell.layer.cornerRadius = 20
            cell.layer.borderWidth = 0
        }
       
        
       
        
        
        return cell
    }
    
    var selectedPath : Int = 0
//    Prepare for Segue
    var selectedMinute: Challenge = Challenge(labelMinute: 1/4, secondsPerChallenge: 15, title: "15 Seconds")
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        minuteCollectionView.reloadData()
        selectedPath = indexPath.row
        
        selectedMinute = minuteData[indexPath.row]
        
        randomNumber = Int.random(in: 0...randomTopic.count-1)
        
        choosenRandomTopic = randomTopic[randomNumber]
        
     
        
        setUpView()
        
        
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueDestination = segue.destination as! MinuteViewController
        
        segueDestination.choosenChallenge = selectedMinute
    }
    
//    SEGUE finish


    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: minuteCollectionView.bounds.width/3.5, height: minuteCollectionView.bounds.height-40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
   

    

   
    

//  Upper View
    @IBOutlet weak var upperView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var instructionLabel: UILabel!
    
    func setUpView() {
        self.title = "Practice Space"
        self.view.backgroundColor = UIColor(named: "Background")
        
        upperView.layer.cornerRadius = 20
        upperView.backgroundColor = UIColor.init(named: "Primary")
        upperView.frame = CGRect(x: 10, y: 150, width: self.view.frame.width-20, height: self.view.frame.height-600)
        
        minuteCollectionView.frame = CGRect(x: 10, y: 500, width: self.view.frame.width - 20, height: self.view.frame.height-700)
        
        minuteCollectionView.backgroundColor = UIColor.background
        
        minuteCollectionView.showsHorizontalScrollIndicator = false
      
        
        
      
        //        handle random topic inside instruction Label
          
        
//        setup inside instruction label
        
        instructionLabel.frame = CGRect(x: 20, y: 50, width: upperView.frame.width-40, height: upperView.frame.height-40)
        
        instructionLabel.numberOfLines = 0
        instructionLabel.font = UIFont.Bold(size: 23)
        instructionLabel.text = "In this challenge you are expected to speak for \( selectedMinute.title) about \(choosenRandomTopic)"
        
        titleLabel.frame = CGRect(x: 20, y: 10, width: upperView.frame.width-40, height: upperView.frame.height/3)
        
        titleLabel.font = UIFont.Bold(size: 34)
        titleLabel.text = "\(selectedMinute.title)"
        titleLabel.textColor = UIColor.bold
        
        
        
    }
    
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var leafImage: UIImageView!
    func setBottomView() {
        
        bottomView.frame = CGRect(x: (self.view.frame.width-600)/2, y: self.view.frame.height-170, width: 600, height: 420)
        
        bottomView.layer.cornerRadius = bottomView.bounds.width/2
        bottomView.backgroundColor = UIColor.yellow
        
        leafImage.frame = CGRect(x: self.view.frame.width-170, y: self.view.frame.height-200, width: 200, height: 200)
        leafImage.image = #imageLiteral(resourceName: "leaf")
        
    }
    
 
    

    
  
    
    


}

