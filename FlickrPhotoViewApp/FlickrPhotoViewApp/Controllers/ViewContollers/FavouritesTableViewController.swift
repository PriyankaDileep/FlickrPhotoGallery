//
//  FavouritesTableViewController.swift
//  FlickrPhotoViewApp
//
//  Created by Priyanka PS on 5/6/21.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
    var favouritePhotsArray = [Photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        readFromUserDefaults()
        self.tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favouritePhotsArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritePhotoTableviewCell", for: indexPath)as! FavouritePhotoTableViewCell
        let item = favouritePhotsArray[indexPath.row]
        // Configure the cell...
        cell.photoTitleLabel.text = item.title
        cell.photoGrapherNameLabel.text = item.name
        cell.configure(for: item, photoDataController: PhotoDataController.shared)
        if favouritePhotsArray.contains(item) {
            cell.favouriteButton.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)
        } else {
            cell.favouriteButton.setImage(UIImage(systemName: "star.circle"), for:.normal)
        }
        cell.favouriteButton.tag = indexPath.row
        cell.favouriteButton.addTarget(self, action: #selector(favouriteButtonTapped(sender:)), for: .touchUpInside)
        return cell
    }
    
    // MARK: - Private methods
    
    func readFromUserDefaults() {
        if let data = UserDefaults.standard.data(forKey: "favList") {
            do {
                // Create JSON Decoder
                let decoder = JSONDecoder()
                
                // Decode Photo
                favouritePhotsArray = try decoder.decode([Photo].self, from: data)
                
            } catch {
                print("Unable to Decode Photos (\(error))")
            }
        }
    }
    
    func saveToUserDefaults(favouriteItems:[Photo]) {
        let favourites = favouriteItems
        do {
            // Create JSON Encoder
            let encoder = JSONEncoder()
            // Encode Photo
            let data = try encoder.encode(favourites)
            UserDefaults.standard.set(data, forKey: "favList")
        } catch {
            print("Unable to Encode Array of Photos (\(error))")
        }
    }
    
    @objc func favouriteButtonTapped(sender:UIButton) {
        let item = self.favouritePhotsArray[sender.tag]
        if favouritePhotsArray.contains(item) {
            print("Item found")
            favouritePhotsArray.removeAll { $0 == item}
            sender.setImage(UIImage(systemName: "star.circle"), for:.normal)
        } else {
            print("not Found")
            favouritePhotsArray.append(item)
            sender.setImage(UIImage(systemName: "star.circle.fill"), for:.normal)
        }
        saveToUserDefaults(favouriteItems: favouritePhotsArray)
    }
    
    func setGradientBackground() {
        let colorTop =  UIColor(red: 255.0/255.0, green: 149.0/255.0, blue: 0.0/255.0, alpha: 1.0).cgColor
        let colorBottom = UIColor(red: 255.0/255.0, green: 94.0/255.0, blue: 58.0/255.0, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, at:0)
    }
}
