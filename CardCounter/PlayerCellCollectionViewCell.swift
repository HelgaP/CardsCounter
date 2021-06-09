//
//  PlayerCellCollectionViewCell.swift
//  CardCounter
//
//  Created by Irina Perepelkina on 04.06.2021.
//  Copyright © 2021 Irina Perepelkina. All rights reserved.
//
// Here I need:
//** how can store any information from this class in a var in ViewController class? F.e. I want to disable textField when there are exactly two values in label but then enable them again from VC when dealer deals him his first card
// - disable every playerTextField when it receives exactly two values initially: DONE
// - accept exactly one card from in dealerCardsTextField: DONE
// - show hint for every playerL DONE
// - enable players cards, receive inputs: DONE
// - based on sum make a decision for every player hit or stay and display the hint in the hint label: DONE
// - when second and further cards are received from the dealer, players cards are disabled again: DONE


import UIKit

protocol First {
    func allowDealerCard()
    func hitOrStay(playerSum: Int, dealerOpenCard: Int) -> String
}

class PlayerCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var playerTextField: UITextField!
    @IBOutlet weak var playerCards: UILabel!
    @IBOutlet weak var hintForPlayer: UILabel!
    var playerCardsString = ""
    
    var sum = 0
    var cardsCount = 0
    
    var delegate: First?
    
    func setDelegate() {
        playerTextField.delegate = self
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let allowedInput = CharacterSet.decimalDigits
        let startingLength = textField.text?.count ?? 0
        let lengthToAdd = string.count
        let lengthToReplace = range.length
        let newLength = startingLength + lengthToAdd - lengthToReplace

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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField.text == "" {
            print("Empty string is not allowed")
            return false
        }
        var num = Int (textField.text!)!
        if num == 11 && (sum + num) > 21 {
            num = 1
        }
        // check if two or more values were received from the user
        if sum != num {
            
        }
        sum += num
        if num == 2 || num == 3 || num == 4 || num == 5 || num == 6 {
            runningCount += 1
        }
        else if num == 10 || num == 11 {
            runningCount -= 1
        }

        print("running count is \(runningCount)")
        playerCardsString += "\(num) "
        playerCards.text = playerCardsString
        
        if sum > 21 {
            hintForPlayer.text = "bust"
            textField.isEnabled = false
            cardsCount += 1
            playersCardsCount += 1
            return false
        }
        else if sum == 21 {
            print("Got inside == 21 block")
            hintForPlayer.text = "blackJack"
            textField.isEnabled = false
        }
        cardsCount += 1
        playersCardsCount += 1

        if cardsCount == 2 && sum != 21 {
            textField.isEnabled = false
        }
        textField.text?.removeAll()
        
        if playersCardsCount >= numberOfPlayers * 2 {
            delegate?.allowDealerCard()
        }
        
        if cardsCount >= 3 && sum != 21 {
            hintForPlayer.text = delegate?.hitOrStay(playerSum: sum, dealerOpenCard: dealerOpenCard)
        }
        
        return true
    }
    
}
