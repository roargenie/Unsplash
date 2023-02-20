//
//  ImageDetailViewController.swift
//  Unsplash
//
//  Created by 이명진 on 2023/02/20.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit
import Then

final class ImageDetailViewController: UIViewController {
    
    //MARK: - UI

    private var detailImageView: UIImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .black
//        $0.image = UIImage(named: "testimage1")
    }
    
    private lazy var scrollView: UIScrollView = UIScrollView().then {
        $0.addSubview(detailImageView)
        $0.zoomScale = 1.0
        $0.minimumZoomScale = 1.0
        $0.maximumZoomScale = 2.0
    }
    
    
    //MARK: - Properties
    
    private lazy var input = ImageDetailViewModel.Input()
    private lazy var output = viewModel.transform(input: input)
    let viewModel: ImageDetailViewModel
    private var disposeBag = DisposeBag()
//    var randomPhotoRelay = PublishRelay<RandomPhoto>()
//    var photoCollectionRelay = PublishRelay<PhotoCollection>()
    

    //MARK: - Init
    
    init(viewModel: ImageDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setConstraints()
        bind()
    }
    
    
    
    //MARK: - SetUI
    
    private func configureUI() {
        scrollView.delegate = self
        view.addSubview(scrollView)
    }
    
    private func setConstraints() {
        detailImageView.snp.makeConstraints { make in
            make.center.equalTo(scrollView.snp.center)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.safeAreaLayoutGuide)
        }
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    //MARK: - Method

    private func bind() {
            
        scrollView.rx.didScroll
            .withUnretained(self)
            .bind { vc, _ in
                if vc.scrollView.zoomScale <= 1.0 {
                    vc.scrollView.zoomScale = 1.0
                }
                if vc.scrollView.zoomScale >= 2.0 {
                    vc.scrollView.zoomScale = 2.0
                }
            }
            .disposed(by: disposeBag)
        
        output.selectedRandomPhoto
            .drive { [weak self] value in
                if let image = value.first {
                    self?.setImage(item: image)
                }
            }
            .disposed(by: disposeBag)
            
        output.selectedCollectionPhoto
            .drive { [weak self] value in
                if let image = value.first {
                    self?.setImage(item: image)
                }
            }
            .disposed(by: disposeBag)
        
    }


    
}

    //MARK: - Extension

extension ImageDetailViewController {
    
    private func setImage(item: RandomPhoto) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let url = URL(string: item.urls.regular)!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let image = data {
                    self.detailImageView.image = UIImage(data: image)
                }
            }
        }
    }
    
    private func setImage(item: PhotoCollection) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self else { return }
            let url = URL(string: item.urls.regular)!
            let data = try? Data(contentsOf: url)
            DispatchQueue.main.async {
                if let image = data {
                    self.detailImageView.image = UIImage(data: image)
                }
            }
        }
    }
    
    
    
}

extension ImageDetailViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.detailImageView
    }
    
}
