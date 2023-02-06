//
//  GameViewController.swift
//  Tic-Tac-Toe
//
//  Created by Quang Khánh on 03/01/2023.
//

import UIKit

final class GameViewController: UIViewController {

    @IBOutlet private weak var labelComputerScore: UILabel!
    @IBOutlet private weak var labelPlayerScore: UILabel!
    @IBOutlet private weak var labelPlayerName: UILabel!
    @IBOutlet private weak var box1: UIImageView!
    @IBOutlet private weak var box2: UIImageView!
    @IBOutlet private weak var box3: UIImageView!
    @IBOutlet private weak var box4: UIImageView!
    @IBOutlet private weak var box5: UIImageView!
    @IBOutlet private weak var box6: UIImageView!
    @IBOutlet private weak var box7: UIImageView!
    @IBOutlet private weak var box8: UIImageView!
    @IBOutlet private weak var box9: UIImageView!
    
    var playerName: String!
    private var lastValue = "o"
    var playerChoices: [Box] = []
    var computerChoices: [Box] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //receive data
        labelPlayerName.text = playerName
        
        createTab(on: box1, type: .one)
        createTab(on: box2, type: .two)
        createTab(on: box3, type: .three)
        createTab(on: box4, type: .four)
        createTab(on: box5, type: .five)
        createTab(on: box6, type: .six)
        createTab(on: box7, type: .seven)
        createTab(on: box8, type: .eight)
        createTab(on: box9, type: .nine)

    }
    // initialize UITapGestureRecognizer with a target and action
    private func createTab(on imagaView: UIImageView, type box: Box) {
        let tab = UITapGestureRecognizer(target: self, action: #selector(self.boxClicked(_:)))
        tab.name = box.rawValue
        imagaView.isUserInteractionEnabled = true
        imagaView.addGestureRecognizer(tab)
    }
    //which will be called each time when a tap event occurs
    @objc func boxClicked(_ sender: UITapGestureRecognizer) {
        //print("Box: \(sender.name) was click")
        let selectedBox = getBox(from: sender.name ?? "")
        makeChoice(selectedBox)
        playerChoices.append(Box(rawValue: sender.name!)!)
        checkIfWon()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.computerPlay()
        }
    }
    
    private func makeChoice(_ selectedBox: UIImageView) {
        guard selectedBox.image == nil else { return }
        if lastValue == "x" {
            selectedBox.image = #imageLiteral(resourceName: "icons8-circled")
            lastValue = "o"
        } else {
            selectedBox .image = #imageLiteral(resourceName: "icons8-multiply")
            lastValue = "x"
        }
        
        //check if this is the winning move
        
        //check if there are move optional available
    }
    
    func checkIfWon() {
        var correct = [[Box]]()
        let firstRow: [Box] = [.one, .two, .three]
        let secondRow: [Box] = [.four, .five, .six]
        let thirdRow: [Box] = [.seven, .eight, .nine]
        
        let firstCol: [Box] = [.one, .four, .seven]
        let secondCol: [Box] = [.two, .five, .six]
        let thirdCol: [Box] = [.three, .six, .nine]
                
        let backwardSlash: [Box] = [.one, .five, .nine]
        let forwardSlash: [Box] = [.three, .five, .seven]
        
        correct.append(firstRow)
        correct.append(secondRow)
        correct.append(thirdRow)
        correct.append(firstCol)
        correct.append(secondCol)
        correct.append(thirdCol)
        correct.append(backwardSlash)
        correct.append(forwardSlash)
        
        for valid in correct {
            let userMatch = playerChoices.filter { valid.contains($0) }.count
            let computerMatch = computerChoices.filter { valid.contains($0) }.count
                    
            if userMatch == valid.count {
                labelPlayerScore.text = String((Int(labelPlayerScore.text ?? "0") ?? 0) + 1)
                        resetGame()
                break
            } else if computerMatch == valid.count {
                labelComputerScore.text = String((Int(labelComputerScore.text ?? "0") ?? 0) + 1)
                resetGame()
                break
            } else if computerChoices.count + playerChoices.count == 9 {
                resetGame()
                break
            }
        }
    }
    
    private func resetGame() {
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            box.image = nil
        }
        lastValue = "o"
        playerChoices = []
        computerChoices = []
    }
    
    private func computerPlay() {
        var availableSpaces = [UIImageView]()
        var availableBoxes = [Box]()
        for name in Box.allCases {
            let box = getBox(from: name.rawValue)
            if box.image == nil {
                availableSpaces.append(box)
                availableBoxes.append(name)
            }
        }
        
        guard availableBoxes.count > 0 else { return }
        
        let randIndex = Int.random(in: 0 ..< availableSpaces.count)
        makeChoice(availableSpaces[randIndex])
        computerChoices.append(availableBoxes[randIndex])
        checkIfWon()
    }
    
    private func getBox(from name: String) -> UIImageView {
        //conver name -> box
        let box = Box(rawValue: name) ?? .one
        switch box {
        case .one:
            return box1
        case .two:
            return box2
        case .three:
            return box3
        case .four:
            return box4
        case .five:
            return box5
        case .six:
            return box6
        case .seven:
            return box7
        case .eight:
            return box8
        case .nine:
            return box9
        }
    }
    
    @IBAction func closeBtnClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
enum Box: String, CaseIterable {
    case one, two, three, four, five, six, seven, eight, nine
}
