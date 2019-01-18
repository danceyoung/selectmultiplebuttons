


> Written with [StackEdit](https://stackedit.io/).
# SelectMultipleButtons
A grouped buttons supporting multiple/radio selection and automatic layout by building with swift.
## Demo  (captured by GIPHY CAPTURE)
![
](https://github.com/danceyoung/selectmultiplebuttons/blob/master/demo/selectmultiplebuttons-demo.gif?raw=true)
## Instruction
You must adopt the `SelectMultipleButtonsDelegate` protocol. The protocol likes UITableViewDelegate and UITableDatasource, providing information that SelectMultipleButtons need to construct buttons and manage button selection...

_// how many buttons are returnd_

    **func** numberOf(selectMultipleButtons: SelectMultipleButtons) -> Int
    
  _// button returned that is at which index_
  
    **func** buttonOf(selectMultipleButtons: SelectMultipleButtons, atIndex index: Int) -> UIButton
    
_//set maximumNumber selected_

_//default you can all select buttons_

_//if you set the value is 1, the selectmultiplebuttons will present radio selecting_

    **@objc** **optional** **func** maximumNumberSelectedOf(selectMultipleButtons: SelectMultipleButtons) -> Int
_//config, containnig the blow items_

_//edge's space (top, leading, bottom, trailling)_

_//between space (vertical space and horizontal space between buttons)_

    **func** styleConfigOf(selectMultipleButtons: SelectMultipleButtons) -> StyleConfig
   _//button's singeltap event_
   

    **@objc** **optional** **func** didSingleTapOf(selectMultipleButtons: SelectMultipleButtons, atIndex index: Int) -> Void
   _//indexes selected and changed_
   

    **@objc** **optional** **func** indexesSelectedOf(selectMultipleButtons: SelectMultipleButtons, didChange indexes: [Int]) -> Void
## code snap
Init a selectMultipleButtons
_//width is the maxwidth for SelectMultipleButtons view_

_//no care height, after performing SelectMultipleButtons.load(), the height is calced automaticly._

_// you must perform SelectMultipleButtons.load() befor adding it to parent view._

    **let** selectMultipleButtons1 = SelectMultipleButtons.init(frame: CGRect.init(x: 0, y: tip1.frame.origin.y + tip1.frame.height, width: view.frame.width, height: 0))
    selectMultipleButtons1.delegate = **self**
    selectMultipleButtons1.load()
    view.addSubview(selectMultipleButtons1)

Conform required protocol

    func numberOf(selectMultipleButtons: SelectMultipleButtons) -> Int {
	    return  buttonTitleArray1.count
    }
    
    func buttonOf(selectMultipleButtons: SelectMultipleButtons, atIndex index: Int) -> UIButton {
	    let button = UIButton.init()
	    button.setTitle(buttonTitleArray1[index], for: .normal)
	    //set none selected state
	    button.setTitleColor(.lightGray, for: .normal)
	    button.setBackgroundColor(.groupTableViewBackground, for: .normal)
	    _//set selected state_
	    button.setTitleColor(.white, for: .selected)
	    button.setBackgroundColor(UIColor.init(red: 0x3B/0xFF, green: 0x67/0xFF, blue: 0xBC/0xFF, alpha: 1), for: .selected)
	    _//default button is selected_
	    button.isSelected = true
	    return button
	}

    func styleConfigOf(selectMultipleButtons: SelectMultipleButtons) -> StyleConfig {
	    let edgeSpace = EdgeSpace.init(top: 10, leading: 10, bottom: 10, trailling: 10)
	    let betweenSpace = BetweenSpace.init(horizontalSpace: 5, verticalSpace: 5)
	    return StyleConfig.init(edgeSpace: edgeSpace, betweenSpace: betweenSpace, systemFontSize: 18)
	}
