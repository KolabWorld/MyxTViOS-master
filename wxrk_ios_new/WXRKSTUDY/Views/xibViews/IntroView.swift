//
//  IntroView.swift
//  WXRKSTUDY
//
//  Created by KaramjeetSingh on 02/08/22.
//

import UIKit

protocol IntroViewDelegate: AnyObject {
    func skip(action: String )
}
class IntroView: UIView {
    weak var delegate: IntroViewDelegate?

    @IBOutlet weak var lblIntroTitle: UILabel!
    @IBOutlet weak var vwWorkGotIt: UIView!
    @IBOutlet weak var imgCharacter: UIImageView!
    @IBOutlet weak var lblIntroDisc: UILabel!
    @IBOutlet weak var btnSkip: UIButton!

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
     */
    @IBAction func skipAction(_ sender: Any) {
        delegate?.skip(action: btnSkip.title(for: .normal)!)

    }
}
