//
//  HomeViewController.swift
//  Calculator
//
//  Created by iOS Developer on 03/12/24.
//

import UIKit

class HomeViewController: UIViewController{
    
    //MARK: - UIComponents
    private lazy var logo: UIImageView = {
        let image = UIImageView(image: UIImage(named: "logo"))
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Calculator"
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 44, weight: .bold)
        return label
    }()
    
    private lazy var info: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "A calculator app has never been so fun"
        label.textColor = .white
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .thin)
        return label
    }()
    
    private lazy var startButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Let's start", for: .normal)
        button.backgroundColor = .button
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .bg
        addSubView()
        setupConstraints()
    }
    
    //MARK: - AddSubViewFunction
    private func addSubView(){
        view.addSubview(logo)
        view.addSubview(label)
        view.addSubview(info)
        view.addSubview(startButton)
    }
    
    //MARK: - SetupConstraints
    private func setupConstraints(){
        NSLayoutConstraint.activate([
            
            //Setting Logo Constaint
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.widthAnchor.constraint(equalToConstant: 330),
            logo.heightAnchor.constraint(equalToConstant: 330),
            
            //Setting MainLabel Constaint
            label.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: -48),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            //Setting InfoLabel Constaint
            info.topAnchor.constraint(equalTo: label.bottomAnchor),
            info.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            info.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            //Setting StartButton Constaint
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            startButton.widthAnchor.constraint(equalToConstant: 300),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    //MARK: - ButtonPressedMethod
    @objc private func buttonPressed(){
        navigationController?.pushViewController(FirstViewController(), animated: true)
    }
    
}


