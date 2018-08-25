# RadioButton
--

![RadioButtonDemo1](https://raw.githubusercontent.com/a2734043/RadioButton/master/images/RadioButtonDemo.gif)

首先在專案中加入兩個檔案

`RadioButton.swift``RadioButtonController.swift`

![image1](https://raw.githubusercontent.com/a2734043/RadioButton/master/images/image1.png)

## Main.storyboard

在storyboard中將Button的class設定為RadioButton

![image2](https://raw.githubusercontent.com/a2734043/RadioButton/master/images/image2.png)

設定完之後就能夠自訂RadioButton的外框及點選後顯示的顏色了！

![image3](https://raw.githubusercontent.com/a2734043/RadioButton/master/images/image3.png)


## Viewcontroller

在viewdidload()中初始化一個RadioButtonController。

	override func viewDidLoad() {
        super.viewDidLoad()
        let radioButtonController = RadioButtonController.init(buttons: [button1,button2,button3])
        radioButtonController.delegate = self
        
    }
    
    
RadioButtonController中的一些用法：

- canDeselect:是否能取消選取
- addButton:新增Button至這個Group中
- removeButton:移除這個Group中的Button

```
radioButtonController.canDeSelect = true
radioButtonController.addButton(button1)
radioButtonController.removeButton(button1)
```

點選RadioButton後會跳至didSelectedButton這個function中，並可辨別所點選的是哪一個Button

	func didSelectedButton(_ radioButtonController: RadioButtonController, _ currentSelectedButton: RadioButton?) {
        print(currentSelectedButton)
    }
    
## RadioButton.swift
```
import UIKit
@IBDesignable

class RadioButton: UIButton {
    @IBInspectable var selectedButtonColor:UIColor = UIColor.black
    @IBInspectable var borderColor:UIColor = UIColor.black
    
    override func draw(_ rect: CGRect) {
        self.tintColor = UIColor.clear
        layer.cornerRadius = self.frame.width / 2
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 2.5
        layer.masksToBounds = true
    }
    override var isSelected: Bool{
        didSet{
            isClicked()
        }
    }
    func isClicked(){
        if isSelected{
            let insideLayer = CAShapeLayer()
            let path = UIBezierPath()
            path.move(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2))
            path.addArc(withCenter: CGPoint(x: bounds.width / 2, y: bounds.height / 2), radius: self.frame.width / 3, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: true)
            insideLayer.path = path.cgPath
            insideLayer.fillColor = selectedButtonColor.cgColor
            insideLayer.name = "insideLayer"
            layer.addSublayer(insideLayer)
        }else{
            layer.sublayers?.filter({($0.name == "insideLayer")}).first?.removeFromSuperlayer()
        }
    }
}
```

## RadioButtonController.swift
```
import UIKit

protocol RadioButtonControllerDelegate {
    func didSelectedButton(_ radioButtonController:RadioButtonController, _ currentSelectedButton:RadioButton?)
}

class RadioButtonController: NSObject {
    var buttonArray = [RadioButton]()
    var canDeSelect:Bool = false
    var name:String = ""
    var delegate:RadioButtonControllerDelegate?
        
    init(buttons:[RadioButton]){
        super.init()
        for button in buttons{
            button.addTarget(self, action: #selector(self.radioButtonTap(sender:)), for: .touchUpInside)
        }
        self.buttonArray = buttons
    }
    
    func addButton(_ addButton:RadioButton){
        buttonArray.append(addButton)
        addButton.addTarget(self, action: #selector(self.radioButtonTap(sender:)), for: .touchUpInside)
    }
    
    func removeButton(_ removeButton:RadioButton){
        for (index, checkButton) in buttonArray.enumerated(){
            if checkButton == removeButton{
                checkButton.removeTarget(self, action: #selector(self.radioButtonTap(sender:)), for: .touchUpInside)
                buttonArray.remove(at: index)
            }
        }
    }

     @objc func radioButtonTap(sender:RadioButton){
        var currentSelectedButton:RadioButton? = nil
        if sender.isSelected{
            if canDeSelect{
                sender.isSelected = false
                currentSelectedButton = nil
            }
        }else{
            self.buttonArray.forEach { (button) in
                button.isSelected = false
            }
            sender.isSelected = true
            currentSelectedButton = sender
        }
        self.delegate?.didSelectedButton(self, currentSelectedButton)
    }
}
```


    
    
  

  
  


