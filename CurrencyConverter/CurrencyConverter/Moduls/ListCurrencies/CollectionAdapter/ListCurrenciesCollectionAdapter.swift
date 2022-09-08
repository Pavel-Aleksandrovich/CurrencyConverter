//
//  ListCurrenciesCollectionAdapter.swift
//  CurrencyConverter
//
//  Created by pavel mishanin on 08.09.2022.
//

import UIKit

final class ListCurrenciesCollectionAdapter: NSObject {
    
    private let onCellTappedHandler: (Int) -> ()
    
    init(completion: @escaping(Int) -> ()) {
        self.onCellTappedHandler = completion
    }
}

extension ListCurrenciesCollectionAdapter: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width/2,
                      height: collectionView.frame.height)
    }
}

extension ListCurrenciesCollectionAdapter: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        self.onCellTappedHandler(indexPath.row)
    }
}

extension ListCurrenciesCollectionAdapter: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return TypeCurrencies.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCurrenciesCollectionCell.id,
            for: indexPath) as? ListCurrenciesCollectionCell
        else { return UICollectionViewCell() }
        
        collectionView.selectItem(at: [0, 0],
                                  animated: true,
                                  scrollPosition: [])
        
        let type = TypeCurrencies.allCases[indexPath.row]
        cell.setData(type)
        
        return cell
    }
}
