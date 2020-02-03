//
//  ViewController.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let albumCellId = "AlbumCell"
    
    let albumsTableView: UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        return tv
    }()
    
    var feedData = FeedData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        navigationItem.title = NSLocalizedString("Albums", comment: "Title")
        
        setupUI()
        fetchFeedData()
    }
    
    private func setupUI() {
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(fetchFeedData))
        
        view.addSubview(albumsTableView)
        albumsTableView.dataSource = self
        albumsTableView.delegate = self
        albumsTableView.fillSuperview()
    }
    
    @objc
    private func fetchFeedData() {
        // Fetching feed...
        Services.shared.fetchFeedData(upto: 100) { [weak self] (feedData, error) in
            guard let feedData = feedData else {
                print(error ?? "")
                return
            }
            
            self?.feedData = feedData
            
            feedData.albums.forEach { (album) in
                if let url = album.artUrl {
                    ImageDownloader.shared.downloadImage(url: url, save: true) {_,_  in
                        DispatchQueue.main.async {
                            if let idx = feedData.albums.firstIndex(where: { $0.artUrl == url }) {
                                self?.albumsTableView.reloadRows(at: [IndexPath(row: idx, section: 0)], with: .automatic)
                            }
                        }
                    }
                }
            }
            
            DispatchQueue.main.async {
                self?.albumsTableView.reloadData()
            }
        }
    }

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedData.albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let album = feedData.albums[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: albumCellId)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: albumCellId)
        }
        if let url = album.artUrl {
            cell?.imageView?.image = ImagesCache.shared.image(forKey: url.absoluteString)
        }
        cell?.textLabel?.text = album.name
        cell?.detailTextLabel?.text = album.artist
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = feedData.albums[indexPath.row]
        let detail = DetailViewController()
        detail.album = album
        navigationController?.pushViewController(detail, animated: true)
    }
    
    
}
