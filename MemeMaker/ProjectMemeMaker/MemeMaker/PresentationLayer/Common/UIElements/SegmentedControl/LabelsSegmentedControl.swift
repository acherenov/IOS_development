//
//  LabelsSegmentedControl.swift
//  MemeMaker
//
//  Created by Alex Cherenov on 03.04.21.
//

import UIKit

class LabelsSegmentedControl: SegmentedControl {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: - Public methods
    
    func addTextSegment(_ text: String) {
        let label = UILabel()
        label.font = R.font.gilroyBold(size: 16)
        label.textColor = R.color.tintColorLight()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = text
        stack.arrangedSubviews.isEmpty ? selectedLabelConfiguration(label) : defaultLabelConfiguration(label)
        addSegment(label)
    }
    
    // MARK: - Private methods
    
    private func setup() {
        selectionDidChange = refreshSelectedView(_:_:)
    }
    
    private func refreshSelectedView(_ oldSelectedIndex: Int, _ newSelectedIndex: Int) {
        guard let old = stack.arrangedSubviews[oldSelectedIndex] as? UILabel,
              let new = stack.arrangedSubviews[newSelectedIndex] as? UILabel
        else { return }
        UIView.transition(with: old,
                          duration: duration,
                          options: .transitionCrossDissolve) { [ weak self ] in
            self?.defaultLabelConfiguration(old)
        }
        UIView.transition(with: new,
                          duration: duration,
                          options: .transitionCrossDissolve) { [ weak self ] in
            self?.selectedLabelConfiguration(new)
        }
    }
    
    private func refreshSelectedView() {
        for i in 0 ..< stack.arrangedSubviews.count {
            if let label = stack.arrangedSubviews[i] as? UILabel {
                if i == selectedSegmentIndex {
                    selectedLabelConfiguration(label)
                } else {
                    defaultLabelConfiguration(label)
                }
            }
        }
    }
    
    private func defaultLabelConfiguration(_ label: UILabel) {
        label.textColor = R.color.tintColorLight()
    }
    
    private func selectedLabelConfiguration(_ label: UILabel) {
        label.textColor = R.color.main()
    }
}
