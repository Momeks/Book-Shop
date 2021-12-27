//
//  ReadingViewController.swift
//  Book Shop
//
//  Created by Momeks on 12/27/21.
//

import UIKit
import PDFKit

class ReadingViewController: UIViewController  {
    
    
    var pdfView:PDFView!
    @IBOutlet weak var PDFPreview: UIView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupPDFView()

    }

    
    func setupPDFView() {
        
        guard let file = Bundle.main.path(forResource: "Sample", ofType: "pdf") else { return }
        let url = URL(fileURLWithPath: file)
        
        pdfView = PDFView(frame: PDFPreview.frame)
        pdfView.usePageViewController(true, withViewOptions: nil)
        pdfView.displayDirection = .horizontal
        pdfView.backgroundColor = .clear
        pdfView.displayMode = .singlePage
        pdfView.autoScales = true
        pdfView.pageShadowsEnabled = false
        pdfView.document = PDFDocument(url: url)
        PDFPreview.addSubview(pdfView)
       
    }
    
 
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    
}

