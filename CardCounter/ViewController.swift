//
//  ViewController.swift
//  CardCounter
//
//  Created by Irina Perepelkina on 31.05.2021.
//  Copyright © 2021 Irina Perepelkina. All rights reserved.
//
// Make sure message is shown: DONE
// Display numbers of players who won against the dealer: DONE
// Fix allowed numbers in textField (only 2-11 are allowed)
// Make user interface
// Test: DONE

import UIKit

var runningCount = 0
var playersCardsCount = 0
var numberOfPlayers = 0
var dealerOpenCard = 0

class ViewController: UIViewController, First {
    
    @IBOutlet weak var workingCollectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dealerCardsTextField: UITextField!
    @IBOutlet weak var playersCardsTitle: UILabel!
    @IBOutlet weak var dealerCardsTitle: UILabel!
    @IBOutlet weak var dealerCardsLabel: UILabel!
    @IBOutlet weak var newRound: UIButton!
    @IBOutlet weak var numberOfPlayersTextField: UITextField!
    
    var dealerCardsStock = 0
    var dealerCardsString = ""
    var numberOfDecks = 6
    var dealerCardsCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberOfPlayersTextField.becomeFirstResponder()
        textFieldConfiguration()
        //configureTapGesture()
        dealerCardsTextField.isEnabled = false
        workingCollectionView.dataSource = self
        workingCollectionView.delegate = self
        workingCollectionView.isHidden = true
        dealerCardsTitle.isHidden = true
        dealerCardsTextField.isHidden = true
        dealerCardsTitle.isHidden = true
        playersCardsTitle.isHidden = true
        dealerCardsLabel.isHidden = true
        newRound.isHidden = true
        
        // Do any additional setup after loading the view.
    }
    
    func allowDealerCard() {
        dealerCardsTextField.isEnabled = true
    }
    
    func hitOrStay(playerSum: Int, dealerOpenCard: Int) -> String {
        
        let decisionMatrix = [
            18: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "stand", 8: "stand", 9: "stand", 10: "stand", 11: "stand"
            ],
            19: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "stand", 8: "stand", 9: "stand", 10: "stand", 11: "stand"
            ],
            20: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "stand", 8: "stand", 9: "stand", 10: "stand", 11: "stand"
            ],
            21: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "stand", 8: "stand", 9: "stand", 10: "stand", 11: "stand"
            ],
            17: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "stand", 8: "stand", 9: "stand", 10: "stand", 11: "stand"
            ],
            16: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            15: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            14: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            13: [
                2: "stand", 3:"stand", 4: "stand", 5: "stand", 6: "stand", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            12: [
                2: "hit", 3:"hit", 4: "stand", 5: "stand", 6: "stand", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            11: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            10: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            9: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            8: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            7: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            6: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            5: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
            4: [
                2: "hit", 3:"hit", 4: "hit", 5: "hit", 6: "hit", 7: "hit", 8: "hit", 9: "hit", 10: "hit", 11: "hit"
            ],
        ]
        
        let hint = decisionMatrix[playerSum]![dealerOpenCard]!
        return hint
    }
    
    func clearAll() {
        
        playersCardsCount = 0
        dealerCardsStock = 0
        dealerCardsCount = 0
        dealerCardsTextField.text = ""
        dealerCardsLabel.text = "cards"
        dealerCardsString = ""
        var playerCardsString = ""
        var cardsCount = 0
        
        for row in 0..<workingCollectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            let cell = workingCollectionView.cellForItem(at: indexPath) as! PlayerCell
            cell.playerTextField.isEnabled = true
            cell.playerCardsString = ""
            cell.playerTextField.text?.removeAll()
            cell.playerCards.text = "cards"
            cell.sum = 0
            cell.hintForPlayer.text = "hint"
            cell.cardsCount = 0
        }
    }
    
    
    @IBAction func newRoundClicked(_ sender: UIButton) {
        
        // clear variables referring to collectionView
        clearAll()
        
        // calculate trueCount
        let trueCount = runningCount / numberOfDecks
        let bets = trueCount - 1
        
        var message = ""
        if bets > 0 {
            message = "You should increase current bet by \(bets) minimum bets\n"
        }
        else if bets < 0 {
            message = "True count is unfavourable to continue playing\n"
        }
        else if bets == 0 {
            message = "You should keep current bet\n"
        }
        
        let message2 = "Running count is \(runningCount)\n"
        let message3 = "True count is \(trueCount)"
        
        // show alertMessage showing how much you should bet
        let alert = UIAlertController(title: "Guidance", message: message+message2+message3, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
    }
    
    
    @IBAction func newDeckClicked(_ sender: UIButton) {
        numberOfDecks -= 1
    }
    
    private func textFieldConfiguration () {
        numberOfPlayersTextField.delegate = self
        dealerCardsTextField.delegate = self
    }
    
    /*
    private func configureTapGesture () {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        print("HandleTap was called")
        view.endEditing(true)
    } */
    
}


// MARK: - collectionView methods

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPlayers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = workingCollectionView.dequeueReusableCell(withReuseIdentifier: "workingCell", for: indexPath) as! PlayerCell
        
        cell.setDelegate()
        cell.delegate = self

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellPadding: CGFloat = 5
        let cellSize = (workingCollectionView.frame.width - cellPadding * CGFloat (numberOfPlayers+1))/CGFloat (numberOfPlayers)

        let height = cellSize * CGFloat (1.5)
        if cellSize > 81.25 {
            return CGSize(width: 81.25, height: 121.875)
        }
        //print("height is \(height), width is \(cellSize)")
        return CGSize(width: cellSize, height: height)
    }
    
}

extension ViewController: UITextFieldDelegate {
    
    /*
    // this method notifies when editing is finished
    func textFieldDidEndEditing(_ textField: UITextField) {
        print("textField did end editing")
    }
    
    // this method allows or doesn't allow editing - foring all other methods not to work
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print("textField should end editing")
        return true
    } */
    
    // this method is called when enter is pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            print("Empty string is not allowed")
            return false
        }
        
        else if textField == numberOfPlayersTextField {
            guard let number = Int (textField.text!) else {return false}
            numberOfPlayers = number
            workingCollectionView.reloadData()
            workingCollectionView.isHidden = false
            dealerCardsTitle.isHidden = false
            dealerCardsTextField.isHidden = false
            dealerCardsTitle.isHidden = false
            playersCardsTitle.isHidden = false
            dealerCardsLabel.isHidden = false
            newRound.isHidden = false
            numberOfPlayersTextField.isEnabled = false
            textField.resignFirstResponder()
        }
        
        else if textField == dealerCardsTextField {
            if textField.text == "" {
                print("Empty strings are not allowed")
                return false
            }
            var score = Int (textField.text!)!
            dealerCardsCount += 1
            if score == 11 && (dealerCardsStock + score) > 21 {
                score = 1
                runningCount -= 1
            } else if
                score == 2 || score == 3 || score == 4 || score == 5 || score == 6 {
                    runningCount += 1
                }
            else if score == 10 || score == 11 {
                runningCount -= 1
            }
            dealerCardsStock += score
            dealerCardsString += "\(score) "
            dealerCardsLabel.text = dealerCardsString
            
                if dealerCardsStock >= 17 {
                    textField.isEnabled = false
                    if dealerCardsStock > 21 {
                        dealerCardsLabel.text = "bust"
                    }
                    gameIsOver()
            }

            if dealerCardsCount == 1 {

                // enable textFields of every player (iterate over cells in collection view) - find a way to get indexpath to every cell based on its index
                dealerOpenCard = score
                
                for row in 0..<workingCollectionView.numberOfItems(inSection: 0) {
                    
                    let indexPath = IndexPath(row: row, section: 0)
                    let cell = workingCollectionView.cellForItem(at: indexPath) as! PlayerCell
                    if cell.sum != 21 {
                        cell.playerTextField.isEnabled = true
                        cell.hintForPlayer.text = hitOrStay(playerSum: cell.sum, dealerOpenCard: score)
                    }
                }
                
                // decide of hint and show them
                
            }
            
            if dealerCardsCount == 2 {
                for row in 0..<workingCollectionView.numberOfItems(inSection: 0) {
                    let indexPath = IndexPath(row: row, section: 0)
                    let cell = workingCollectionView.cellForItem(at: indexPath) as! PlayerCell
                    cell.playerTextField.isEnabled = false
                    
                }
            }
            
            textField.text?.removeAll()
        }
            
        return true
    }
    
    func gameIsOver() {
        
        var indicesOfWinners = [Int]()
        
        for row in 0..<workingCollectionView.numberOfItems(inSection: 0) {
            let indexPath = IndexPath(row: row, section: 0)
            let cell = workingCollectionView.cellForItem(at: indexPath) as! PlayerCell
            if cell.sum == 21 && dealerCardsStock != 21 {
                indicesOfWinners.append(row+1)
            }
            else if cell.sum < 21 && dealerCardsStock > 21 {
                indicesOfWinners.append(row+1)
            }
            else if cell.sum < 21 && dealerCardsStock < 21 {
                if cell.sum > dealerCardsStock {
                    indicesOfWinners.append(row+1)
                }
            }
        }
        
        var message = ""
        if indicesOfWinners.isEmpty {
            message = "No one won against the dealer"
        }
        else {
            message = "Players \(indicesOfWinners) won against the dealer."
        }
            
            let alert = UIAlertController(title: "Game Over", message: message, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alert, animated: true, completion: nil)
    }
     
    // this method is called every time a user inserts a new value (or enter/backspace)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedInput = CharacterSet.decimalDigits
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace
        // range - range of chars to be replaced
        // string - string to replace with (usually one letter)
        if string.isEmpty {
            return true
        }
        else if newLength == 1 || newLength == 2 {
            if let _ = string.rangeOfCharacter(from: allowedInput, options: .caseInsensitive) {
                return true
            }
        }
        return false
    }
    
    /*
    // this method allows or doesn't allow editing in general
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing")
        return true
    }
    
    // this method is called when actual editing starts
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("textField became first responder")
    } */
    
}
