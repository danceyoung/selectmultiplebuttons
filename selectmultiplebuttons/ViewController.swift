//
//  ViewController.swift
//  selectmultiplebuttons
//
//  Created by Young on 2019/1/10.
//  Copyright © 2019 young. All rights reserved.
//

import UIKit

class ViewController: UIViewController, SelectMultipleButtonsDelegate {
    
    let tipLabel = UILabel.init(frame: CGRect.zero)
    let buttonTitleArray1 = ["running", "riding", "drinking Niuer", "reading", "thinking", "playing with kids", "coffee", "coding"]
    let buttonTitleArray2 = ["Female", "Male", "Other", "Rather not say"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tipLabel.frame = CGRect.init(x: 10, y: 64, width: view.frame.size.width, height: 50)
        tipLabel.text = "actions "
        tipLabel.lineBreakMode = .byWordWrapping
        tipLabel.numberOfLines = 0
        view.addSubview(tipLabel)
        
        //selectmultiplebuttons1, No limited for buttons selected
        let tip1 = UILabel.init(frame: CGRect.init(x: 10, y: tipLabel.frame.origin.y + tipLabel.frame.size.height + 10, width: view.frame.width, height: 20))
        tip1.text = "No limited for buttons selected"
        view.addSubview(tip1)
        //width is the maxwidth for SelectMultipleButtons view
        //no care height, after performing SelectMultipleButtons.load(), the height is calced automaticly.
        let selectMultipleButtons1 = SelectMultipleButtons.init(frame: CGRect.init(x: 0, y: tip1.frame.origin.y + tip1.frame.height, width: view.frame.width, height: 0))
        selectMultipleButtons1.tag = 1
        selectMultipleButtons1.delegate = self
        selectMultipleButtons1.load()
        // you must perform SelectMultipleButtons.load() befor adding it to parent view.
        view.addSubview(selectMultipleButtons1)
        
        //selectmultiplebuttons2, limited maximum 3 for buttons selected
        let tip2 = UILabel.init(frame: CGRect.init(x: 10, y: selectMultipleButtons1.frame.origin.y + selectMultipleButtons1.frame.height + 20, width: view.frame.width, height: 20))
        tip2.text = "Limiting maximum 3 for buttons selected"
        view.addSubview(tip2)
        let selectMultipleButtons2 = SelectMultipleButtons.init(frame: CGRect.init(x: 0, y: tip2.frame.origin.y + tip2.frame.height, width: view.frame.width, height: 0))
        selectMultipleButtons2.tag = 2
        selectMultipleButtons2.delegate = self
        selectMultipleButtons2.load()
        view.addSubview(selectMultipleButtons2)
        
        //selectmultiplebuttons3, presenting radio selecting
        let tip3 = UILabel.init(frame: CGRect.init(x: 10, y: selectMultipleButtons2.frame.origin.y + selectMultipleButtons2.frame.height + 20, width: view.frame.width, height: 20))
        tip3.text = "Radio for buttons selected"
        view.addSubview(tip3)
        let selectMultipleButtons3 = SelectMultipleButtons.init(frame: CGRect.init(x: 0, y: tip3.frame.origin.y + tip3.frame.height, width: view.frame.width, height: 0))
        selectMultipleButtons3.tag = 3
        selectMultipleButtons3.delegate = self
        selectMultipleButtons3.load()
        view.addSubview(selectMultipleButtons3)
        
    }

    func numberOf(selectMultipleButtons: SelectMultipleButtons) -> Int {
        switch selectMultipleButtons.tag {
        case 1:
            return buttonTitleArray1.count
        case 2:
            return buttonTitleArray1.count
        case 3:
            return buttonTitleArray2.count
        default:
            return 0
        }
    }
    
    func buttonOf(selectMultipleButtons: SelectMultipleButtons, atIndex index: Int) -> UIButton {
        let button = UIButton.init()
        
        switch selectMultipleButtons.tag {
        case 1:
            button.setTitle(buttonTitleArray1[index], for: .normal)
            //set none selected state
            button.setTitleColor(.lightGray, for: .normal)
            button.setBackgroundColor(.groupTableViewBackground, for: .normal)
            //set selected state
            button.setTitleColor(.white, for: .selected)
            button.setBackgroundColor(UIColor.init(red: 0x3B/0xFF, green: 0x67/0xFF, blue: 0xBC/0xFF, alpha: 1), for: .selected)
            //default button is selected
            button.isSelected = true
        case 2:
            button.setTitle(buttonTitleArray1[index], for: .normal)
            //set none selected state
            button.setTitleColor(.lightGray, for: .normal)
            button.setBackgroundColor(.groupTableViewBackground, for: .normal)
            //set selected state
            button.setTitleColor(.black, for: .selected)
            button.setBackgroundColor(UIColor.init(red: 0xFF/0xFF, green: 0xD3/0xFF, blue: 0x5B/0xFF, alpha: 1), for: .selected)
            button.isSelected = true
        case 3:
            button.setTitle(buttonTitleArray2[index], for: .normal)
            //set none selected state
            button.setTitleColor(.lightGray, for: .normal)
            button.setBackgroundColor(.groupTableViewBackground, for: .normal)
            //set selected state
            button.setTitleColor(.white, for: .selected)
            button.setBackgroundColor(UIColor.init(red: 0x1D/0xFF, green: 0x95/0xFF, blue: 0x3F/0xFF, alpha: 1), for: .selected)

        default: break
            
        }
        
        
        
        return button
    }
    
    func maximumNumberSelectedOf(selectMultipleButtons: SelectMultipleButtons) -> Int {
        switch selectMultipleButtons.tag {
        case 1:
            return Int.max
        case 2:
            return 3
        case 3:
            return 1
        default:
            return Int.max
        }
    }
    
    func styleConfigOf(selectMultipleButtons: SelectMultipleButtons) -> StyleConfig {
        
        let edgeSpace = EdgeSpace.init(top: 10, leading: 10, bottom: 10, trailling: 10)
        let betweenSpace = BetweenSpace.init(horizontalSpace: 5, verticalSpace: 5)
        
        return StyleConfig.init(edgeSpace: edgeSpace, betweenSpace: betweenSpace, systemFontSize: 18)
    }
    
    func didSingleTapOf(selectMultipleButtons: SelectMultipleButtons, atIndex index: Int) {
        tipLabel.text = "The index \(index) is taped, "
    }
    
    func indexesSelectedOf(selectMultipleButtons: SelectMultipleButtons, didChange indexes: [Int]) {
        tipLabel.text = (tipLabel.text!) + "and the selected indexes are \(indexes). "
    }
    

}

