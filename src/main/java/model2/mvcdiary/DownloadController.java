package model2.mvcdiary;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import fileupload.FileUtil;

/**
 * Servlet implementation class DownloadController
 */
@WebServlet("/download.do")
public class DownloadController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DownloadController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 매개변수 받기
		String ofile = request.getParameter("ofile"); // 원본 파일명
		String sfile = request.getParameter("sfile"); // 저장된 파일명
		String no = request.getParameter("no"); // 글번호
		
		// 파일 다운로드
		FileUtil.download(request, response, "/Uploads", sfile, ofile);
		
		// 파일 다운로드 횟수 증가
		MVCDiaryDAO dao = new MVCDiaryDAO();
//		System.out.println(no);
		dao.downCountPlus(no);
		dao.close();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}