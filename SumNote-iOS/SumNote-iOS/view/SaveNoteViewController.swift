//
//  SaveNoteViewController.swift
//  SumNote-iOS
//
//  Created by Choi76 on 4/28/24.
//

import UIKit

class SaveNoteViewController: UIViewController {

    @IBOutlet weak var noteTableView: UITableView!
    @IBOutlet weak var saveNewNoteBtn: UIButton!
    
    var noteTitle : String?
    var noteContent : String?
    
    var noteList : [UserNote] = []{
        didSet{ // 상태 변경시 테이블뷰 리로드
            noteTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableView()
        getAllNote() // 서버로부터 데이터 요청
    }
    
    private func setTableView(){
        noteTableView.delegate = self
        noteTableView.dataSource = self
        // 사용할 셀 등록
        noteTableView.register(UINib(nibName: "AllNoteTableViewCell", bundle: nil), forCellReuseIdentifier: AllNoteTableViewCell.identifier)
    }
    
    private func getAllNote(){
        SpringAPI.shared.getNoteRequest(type: "all"){ isSuccess, noteList in
            if isSuccess{
                self.noteList = noteList
            }
        }
    }
    

}

extension SaveNoteViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    // 보여줄 셀의 모습 지정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 사용할 셀
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AllNoteTableViewCell.identifier, for: indexPath) as? AllNoteTableViewCell else{
            let errorCell = UITableViewCell()
            errorCell.backgroundColor = .blue
            return errorCell
        }

        // Data Binding
        let note = noteList[indexPath.row]
        cell.noteGenDate.text = note.lastModifiedAt
        cell.noteTitle.text = note.title
        
        // 모듈러 연산을 사용하여 노트 이미지를 돌려쓸수 있도록
        let noteNum = (indexPath.row)%8+1
        cell.noteImage.image = UIImage(named: "img_note_\(noteNum)")
        
        // 셀 클릭 이벤트 제거(회색 배경 안뜨드록)
        cell.selectionStyle = .none
        
        return cell
    }
    
    
}

extension SaveNoteViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let note = noteList[indexPath.row]
        let notePage = SaveNotePageDto(title: self.noteTitle, content: self.noteContent) // 저장할 페이지
        
        SpringAPI.shared.savePageToNoteRequest(noteId: note.noteId!, notePage: notePage){ isSuccess in
            if isSuccess {
                self.log("tableView didSelectRowAt : Success to save note")
                
            } else {
                self.log("tableView didSelectRowAt : Fail to save note")
            }
            // 이후 초기화면으로 이동하는 로직 작성 필요
        }
    }
}

extension SaveNoteViewController {
    private func log(_ message : String) {
        print("📌[SaveNoteViewController] \(message)📌")
    }
}


