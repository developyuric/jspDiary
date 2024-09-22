package model2.mvcdiary;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import common.DBConnPool;

public class MVCDiaryDAO extends DBConnPool{
	//기본생성자. 생성자가 호출되면 부모 클래스의 생성자가 호출된다.
	public MVCDiaryDAO() {}
	
	// 전체 글의 수
		public int selectCount(Map<String, Object> map) {
			int totalCount=0;
			String query = "select count(*) from mvcdiary ";
			//검색조건추가
			if(map.get("searchWord")!=null) {
				query+=" where "+map.get("searchField")+" like '%"+map.get("searchWord")+"%'";
			}
			try {
				stmt = con.createStatement();
				rs=stmt.executeQuery(query);
				if(rs.next()) {
					totalCount = rs.getInt(1); // count(*)을 의미
				}
			} catch (Exception e) {
				System.out.println("일기장 카운트 중 예외 발생");
				e.printStackTrace();
			}
			return totalCount;
		}
	
	
	//목록.페이징처리
	public List<MVCDiaryDTO> selectListPage(Map<String,Object> map){
		List<MVCDiaryDTO> diary=new ArrayList<MVCDiaryDTO>();
		// 쿼리문 작성
		String query="select * from ( "
				+ "		select tb.*, rownum rnum from ( "
				+ "			select * from mvcdiary ";
		
		//검색조건추가
		if(map.get("searchWord")!=null) {
			query+="		where "+map.get("searchField")+" like '%"+map.get("searchWord")+"%'";
		}
		
		query +="			order by no desc "
				+ "		) tb "
				+ "	) "
				+ " where rnum between ? and ?";	
		
		// DBConnPool에서 변수 선언해놨었음
		try {
			psmt=con.prepareStatement(query); // prepared statement객체 생성
			psmt.setString(1, map.get("start").toString()); // 첫번째 ?에 값 매핑
			psmt.setString(2, map.get("end").toString()); // 두번째 ?에 값 매핑
			rs=psmt.executeQuery();
			
			while(rs.next()) {
				//DTO에 쿼리결과를 저장
				MVCDiaryDTO dto=new MVCDiaryDTO();
				dto.setNo(rs.getString("no"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setWeather(rs.getString("weather"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setDowncount(rs.getInt("downcount"));
				
				diary.add(dto); // list에 추가	
			}			
		}catch(Exception e) {
			e.printStackTrace();
		}
		return diary; // list를 리턴
	}
	
	//등록
	public int insertWrite(MVCDiaryDTO dto) {
		int result=0;	//영향을 받은 행의 수
		
		try {
			String query="insert into mvcdiary ("
					+ " no,title,content,weather,ofile,sfile)"
					+ " values( seq_diary_num.nextval,?,?,?,?,?)";
				psmt=con.prepareStatement(query);
				psmt.setString(1,  dto.getTitle());
				psmt.setString(2,  dto.getContent());
				psmt.setString(3,  dto.getWeather());
				psmt.setString(4, dto.getOfile());
				psmt.setString(5, dto.getSfile());				
				result=psmt.executeUpdate(); 	//executeUpdate()의 리턴값은 영향을 받은 행의 수
			}
		catch(Exception e) {
			e.printStackTrace();
		}
		return result;	//영향을 받은 행의 수 리턴
	}
	
	// 다운로드 횟수 증가
		public void downCountPlus(String no) {
			String sql = "update mvcdiary set "
					+ " downcount=downcount+1 "
					+ " where no=? ";
			try {
				psmt = con.prepareStatement(sql);
				psmt.setString(1, no);
				psmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		//상세보기
		public MVCDiaryDTO selectView(String no) {
			MVCDiaryDTO dto=new MVCDiaryDTO(); // dto생성
			String query="select * from mvcdiary where no=?"; // no로 검색
			try {
				psmt=con.prepareStatement(query);
				psmt.setString(1, no);
				rs=psmt.executeQuery();
				if(rs.next()) {
					dto.setNo(rs.getString(1));
					dto.setTitle(rs.getString(2));
					dto.setContent(rs.getString(3));
					dto.setWeather(rs.getString(4));
					dto.setPostdate(rs.getDate(5));
					dto.setOfile(rs.getString(6));
					dto.setSfile(rs.getString(7));
					dto.setDowncount(rs.getInt(8));
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			return dto; //dto리턴
		}
		
		//삭제
		public int deletePost(String no) {
			int result=0;
			try {
				String query="delete from mvcdiary where no=?";
				psmt=con.prepareStatement(query);
				psmt.setString(1, no);
				result=psmt.executeUpdate();//영향을 받은 행의 수 저장
			}catch(Exception e) {
				e.printStackTrace();
			}
			return result;
		}
		
		//수정
		public int updatePost(MVCDiaryDTO dto) {
			int result=0;
			try {
				String query="update mvcdiary set title=?,content=?,weather=?,ofile=?,sfile=? "
						+ " where no=? ";
				psmt=con.prepareStatement(query);
				psmt.setString(1,dto.getTitle());
				psmt.setString(2,dto.getContent());
				psmt.setString(3,dto.getWeather());
				psmt.setString(4,dto.getOfile());
				psmt.setString(5,dto.getSfile());
				psmt.setString(6,dto.getNo());
		
				result=psmt.executeUpdate(); //영향을 받은 행의 수 저장
			}catch(Exception e) {
				e.printStackTrace();
			}
			return result;
		}
}

