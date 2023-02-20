//
//  HomeViewController.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/16.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class HomeViewController: UIViewController {
    
    //MARK: - UI
    
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.isScrollEnabled = true
        $0.isPagingEnabled = true
        $0.showsHorizontalScrollIndicator = false
        $0.addSubview(contentStackView)
    }
    
    private lazy var contentStackView: UIStackView = UIStackView(arrangedSubviews: [randomPhotoView, photoCollectionsView]).then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.alignment = .center
        $0.spacing = 0
    }
    
    private var randomPhotoButton: UIButton = UIButton().then {
        $0.setTitle("Random", for: .normal)
        $0.setTitleColor(.black, for: .normal)
    }
    
    private var collectionPhotoButton: UIButton = UIButton().then {
        $0.setTitle("Collections", for: .normal)
        $0.setTitleColor(.lightGray, for: .normal)
    }
    
    private var selectedUnderLineView: UIView = UIView().then {
        $0.backgroundColor = .black
    }
    
    private var backgroundUnderLineView: UIView = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    private lazy var indicatorView: UIView = UIView().then {
        $0.addSubview(randomPhotoButton)
        $0.addSubview(collectionPhotoButton)
        $0.addSubview(backgroundUnderLineView)
        $0.addSubview(selectedUnderLineView)
    }
    
    private let randomPhotoView = RandomPhotoView()
    private let photoCollectionsView = PhotoCollectionsView()
    
    //MARK: - Properties
    
    private lazy var input = HomeViewModel.Input(
        refreshButtonTap: randomPhotoView.refreshButton.rx.tap.asSignal())
    private lazy var output = viewModel.transform(input: input)
    private let viewModel: HomeViewModel
    private var disposeBag = DisposeBag()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        viewModel.requestRandomPhoto()
        viewModel.requestPhotoCollections()
        configureUI()
        setConstraints()
        bind()
    }
    
    //MARK: - SetUI
    
    private func configureUI() {
        self.view.backgroundColor = .white
        [indicatorView, scrollView].forEach { self.view.addSubview($0) }
    }
    
    private func setConstraints() {
        indicatorView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        randomPhotoButton.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.width.equalTo(view.frame.width / 2)
        }
        collectionPhotoButton.snp.makeConstraints { make in
            make.trailing.centerY.equalToSuperview()
            make.width.equalTo(view.frame.width / 2)
        }
        selectedUnderLineView.snp.makeConstraints { make in
            make.leading.bottom.equalToSuperview()
            make.width.equalTo(view.frame.width / 2)
            make.height.equalTo(3)
        }
        backgroundUnderLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(indicatorView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        contentStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(2)
        }
        randomPhotoView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.height.equalToSuperview()
        }
        photoCollectionsView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.height.equalToSuperview()
        }
    }
    
    //MARK: - Method
    
    private func bind() {
        
        scrollView.rx.didScroll
            .withUnretained(self)
            .map { vc, _ in
                return Int(vc.scrollView.contentOffset.x / vc.scrollView.frame.size.width)
            }
            .bind { [weak self] index in
                guard let self = self else { return }
                if index == 0 {
                    self.changeUnderLinePosition(
                        index: index,
                        selectedButton: self.randomPhotoButton,
                        deselectedButton: self.collectionPhotoButton)
                } else {
                    self.changeUnderLinePosition(
                        index: index,
                        selectedButton: self.collectionPhotoButton,
                        deselectedButton: self.randomPhotoButton)
                }
            }
            .disposed(by: disposeBag)
        
        randomPhotoButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        collectionPhotoButton.rx.tap
            .withUnretained(self)
            .bind { vc, _ in
                vc.scrollView.setContentOffset(CGPoint(x: vc.scrollView.frame.width, y: 0), animated: true)
            }
            .disposed(by: disposeBag)
        
        viewModel.randomPhotoList
            .withUnretained(self)
            .bind { vc, value in
                vc.randomPhotoView.data = value
            }
            .disposed(by: disposeBag)
            
//        input.refreshButtonTap
//            .withUnretained(self)
//            .emit { vc, _ in
//                vc.viewModel.requestRandomPhoto()
//            }
//            .disposed(by: disposeBag)
        
        output.randomPhotoList
            .drive(randomPhotoView.collectionView.rx.items) { [weak self] cv, index, item in
                guard let self = self else { return UICollectionViewCell()}
                let cell = cv.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.id, for: IndexPath(item: index, section: 0)) as! HomeCollectionViewCell
                
                DispatchQueue.global().async {
                    let url = URL(string: item.urls.regular)!
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let image = data {
                            cell.imageView.image = UIImage(data: image)
                        }
                    }
                }
                return cell
            }
            .disposed(by: disposeBag)
        
        output.photoCollectionList
            .drive(photoCollectionsView.collectionView.rx.items) { [weak self] cv, index, item in
                guard let self = self else { return UICollectionViewCell() }
                let cell = cv.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.id, for: IndexPath(item: index, section: 0)) as! HomeCollectionViewCell
                
                DispatchQueue.global().async {
                    let url = URL(string: item.urls.regular)!
                    let data = try? Data(contentsOf: url)
                    DispatchQueue.main.async {
                        if let image = data {
                            cell.imageView.image = UIImage(data: image)
                        }
                    }
                }
                return cell
            }
            .disposed(by: disposeBag)
        
    }
    
    private func changeUnderLinePosition(index: Int, selectedButton: UIButton, deselectedButton: UIButton) {
        if index == 0 {
            UIView.animate(withDuration: 0.3) {
                self.selectedUnderLineView.snp.updateConstraints { make in
                    make.leading.equalToSuperview()
                }
                self.view.layoutIfNeeded()
            }
        } else {
            UIView.animate(withDuration: 0.05) {
                self.selectedUnderLineView.snp.updateConstraints { make in
                    make.leading.equalToSuperview().inset(self.view.frame.width / 2)
                }
                self.view.layoutIfNeeded()
            }
        }
        selectedButton.setTitleColor(.black, for: .normal)
        deselectedButton.setTitleColor(.lightGray, for: .normal)
    }
    
    
    
    
    
}
