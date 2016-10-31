//
//  ViewController.swift
//  Hangman
//
//  Created by Naghmeh on 10/20/16.
//  Copyright © 2016 Naghmeh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let MAXTRIES = 10
    var triesLeft: Int = 10
    var wordList = [String : String]()
    var wordToGuess : String = ""
    var theHint : String = ""
    
    @IBOutlet var heartsView: Hearts!
    
    @IBOutlet var hintHolder: UILabel!
    
    @IBOutlet var wordHolder: UILabel!
    @IBAction func letters(_ sender: UIButton) {
        //print(sender.currentTitle!.lowercased())
        var index = 0
        var listOfIndeces : [Int] = []
        for c in wordToGuess.characters{
            if(sender.currentTitle!.lowercased() == String(c)){
                listOfIndeces.append(index)
            }
            index += 1
        }

        if(listOfIndeces.isEmpty)
        {
            triesLeft -= 1
            fadeHeart(index: triesLeft)
            
        }
        else{
            for j in listOfIndeces
            {
                for i in stride(from: 0, to: wordHolder.text!.characters.count, by: 2){
                    if((i/2) == j)
                    {
                        let newWord = replaceCharacters(index: i, newString: sender.currentTitle!)
                        wordHolder.text! = newWord
                        wordHolder.sizeToFit()
                    }
                }
            }
        }
        

        let win = isWin()
        let lose = isLose()
        if(win || lose)
        {
            var message = ""
            if(win){
                message = "You Win!\nReset game? " }
            if(lose){message = "You Lose!\nReset game?" }
            // create the alert
            let alert = UIAlertController(title: "Game Over", message: message , preferredStyle: UIAlertControllerStyle.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "YES", style: UIAlertActionStyle.default, handler: {action in
                self.viewDidLoad()}))
            alert.addAction(UIAlertAction(title: "NO", style: UIAlertActionStyle.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }

    func replaceCharacters(index:Int, newString: String) -> String
    {
        var replacedString = ""
        var i = 0
        for character in wordHolder.text!.characters {
            //Checking to see if the index of the character is the one we're looking for
            if i == index {
                //Found it! Now instead of adding it, add newCharac!
                replacedString += newString
            } else {
                replacedString += String(character)
            }
            i = i + 1
        }
        return replacedString
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
        populateWordList()
        setUpUnderScores()
        triesLeft = 10
        resetHearts()
    }
    func isWin() -> Bool
    {
        if(wordHolder.text!.contains("_")){
            return false
        }
        else{
            return true
        }
    }
    func isLose() -> Bool
    {
       if (triesLeft == 0)
       {return true}
       else{return false}
    }
    
    func setUpUnderScores(){
        let (x, y) = chooseRandomWord()
        wordToGuess = x!
        theHint = y!
        hintHolder.text = theHint
        wordHolder.text?.removeAll()
        for _ in wordToGuess.characters
        {
            wordHolder.text?.append("_")
            wordHolder.text?.append(" ")
            wordHolder.sizeToFit()
        }
    }
    func chooseRandomWord()-> (String? , String?){
        let index: Int = Int(arc4random_uniform(UInt32(wordList.count)))
        let randomVal = Array(wordList.keys)[index]
        return (randomVal, wordList[randomVal])
    }
    func populateWordList(){
        // Get the file containing the words.
        let mainBundle = Bundle.main
        let filePath : String? = mainBundle.path(
            forResource: "wordList", ofType: ".txt")
        // Make sure the file exists!
        do {
            let words: String? = try String(contentsOfFile: filePath!, encoding: String.Encoding.utf8)
            let wordAndHint = words?.components(separatedBy: "\n")
            //print(wordAndHint)
            for w in wordAndHint!{
                var word = w.components(separatedBy: ",")
                wordList[word[0]] = word[1]
            }
        } catch{
            print("File does not exist!")
        }
    }
        
    func viewList(){
        for (x , y) in wordList{
            print ( x + " and " + y)
        }
    }
    
    func fadeHeart(index : Int){
        heartsView.listOfHearts[index].alpha = 0.5
    }
    func resetHearts()
    {
        for x in heartsView.listOfHearts
        {
            x.alpha = 1
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

