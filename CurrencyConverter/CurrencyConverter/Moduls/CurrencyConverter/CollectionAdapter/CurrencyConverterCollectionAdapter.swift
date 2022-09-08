//
//  CurrencyConverterCollectionAdapter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 08.09.2022.
//

import UIKit

final class CurrencyConverterCollectionAdapter: NSObject {
    
    private let onCellTappedHandler: (Int) -> ()
    
    init(completion: @escaping(Int) -> ()) {
        self.onCellTappedHandler = completion
    }
}

extension CurrencyConverterCollectionAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if CalculatorButtons.allCases[indexPath.item] == .o13ne || CalculatorButtons.allCases[indexPath.item] == .o14ne {
            return CGSize(width: collectionView.frame.width/2 - 0.5,
                          height: collectionView.frame.height/4 - 1)
        }
        
        return CGSize(width: collectionView.frame.width/4 - 1,
                      height: collectionView.frame.height/4 - 1)
    }
}

extension CurrencyConverterCollectionAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.onCellTappedHandler(indexPath.item)
    }
}

extension CurrencyConverterCollectionAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return CalculatorButtons.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CurrencyConverterCalculatorCell.id,
            for: indexPath) as? CurrencyConverterCalculatorCell
        else { return UICollectionViewCell() }
        
        let type = CalculatorButtons.allCases[indexPath.row]
        cell.setData(type)
        
        return cell
    }
}
