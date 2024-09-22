package model2.mvcdiary;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fileupload.FileUtil;
import utils.JSFunction;

/**
 * Servlet implementation class DeleteController
 */
@WebServlet("/delete.do")
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String no = request.getParameter("no"); // 글번호
		MVCDiaryDAO dao = new MVCDiaryDAO(); // DAO 생성
		MVCDiaryDTO dto = dao.selectView(no); // 상세정보 DTO에 저장

		if (dto != null) {
			// 파일 삭제
			FileUtil.deleteFile(request, "/Uploads", dto.getSfile());
			
			// 글 삭제
			int result = dao.deletePost(no);
			dao.close();
			
			if (result == 1) { // 삭제 성공 시
				JSFunction.alertLocation(response, "글이 삭제되었습니다.", "/list.do");
			} 
		} else {
			JSFunction.alertBack(response, "해당 글을 찾을 수 없습니다.");
		}
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
