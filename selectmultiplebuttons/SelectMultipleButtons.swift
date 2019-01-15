//
//  SelectMultipleButtons.swift
//  trycatching
//
//  Created by Young on 2018/12/28.
//  Copyright © 2018 young. All rights reserved.
//

import UIKit

@objc protocol SelectMultipleButtonsDelegate {
    // how many buttons are returnd
    func numberOf(selectMultipleButtons: SelectMultipleButtons) -> Int
    
    // button returned that is at which index
    func buttonOf(selectMultipleButtons: SelectMultipleButtons, atIndex index: Int) -> UIButton
    
    //set maximumNumber selected
    //default you can all select buttons
    //if you set the value is 1, the selectmultiplebuttons will present radio selecting
    @objc optional func maximumNumberSelectedOf(selectMultipleButtons: SelectMultipleButtons) -> Int
    
    //config, containnig the blow items
    //edge's space (top, leading, bottom, trailling)
    //between space (vertical space and horizontal space between buttons)
    func styleConfigOf(selectMultipleButtons: SelectMultipleButtons) -> StyleConfig
    
    //button's singeltap event
    @objc optional func didSingleTapOf(selectMultipleButtons: SelectMultipleButtons, atIndex index: Int) -> Void
    
    @objc optional func indexesSelectedOf(selectMultipleButtons: SelectMultipleButtons, didChange indexes: [Int]) -> Void
}

class StyleConfig: NSObject {
    fileprivate var edgeSpace = EdgeSpace()
    fileprivate var betweenSpace = BetweenSpace()
    fileprivate var systemFontSize: CGFloat = 18
    
    public init(edgeSpace: EdgeSpace, betweenSpace: BetweenSpace, systemFontSize: CGFloat) {
        self.edgeSpace = edgeSpace
        self.betweenSpace = betweenSpace
        self.systemFontSize = systemFontSize
    }
    
}

class EdgeSpace {
    var top: CGFloat = 10.0
    var leading: CGFloat = 10.0
    var bottom: CGFloat = 10.0
    var trailling: CGFloat = 10.0
    
    public init() {
        
    }
    
    public init(space: CGFloat) {
        self.top = space
        self.leading = space
        self.bottom = space
        self.trailling = space
    }
    
    public init(top: CGFloat, leading: CGFloat, bottom: CGFloat, trailling: CGFloat) {
        self.top = top
        self.leading = leading
        self.bottom = bottom
        self.trailling = trailling
    }
}

class BetweenSpace {
    var horizontalSpace: CGFloat = 5
    var verticalSpace:CGFloat = 5
    
    public init() {
        
    }
    
    public init(space: CGFloat){
        self.horizontalSpace = space
        self.verticalSpace = space
    }
    
    public init(horizontalSpace: CGFloat, verticalSpace: CGFloat) {
        self.horizontalSpace = horizontalSpace
        self.verticalSpace = verticalSpace
    }
    
}

class SelectMultipleButtons: UIView {
    
    private var baseTagValue = 1000
    private var maximumNumberSelected = Int.max
    var delegate: SelectMultipleButtonsDelegate?
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    private var indexesSelected = [Int]()
    
    public func load() {
        if delegate != nil {
            let power = delegate!.numberOf(selectMultipleButtons: self)
            if let maxNumberSelected = delegate!.maximumNumberSelectedOf?(selectMultipleButtons: self) {
                maximumNumberSelected = maxNumberSelected
            }
            let containerView = UIView(frame: .zero)
            var priorRect = CGRect.zero
            let styleConfig = delegate!.styleConfigOf(selectMultipleButtons: self)
            let edgeSpace = styleConfig.edgeSpace
            let betweenSpace = styleConfig.betweenSpace
            let systemFontSize = styleConfig.systemFontSize
            let superViewWidth = self.frame.size.width
            var estimateRect = CGRect.zero
            
            for index in 0..<power {
                let button = delegate!.buttonOf(selectMultipleButtons: self, atIndex: index)
                if button.isSelected {
                    if indexesSelected.count < maximumNumberSelected {
                        indexesSelected.append(index)
                    }else {
                        button.isSelected = false
                    }
                }
                button.tag = index + baseTagValue
                button.addTarget(self, action: #selector(singleTap(sender:)), for: .touchUpInside)
                estimateRect = button.title(for: .normal)!.boundingRect(with: CGSize(width: 375, height: 30), options: .usesLineFragmentOrigin, attributes: [ NSAttributedString.Key.font : UIFont.systemFont(ofSize: systemFontSize) ], context: nil)
                //ceil size for providing more size
                estimateRect = CGRect(x: estimateRect.origin.x, y: estimateRect.origin.y, width: ceil(estimateRect.size.width + 10), height: ceil(estimateRect.size.height + 10))
                
                var buttonOrigin = CGPoint.zero
                if (priorRect.origin.x + priorRect.size.width + estimateRect.size.width + (priorRect.size.width == 0 && priorRect.origin.x == 0 ? 0 : betweenSpace.horizontalSpace)
                    )
                    <=
                    (superViewWidth - edgeSpace.leading - edgeSpace.trailling) {
                        buttonOrigin = CGPoint(x: priorRect.origin.x + priorRect.size.width + (priorRect.size.width == 0 && priorRect.origin.x == 0 ? 0 : betweenSpace.horizontalSpace), y: priorRect.origin.y
                    )
                }else {
                    buttonOrigin = CGPoint(x: 0, y: priorRect.origin.y + estimateRect.size.height + betweenSpace.verticalSpace
                    )
                }
                priorRect = CGRect(origin: buttonOrigin, size: estimateRect.size)
                
                button.frame = CGRect(origin: buttonOrigin, size: estimateRect.size)
                
                containerView.addSubview(button)

            }
            
            containerView.frame = CGRect(
                x: edgeSpace.leading,
                y: edgeSpace.top,
                width: superViewWidth - edgeSpace.leading - edgeSpace.trailling,
                height: priorRect.origin.y + estimateRect.size.height
            )
            
            self.addSubview(containerView)
            self.frame.size = CGSize(
                width: superViewWidth,
                height: containerView.frame.size.height + edgeSpace.top + edgeSpace.bottom
            )
            
        }
    }
    
    @objc private func singleTap(sender: UIButton) {
        if delegate != nil {
            
            delegate!.didSingleTapOf?(selectMultipleButtons: self, atIndex: (sender.tag - baseTagValue))
            
            if maximumNumberSelected == 1 {
                if indexesSelected.count == 0 {
                    indexesSelected.append(sender.tag - baseTagValue)
                    sender.isSelected = true
                }else {
                    
                    let btn = self.viewWithTag(indexesSelected[0] + baseTagValue) as! UIButton
                    btn.isSelected = false
                    sender.isSelected = true
                    indexesSelected.removeAll()
                    indexesSelected.append(sender.tag - baseTagValue)
                }
            }else {
                if indexesSelected.contains(sender.tag - baseTagValue) {
                    indexesSelected = indexesSelected.filter{$0 != (sender.tag - baseTagValue)}
                    sender.isSelected = false
                }else if indexesSelected.count < maximumNumberSelected {
                    indexesSelected.append(sender.tag - baseTagValue)
                    sender.isSelected = true
                }
            }
            delegate!.indexesSelectedOf?(selectMultipleButtons: self, didChange: indexesSelected)
        }
    }

}
