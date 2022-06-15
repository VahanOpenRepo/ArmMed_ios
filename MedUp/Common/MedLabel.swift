//
//  MedLabel.swift
//  MedUp
//
//  Created by Vahan Grigoryan on 6/6/21.
//

import UIKit

public class MedLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    public override func awakeFromNib() {
        commonInit()
    }
    
    func commonInit() {
        
        
    }
    
}
