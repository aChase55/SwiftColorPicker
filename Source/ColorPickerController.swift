//
//  ColorPickerController.swift
//
//  Created by Matthias Schlemm on 24/03/15.
//  Copyright (c) 2015 Sixpolys. All rights reserved.
//

import UIKit

open class ColorPickerController: NSObject {
    
    open var onColorChange:((_ color:UIColor, _ finished:Bool)->Void)? = nil
    
    // Hue Picker
    open var huePicker:HuePicker
    
    // Color Well
    open var colorWell:ColorWell? {
        didSet {
            if let well = colorWell {
                huePicker.setHueFromColor(well.color)
                colorPicker.color = well.color
            }
        }
    }
    
    // Color Picker
    open var colorPicker:ColorPicker
    
    open var color:UIColor? {
        set(value) {
            if let val = value {
                colorPicker.color = val
                colorWell?.color = val
                huePicker.setHueFromColor(val)
            }
        }
        get {
            return colorPicker.color
        }
    }
    
    public init(svPickerView:ColorPicker, huePickerView:HuePicker, colorWell:ColorWell?) {
        self.huePicker = huePickerView
        self.colorPicker = svPickerView
        self.colorWell = colorWell
        self.colorWell?.color = colorPicker.color
        self.colorPicker.gradientHorizontal?.endColor = colorPicker.color
        self.colorPicker.gradientHorizontal?.setNeedsDisplay()
        self.huePicker.setHueFromColor(colorPicker.color)
        super.init()
        self.colorPicker.onColorChange = {[unowned self] (color, finished) -> Void in
            self.huePicker.setHueFromColor(color)
            self.colorWell?.previewColor = (finished) ? nil : color
            if let well = self.colorWell,finished { well.color = color }
            self.onColorChange?(color, finished)
        }
        self.huePicker.onHueChange = {[unowned self] (hue, finished) -> Void in
            self.colorPicker.h = CGFloat(hue)
            let color = self.colorPicker.color
            self.colorWell?.previewColor = (finished) ? nil : color
            if(finished) {self.colorWell?.color = color}
            self.colorPicker.gradientHorizontal?.endColor = color
            self.colorPicker.gradientHorizontal?.setNeedsDisplay()
            self.onColorChange?(color, finished)
        }
    }
}
