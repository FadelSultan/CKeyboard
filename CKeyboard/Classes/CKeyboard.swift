//
//  CKeyboard.swift
//  CKeyboard
//
//  Created by fadel sultan on 3/14/19.
//


import Foundation
import UIKit

@available(iOS 9.0, *)
public class CKeyboard {
    
    private init(){}
    fileprivate static let shared = CKeyboard()
    
    //    Proprties
    fileprivate static var textFileds = [UITextField]()
    
    fileprivate static let spaceBtn = "space"
    fileprivate static let deleteBtn = "⌫"
    fileprivate static var alphabetInLine:Int?
    fileprivate static var height:CGFloat?
    fileprivate static var backgroundColor:UIColor?
    fileprivate static var isHeaderHidden:Bool = false
    fileprivate static var headerBackroundColor:UIColor?
    fileprivate static var buttonColor:UIColor?
    
    public static let defulteAlphabet = ["Q","W","E","R","T","Y","U","I","O","P","A","S","D","F","G","H","J","K","L","Z","X", "C" , "V" , "B" , "N" , "M"]
    
    fileprivate static var doneButton:String?
    fileprivate static var alphabet = [String]()
    fileprivate static let headerHeight:CGFloat = 40
    fileprivate static let footerHeight:CGFloat = 50
    fileprivate static let keyboard : UIView = {
        let v =
            UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: (height ?? 200) + footerHeight + headerHeight))
        v.backgroundColor = backgroundColor ?? #colorLiteral(red: 0.8152179122, green: 0.8271797299, blue: 0.8478847146, alpha: 1)
        
        return v
    }()
    
    fileprivate static let stackViewVertical : UIStackView = {
        let stacke = UIStackView()
        stacke.alignment = .center
        stacke.spacing = 1.0
        stacke.distribution = .fillEqually
        stacke.axis = .vertical
        return stacke
    }()
    
    public static func create(textFileds:[UITextField] , characters:[String] )  {
        self.textFileds = textFileds
        createKeyboard(characters: characters)
    }
    
    public static func create(textFileds:[UITextField] , characters:[String] , height:CGFloat? , alphabetInLine:Int? , backgroundColor:UIColor? , isHeaderHidden:Bool , headerBackroundColor:UIColor? , doneButton:String?)  {
        
        self.doneButton = doneButton
        self.alphabetInLine = alphabetInLine
        self.height = height
        self.backgroundColor = backgroundColor
        self.isHeaderHidden = isHeaderHidden
        self.headerBackroundColor = headerBackroundColor
        self.textFileds = textFileds
        
        createKeyboard(characters: characters)
    }
    
    fileprivate class func createKeyboard(characters:[String]) {
        
        self.setupConstrantHeader(title: doneButton ?? "Done")
        self.setupConstrantFooter()
        
        self.setupStackViewVertical()
        
        self.setupInputView()
        
        CKeyboard.alphabet = characters
        var btns = [UIButton]()
        var counter = 1
        var counterToLines = 1
        for alphabet in characters {
            
            let b = self.generateKeyboardButton(title: alphabet)
            btns.append(b)
            
            if self.alphabet.count <= alphabetInLine ?? 6 {
                if counter == self.alphabet.count {
                    self.generateStackView(stackView: UIStackView(), Buttons: btns)
                    btns.removeAll()
                }
            }
            
            if counter >= (alphabetInLine ?? 6) && counter <= ((alphabetInLine ?? 6) * counterToLines){
                if self.alphabet.count > ((alphabetInLine ?? 6) * counterToLines) {
                    
                    if counter == ((alphabetInLine ?? 6) * counterToLines) {
                        self.generateStackView(stackView: UIStackView(), Buttons: btns)
                        btns.removeAll()
                        counterToLines += 1
                    }
                }else {
                    if counter == self.alphabet.count {
                        self.generateStackView(stackView: UIStackView(), Buttons: btns)
                        btns.removeAll()
                        counterToLines += 1
                    }
                }
            }else {
                if counter == self.alphabet.count {
                    self.generateStackView(stackView: UIStackView(), Buttons: btns)
                    btns.removeAll()
                    counterToLines += 1
                }
            }
            counter += 1
        }
    }
    
    fileprivate class func setupStackViewVertical() {
        self.keyboard.addSubview(self.stackViewVertical)
        self.stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        self.stackViewVertical.topAnchor.constraint(equalTo: CKeyboard.header.bottomAnchor, constant: 5).isActive = true
        self.stackViewVertical.bottomAnchor.constraint(equalTo: self.footer.topAnchor).isActive = true
        self.stackViewVertical.leftAnchor.constraint(equalTo: self.keyboard.leftAnchor, constant: 10).isActive = true
        self.stackViewVertical.rightAnchor.constraint(equalTo: self.keyboard.rightAnchor, constant: -10).isActive = true
    }
    
    fileprivate class func stackView() -> UIStackView {
        let stacke = UIStackView()
        stacke.alignment = .center
        stacke.spacing = 10
        stacke.distribution = .fillEqually
        stacke.axis = .horizontal
        return stacke
    }
    
    fileprivate class func generateStackView(stackView:UIStackView , Buttons:[UIButton]) {
        
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        let height:CGFloat = (self.stackViewVertical.frame.height / 3) - 8
        
        self.stackViewVertical.addArrangedSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: stackView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: stackView.centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: self.stackViewVertical.widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: height).isActive = true
        for btn in Buttons {
            stackView.addArrangedSubview(btn)
        }
    }
    
    fileprivate class func setupInputView() {
        for textField in CKeyboard.textFileds {
            textField.inputView = CKeyboard.keyboard
        }
    }
}

@available(iOS 9.0, *)
extension CKeyboard {
    fileprivate class func generateKeyboardButton(title:String) -> UIButton {
        
        let b = UIButton(type: UIButton.ButtonType.system)
        b.setTitle(title, for: UIControl.State.normal)
        b.backgroundColor = CKeyboard.buttonColor ?? #colorLiteral(red: 0.9998916984, green: 1, blue: 0.9998809695, alpha: 1)
        b.layer.masksToBounds = true
        b.layer.cornerRadius = 5
        b.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        b.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), for: UIControl.State.normal)
        b.dropShadow()
        b.addTarget(CKeyboard.shared, action: #selector(alphabet(_:)), for: .touchUpInside)
        return b
    }
    
    @objc fileprivate func alphabet(_ sender:UIButton) {
        guard var text = sender.titleLabel?.text else {return}
        
        text = text == CKeyboard.spaceBtn ? " " : text
        for t in CKeyboard.textFileds {
            if t.isEditing {
                if text == CKeyboard.deleteBtn {
                    if !(t.text?.isEmpty)! {
                        t.text?.removeLast()
                    }
                    return
                }
                t.text = t.text! + text
            }
        }
    }
    
    fileprivate class func generateHeaderButton(title:String) -> UIButton {
        let cb = UIButton(type: UIButton.ButtonType.system)
        cb.setTitle(title, for: UIControl.State.normal)
        cb.layer.masksToBounds = true
        cb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        cb.setTitleColor(#colorLiteral(red: 0.07789551467, green: 0.516671598, blue: 0.998611033, alpha: 1), for: UIControl.State.normal)
        return cb
    }
}


//    MARK:- Footer
@available(iOS 9.0, *)
extension CKeyboard {
    
    fileprivate static let footer : UIView = {
        let v = UIView()
        v.backgroundColor = backgroundColor ?? #colorLiteral(red: 0.8152179122, green: 0.8271797299, blue: 0.8478847146, alpha: 1)
        
        return v
    }()
    
    fileprivate class func setupConstrantFooter() {
        CKeyboard.keyboard.addSubview(CKeyboard.footer)
        CKeyboard.footer.translatesAutoresizingMaskIntoConstraints = false
        CKeyboard.footer.bottomAnchor.constraint(equalTo: CKeyboard.keyboard.bottomAnchor).isActive = true
        CKeyboard.footer.leftAnchor.constraint(equalTo: CKeyboard.keyboard.leftAnchor).isActive = true
        CKeyboard.footer.rightAnchor.constraint(equalTo: CKeyboard.keyboard.rightAnchor).isActive = true
        CKeyboard.footer.heightAnchor.constraint(equalToConstant: footerHeight).isActive = true
        
        addButtonsToFooter()
    }
    
    fileprivate class func addButtonsToFooter() {
        
        let spaceBtn = self.generateKeyboardButton(title: CKeyboard.spaceBtn)
        CKeyboard.footer.addSubview(spaceBtn)
        spaceBtn.translatesAutoresizingMaskIntoConstraints = false
        
        spaceBtn.topAnchor.constraint(equalTo: CKeyboard.footer.topAnchor, constant: 5).isActive = true
        spaceBtn.bottomAnchor.constraint(equalTo: CKeyboard.footer.bottomAnchor, constant: -8).isActive = true
        spaceBtn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        spaceBtn.centerXAnchor.constraint(equalTo: CKeyboard.footer.centerXAnchor).isActive = true
        
        let deleteBtn = self.generateKeyboardButton(title: CKeyboard.deleteBtn)
        deleteBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        CKeyboard.footer.addSubview(deleteBtn)
        
        deleteBtn.translatesAutoresizingMaskIntoConstraints = false
        deleteBtn.topAnchor.constraint(equalTo: CKeyboard.footer.topAnchor, constant: 5).isActive = true
        deleteBtn.bottomAnchor.constraint(equalTo: CKeyboard.footer.bottomAnchor, constant: -8).isActive = true
        deleteBtn.widthAnchor.constraint(equalToConstant: 55).isActive = true
        deleteBtn.rightAnchor.constraint(equalTo: CKeyboard.footer.rightAnchor, constant: -10).isActive = true
    }
}

//    MARK:- Header
@available(iOS 9.0, *)
extension CKeyboard {
    //
    fileprivate static let header : UIView = {
        let v = UIView()
        v.backgroundColor = headerBackroundColor ?? #colorLiteral(red: 0.9450980392, green: 0.9450980392, blue: 0.9450980392, alpha: 1)
        return v
    }()
    
    fileprivate class func setupConstrantHeader(title:String) {
        CKeyboard.keyboard.addSubview(CKeyboard.header)
        CKeyboard.header.translatesAutoresizingMaskIntoConstraints = false
        CKeyboard.header.topAnchor.constraint(equalTo: CKeyboard.keyboard.topAnchor).isActive = true
        CKeyboard.header.leftAnchor.constraint(equalTo: CKeyboard.keyboard.leftAnchor).isActive = true
        CKeyboard.header.rightAnchor.constraint(equalTo: CKeyboard.keyboard.rightAnchor).isActive = true
        
        if CKeyboard.isHeaderHidden {
            CKeyboard.header.heightAnchor.constraint(equalToConstant: 0).isActive = true
        }else {
            CKeyboard.header.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true
        }
        
        
        addButtonsToHeader(title: title)
    }
    
    fileprivate class func addButtonsToHeader(title:String) {
        
        let doneBtn = self.generateHeaderButton(title: title)
        doneBtn.addTarget(CKeyboard.shared, action: #selector(doneButtonFunc), for: .touchUpInside)
        
        CKeyboard.header.addSubview(doneBtn)
        
        doneBtn.translatesAutoresizingMaskIntoConstraints = false
        doneBtn.topAnchor.constraint(equalTo: CKeyboard.header.topAnchor, constant: 5).isActive = true
        doneBtn.bottomAnchor.constraint(equalTo: CKeyboard.header.bottomAnchor, constant: -2).isActive = true
        doneBtn.widthAnchor.constraint(equalToConstant: 55).isActive = true
        doneBtn.rightAnchor.constraint(equalTo: CKeyboard.header.rightAnchor, constant: -10).isActive = true
    }
    
    @objc fileprivate func doneButtonFunc() {
        UIApplication.shared.keyWindow?.endEditing(true)
    }
}

extension UIButton {
    func dropShadow() {
        layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1)
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 0.0
        layer.masksToBounds = false
        layer.cornerRadius = 5.0
    }
}

