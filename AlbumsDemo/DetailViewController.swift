//
//  DetailViewController.swift
//  AlbumsDemo
//
//  Created by Goutham Nani on 1/31/20.
//  Copyright © 2020 Goutham Nani. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var album: Album?
    
    let albumImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    let genresLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let releaseDateLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let copyrightsLabel: UILabel = {
        let l = UILabel()
        return l
    }()
    
    let iTunesButton: UIButton = {
        let b = UIButton(type: .system)
        b.setTitle(NSLocalizedString("iTunes U", comment: "iTunes U"), for: .normal)
        return b
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        navigationItem.title = NSLocalizedString(album?.name ?? "", comment: "Album Title")
        
        setupUI()
    }
    
    private func setupUI() {
        
        guard let album = album else {
            return
        }
        
        view.addSubview(albumImageView)
        albumImageView.anchor(top: view.layoutMarginsGuide.topAnchor, leading: view.layoutMarginsGuide.leadingAnchor, bottom: nil, trailing: view.layoutMarginsGuide.trailingAnchor, padding: .zero, size: .init(width: 0, height: 300))
        if let url = album.artUrl {
            albumImageView.setImage(fromUrl: url)
        }
        
        view.addSubview(genresLabel)
        genresLabel.anchor(top: albumImageView.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20), size: .zero)
        if album.genres.count > 0 {
            genresLabel.text = String(format: NSLocalizedString("Genres: %d", comment: "Genres"), album.genres.count)
        } else {
            genresLabel.text = ""
        }
        
        view.addSubview(releaseDateLabel)
        releaseDateLabel.anchor(top: genresLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 20), size: .zero)
        releaseDateLabel.text = String(format: NSLocalizedString("Release Date: %@", comment: "Release Date"), album.releaseDate)
        
        view.addSubview(copyrightsLabel)
        copyrightsLabel.anchor(top: releaseDateLabel.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: nil, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 8, left: 20, bottom: 0, right: 20), size: .zero)
        copyrightsLabel.text = String(format: NSLocalizedString("%@", comment: "Copy Rights"), album.copyRight)
        
        view.addSubview(iTunesButton)
        iTunesButton.anchor(top: nil, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .zero)
        iTunesButton.addTarget(self, action: #selector(iTunesButtonPressed), for: .touchUpInside)
        
    }
    
    @objc func iTunesButtonPressed() {
        if let url = album?.url {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

}
