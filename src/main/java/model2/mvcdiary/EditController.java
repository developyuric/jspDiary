package model2.mvcdiary;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import fileupload.FileUtil;
import utils.JSFunction;

/**
 * Servlet implementation class EditController
 */
@WebServlet("/edit.do")
public class EditController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public EditController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String no=request.getParameter("no");//글번호
		MVCDiaryDAO dao=new MVCDiaryDAO();//dao생성
		MVCDiaryDTO dto=dao.selectView(no); //상세정보 dto에 저장
		request.setAttribute("dto", dto);//"dto" attribute name으로 전달
		request.getRequestDispatcher("/Edit.jsp").forward(request, response);//view로 포워딩.주소변경없음.
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 폼에 입력한 한글 인코딩처리. 깨짐방지
		request.setCharacterEncoding("UTF-8");
		
		//파일업로드 처리
		String saveDirectory=request.getServletContext().getRealPath("/Uploads");
		System.out.println(saveDirectory);
		int maxPostSize=5*1024*1024; // 첨부파일 최대크기 5Mbyte로 지정.
		MultipartRequest mr=FileUtil.uploadFile(request,saveDirectory, maxPostSize);//파일업로드
	    if(mr==null) {
			JSFunction.alertBack(response, "첨부파일이 제한 용량을 초과합니다");
	    	return;
	    }		    
	       
	    // 폼에 입력한 값을 dto에 저장
	    String no=mr.getParameter("no");
	    String prevOfile=mr.getParameter("prevOfile");
	    String prevSfile=mr.getParameter("prevSfile");	    
	    String weather=mr.getParameter("weather");
	    String title=mr.getParameter("title");
	    String content=mr.getParameter("content");

	    
	    
	    
 		MVCDiaryDTO dto=new MVCDiaryDTO();
 		dto.setNo(no); 		
 		dto.setTitle(title);
 		dto.setContent(content);
 		dto.setWeather(weather);
 		
 		//업로드된 원본파일명을 변경해서 중복방지
 		String fileName=mr.getFilesystemName("ofile");
 		if(fileName!=null) {
 			String now=new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
 			String ext=fileName.substring(fileName.lastIndexOf(".")); //확장자구하기
 			String newFileName=now+ext; //새로운 파일명 만들기
 			File oldFile=new File(saveDirectory+File.separator+fileName);
 			File newFile=new File(saveDirectory+File.separator+newFileName);
 			oldFile.renameTo(newFile); //파일명변경
 			
 			dto.setOfile(fileName);//원래 파일명
 			dto.setSfile(newFileName);//새 파일명
 			
 			//기존파일삭제
 			FileUtil.deleteFile(request, "/Uploads", prevSfile);
 		}else {//첨부파일을 선택하지 않은 경우
 			//기존파일명 사용
 			dto.setOfile(prevOfile);
 			dto.setSfile(prevSfile); 			
 		}
 		
 		
 		MVCDiaryDAO dao=new MVCDiaryDAO();
 		int result=dao.updatePost(dto);//수정
 		dao.close();
		if(result==1) { response.sendRedirect("/view.do?no="+no); } //없으면 수정은 되도 화면에 안보임
			
		
 		
	}

}
