//
//  UIHelper.swift
//  GithubFollowers
//
//  Created by Ahmet Samsun on 22.04.2024.
//

import UIKit

struct UIHelper {
    static  func createThreeColoumnFlowLayout(in view : UIView) -> UICollectionViewFlowLayout{
        
        let width = view.bounds.width
        let padding : CGFloat = 12
        let itemspacing : CGFloat = 10
        let avaliablewidth = width - (padding * 2) - (itemspacing * 2)
        let itemwidth = avaliablewidth / 3
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize = CGSize(width: itemwidth, height: itemwidth + 40)
        
        return flowlayout
    }
}
