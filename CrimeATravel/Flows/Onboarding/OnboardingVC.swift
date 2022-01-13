//
//  OnboardingVC.swift
//  CrimeATravel
//
//  Created by Murad Ibrohimov on 13.01.22.
//

import UIKit

class OnboardingVC: UIViewController {
    
    //MARK: Properties
    
    private let onboardings = OnboardingFlowTypes.allCases
    private var currentPageIndex: Int = 0
    
    //MARK: Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK: UI Variables
    
    lazy var paggingFlowLayout: Pagging3DEffectFlowLayout = {
        let layout = Pagging3DEffectFlowLayout()
        layout.scrollDirection = .horizontal
        return layout
    }()
    
    //MARK: Initialization
    
    init() {
        super.init(nibName: "OnboardingVC", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        paggingFlowLayout.itemSize = collectionView.bounds.size
        collectionView.collectionViewLayout = paggingFlowLayout
        collectionView.reloadData()
    }
    
    //MARK: Private methods
    
    private func setupUI() {
        pageControl.numberOfPages = onboardings.count
        collectionView.register(UINib(nibName: OnboardingCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
    }
    
    //MARK: Actions
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if currentPageIndex < onboardings.count - 1 {
            paggingFlowLayout.swipeRigth()
        } else {
            print("go home")
        }
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        print("skipButtonTapped")
        print("go home")
    }
}

//MARK: UICollectionViewDataSource
extension OnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        onboardings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath)
        (cell as? OnboardingCollectionViewCell)?.configure(with: onboardings[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        let visibleIndexPath = collectionView.indexPathForItem(at: visiblePoint)
        
        guard let newIndex = visibleIndexPath?.row else { return }
        currentPageIndex = newIndex
        pageControl.currentPage = newIndex
    }
}

//MARK: UICollectionViewDelegate
extension OnboardingVC: UICollectionViewDelegate {
    
}
