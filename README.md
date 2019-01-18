


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
