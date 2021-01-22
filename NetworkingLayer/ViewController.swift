//
//  ViewController.swift
//  NetworkingLayer


import UIKit

class ViewController: UIViewController {
    
    var networkManager: NetworkManager!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        networkManager = NetworkManager()
        view.backgroundColor = .green
        networkManager.getNewMovies(page: 1) { movies, error in
            if let error = error {
                print(error)
            }
            if let movies = movies {
                print(movies)
            }
        }
    }
}
