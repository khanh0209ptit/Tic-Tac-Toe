//
//  ViewController.swift
//  Tic-Tac-Toe
//
//  Created by Quang Khánh on 03/01/2023.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var uiView: UIView!
    @IBOutlet private weak var buttonStart: UIButton!
    @IBOutlet private weak var textLabelName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        buttonStart.layer.cornerRadius = 10
        uiView.layer.cornerRadius = 10
        uiView.layer.shadowOpacity = 0.4
        uiView.layer.shadowColor = UIColor.black.cgColor
        uiView.layer.shadowRadius = 10
        uiView.layer.shadowOffset = .zero
    }
    
    @IBAction func startBtnClick(_ sender: UIButton) {
        guard !textLabelName.text!.trimmingCharacters(in: .whitespaces).isEmpty else { return }
        let controller = storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        controller.playerName = textLabelName.text
        controller.modalTransitionStyle = .flipHorizontal
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true, completion: nil)
    }
    
    //touch even: touchesBegan - Bat dau cham vao
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textLabelName.resignFirstResponder()
    }
    
    //send data use Seque
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? GameViewController {
            controller.playerName = textLabelName.text
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "GameViewController" {
            //check isEmpty no screen switching GameViewController
            if textLabelName.text!.trimmingCharacters(in: .whitespaces).isEmpty {
                return false
            }
        }
        return true
    }
}

