//
//  PhotoListTableViewController.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 5/6/21.
//

import UIKit

class PhotoListTableViewController: UITableViewController {
    
    var gradientLayer:CAGradientLayer!
    var favouriteListArray = [Photo]()
    var photoListViewModel = PhotosListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelFetchPhotos()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readFromUserDefaults()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.photoListViewModel.photosList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoTableViewCell", for: indexPath) as! PhotoTableViewCell
        
        // Configure the cell...
        let item = self.photoListViewModel.photosList[indexPath.row]
        cell.configure(for: item, photoDataController: PhotoDataController.shared)
        if favouriteListArray.contains(item) {
            print("Item found")
            cell.favouriteButton.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)
        } else {
            print("not Found")
            cell.favouriteButton.setImage(UIImage(systemName: "star.circle"), for:.normal)
            
        }
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    // MARK: - Private methods
    
    private func updateUI() {
        self.tableView.reloadData()
    }
    
    func saveToUserDefaults(favouriteItems:[Photo]) {
        
        let favourites = favouriteItems
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            
            // Encode Photo
            let data = try encoder.encode(favourites)
            
            // Write/Set Data
            UserDefaults.standard.set(data, forKey: "favList")
            
        } catch {
            print("Unable to Encode Array of Photos (\(error))")
        }
    }
    
    func readFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "favList") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Photo
                favouriteListArray = try decoder.decode([Photo].self, from: data)
                
            } catch {
                print("Unable to Decode Photoa (\(error))")
            }
        }
    }
    
    @objc func favouriteButtonTapped(sender:UIButton) {
        let item = self.photoListViewModel.photosList[sender.tag]
        if favouriteListArray.contains(item) {
            favouriteListArray.removeAll { $0 == item}
            sender.setImage(UIImage(systemName: "star.circle"), for:.normal)
            
        } else {
            favouriteListArray.append(item)
            sender.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)
        }
        saveToUserDefaults(favouriteItems: favouriteListArray)
    }
    
    func setGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.black.withAlphaComponent(1.0).cgColor,
                                UIColor.black.withAlphaComponent(0.0).cgColor]
        
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func viewModelFetchPhotos() {
        createSpinnerView()
        photoListViewModel.fetchPhotos { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(_):
                self.updateUI()
            case .failure(_):
                self.showAlert(message: "check your internet and try again!")
            }
        }
    }
    
    func createSpinnerView() {
        let child = SpinnerViewController()

        // add the spinner view controller
        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        // wait two seconds to simulate some work happening
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // then remove the spinner view controller
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
    
}
 
