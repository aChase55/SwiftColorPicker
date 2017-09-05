//
//  GradientView.swift
//  Example
//
//  Created by Alex Chase on 9/4/17.
//  Copyright © 2017 Sixpolys. All rights reserved.
//
import UIKit

@IBDesignable class GradientView: UIView {
    
    // MARK: Inspectable properties
    
    @IBInspectable var startColor: UIColor = UIColor.black {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var endColor: UIColor = UIColor.clear {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var isHorizontal: Bool = false {
        didSet{
            setupView()
        }
    }
    
    @IBInspectable var roundness: CGFloat = 0.0 {
        didSet{
            setupView()
        }
    }
    
    func update() {
        setupView()
    }
    // MARK: Internal functions
    
    fileprivate func setupView(){
        let colors:Array = [startColor.cgColor, endColor.cgColor]
        gradientLayer.colors = colors
        gradientLayer.cornerRadius = roundness
        
        if (isHorizontal){
            gradientLayer.startPoint = CGPoint(x:0.0, y:0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        }
        else{
            gradientLayer.startPoint = CGPoint(x:0.5, y:0.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        }
//        self.update()
        
    }
    
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//        setupView()
//    }
    
    var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    
    
    // MARK: Overrides
    override class var layerClass:AnyClass{
        return CAGradientLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setupView()
    }
}

