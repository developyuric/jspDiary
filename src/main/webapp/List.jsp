<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">

<title>MVC Diary</title>
<style>
	*{margin:0;}
    body {
  		font-family: "Caveat", cursive;
        font-size:20px;
        background: #F4DECB;
        margin: 0;
        padding: 0;
        position:relative;
        justify-content: flex-start;
    }
    h2 {
        text-align: center;
        height:250px;
    }
    h2 img{
    	width:500px;
    	margin-top:10px;
    }
    .container {
        display: flex;
        flex-wrap: wrap;
        justify-content: center;
        gap: 20px;
        padding: 20px 50px;
    }
    .card {
    	background-image: url('/img/bg3.png') !important;
    	background-size:cover !important;
    	background-repeat:no-repeat !important;
        background: linear-gradient(135deg, #ffffff, #f3f3f3);
        width: 16%;
        border-radius: 15px;
        box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1);
        overflow: hidden;
        transition: transform 0.3s ease, box-shadow 0.3s ease;
        height:350px;
    }
    .card:hover {
        transform: translateY(-10px);
        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
    }
    .card-header {
        padding: 15px;
        font-size: 1.3em;
        color: #BF5B16;
        text-align: center;
        border-top-left-radius: 15px;
        border-top-right-radius: 15px;
        height:20px;
        width:76%;
        overflow:hidden;
    }
    .card-header a {
        text-decoration: none;
        color: inherit;
    }
    
    .content{
    	height:150px !important;
    	width:100% !important;
		overflow:hidden;
        color: #E8660C;
    }
    .card-content {
        padding: 10px;
        line-height: 1.2;
        overflow:hidden;
    }
    .card-content p {
        margin: 0 0 15px 0;
    }
    .card-content .weather, .card-content .date, .content {
        font-size: 0.9em;
        width:100%;
        height:25px;
        overflow:hidden;
    }
    .weather, .date{
    	color:#BF5B16;
    }
    
    .card-footer {
        padding-bottom: 15px;
        text-align: center;
        border-bottom-left-radius: 15px;
        border-bottom-right-radius: 15px;
        height:5px;
    }
    .card-footer a {
        padding: 5px 10px;
        background-color: #EDB99F;
        color: white;
        border-radius: 50%;
        text-decoration: none;
        font-size: 0.9em;
        transition: background-color 0.3s ease;
        position:relative;
        bottom:6px;
    }
    .card-footer a:hover {
        background-color: #AB6448;
    }
    
	/* Select ***********************************************************/
	.custom-select-wrapper {
	    position: relative;
	    display: inline;
	    margin-left:35%;
	}
	.custom-select {
		position: relative;
		display: inline-block;
		padding: 8px 10px 8px 16px;
		margin-bottom:20px;
		margin-left:10%;
		font-size: 14px;
		border-radius:3px;
	}
	
	.custom-select2{
		position:relative;
		display:inline-block;
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1), inset 0 0 10px rgba(251, 207, 208, 0.6);
	}
	.searchcontext, .searchbtn{
		padding:8px;
		margin-left:-5.5px;
		font-size:18px;
		color: rgba(118, 0, 19, 0.9);
		border-radius:3px;
		font-family: "Caveat", cursive;
	}
	.searchcontext{
		border:1px solid #D89DA0 !important;
	}
	.searchcontext:focus{
		outline:none;
		border:2px solid #E8660C !important;
	}
	
	.custom-select, .searchbtn{
		background: linear-gradient(145deg, rgba(248, 161, 164, 0.2), rgba(251, 207, 208, 0.2)); 
		color: rgba(118, 0, 19, 0.9); 
		border: 1px solid rgba(244, 115, 120, 0.6);
		box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1), inset 0 0 10px rgba(251, 207, 208, 0.6);
		cursor: pointer;
		transition: background 0.1s ease; 
	}
	
	.searchcontext:active, .searchcontext:focus{
		text-decoration:none !important;
		background-color:#F3EFE4;
	}
	
	.custom-select:hover, .searchbtn:hover{
		/* background: linear-gradient(275deg, #D89DA0, #FFDB58);  */
		background-color:#D89DA0
	}
	 
	.custom-select-trigger {
	    display: flex;
	    align-items: center;
	    text-align:center;
	    justify-content: space-between;
	    width:140px;
	    font-size:18px;
	}
	
	.custom-options {
	    display: none;
	    position: absolute;
	    align-item:center;
	    top: 100%;
	    left: 0;
	    right: 0;
	    padding-left:10px;
	    background: #FFF;
	    border: 1px solid #ddd;
	    box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
	    z-index: 1000;
	    font-size:22px;
	}
	
	.custom-option {
	    padding: 10px;
	    display: flex;
	    border-bottom: 2.5px solid #ddd; 
	    cursor: pointer;
	}
	
	.custom-option:last-child {
	    border-bottom: none;
	}
	
	.custom-option:hover {
	    background: #D89DA0; /* 호버 시 배경색 */
	    color: #FFF; /* 호버 시 글자색 */
	}

	.custom-option img {
	    display: none;
	}
	.dropdown-icon{
		width:20px;
		height:20px;
	}
    
    /* Paging **********************************/
    .pagination {
	    text-align: center;
	    margin: 30px;
	}
	.page-link {
	    padding: 10px 25px;
	    color: #590310;
	    margin: 0;
	    text-decoration:none;
	}
	
	.page-link:hover {
	    border: 1px solid #0E6B2A; 
	    border-radius: 50%;
	    padding:3px 10px;
	    overflow:hidden;
	}
	
	.page-active {
	    background-color: #F3F1E7; 
	    padding: 3px 10px;
	    color: #590310;
	    border-radius:50%; 
	}
	
	/* Vertical line *********************************************/
    .vertical-line {
        position: absolute;
        top:-9px;
        height:270px;
        right: 140px;
        width: 2px;
        background-color: #8E4752;
    }
    
    /* Register btn ***********************************************************/
    .write-btn {
        text-align: center;
    }
    .write-btn button {
    	position: absolute;
        /* top: 112px;
        right: 100px; */
        padding: 10px 20px;
        background-color: #D89DA0;
        color: white;
        border: none;
        border-radius: 3px;
        cursor: pointer;
        font-size: 1em;
        transform: translateY(-50%) rotate(90deg);
        font-family: "Caveat", cursive;
        letter-spacing:1px;
    }
    .write-btn button:hover {
        background-color: #DFCBC7;
        color: #8E4752;
        border:1px solid #8E4752;
        transform: translate(20px,-50%) rotate(90deg);
        transition: transform 0.5s ease;
        overflow:hidden;
    }
    .write-btn .cover {
    	right:80px;
    	top:90px;
    }
    
    .write-btn .main{
    	right:90px;
    	top:160px;
    	color: #8E4752;
        background-color: #DFCBC7;
        border:1px solid #8E4752;
    }
    .write-btn .main:hover{
    	background-color: #D89DA0;
        color: white;
    }
	.write-btn .register{
    	right:90px;
    	top:240px;
	}

    /* Responsive Layout */
    @media (max-width:950px){
    	.custom-select{
	    	margin-left:200px;
	    }
    }
    @media (max-width:830px){
    	.custom-select{
	    	margin-left:100px;
	    }
    }
    
    @media (max-width: 768px) {
        .container {
            flex-direction: column;
            align-items: center;
        }
        .pagination {
	        flex-direction: column;
	    }
	    .pagination a {
	        width: 100%; 
	        margin: 5px 0; /* 수직 간격 조정 */
	    }
	    .custom-select{
	    	margin-left:50px;
	    }
    }
</style>
</head>

<body>
    <div class="vertical-line"></div>
    
    <!-- write btn -->
    <div class="write-btn">
        <button class="cover" type="button" onclick="location.href='/index.jsp'">Cover</button>
        <button class="main" type="button" onclick="location.href='/list.do'">Main</button>
        <button class="register" type="button" onclick="location.href='/write.do'">Register</button>
    </div>

    <h2><img src="/img/Journal-Main.png" alt="Yuri's Journal"></h2>
    
    
    <!-- Searchform ------------------------------------------------------>
	<div class="custom-select-wrapper">
        <form method="get">
	   		<div class="custom-select">
	            <div class="custom-select-trigger">Select Category
		            <img src="/img/dropdownbtn.png" alt="dropdown_icon" class="dropdown-icon">
		        </div>
		        <div class="custom-options">
		            <div class="custom-option" data-value="title">Title</div>
		            <div class="custom-option" data-value="content">Content</div>
		        </div>
	            <select name="searchField" id="category-select" style="display:none;">
	            	<option value="" selected>None selected</option>
	                <option value="title">Title</option>
	                <option value="content">Content</option>
	            </select>
	         </div>
	         <div class="custom-select2" >
		         <input class="searchcontext" type="text" name="searchWord" placeholder="Enter a search term">
		         <input class="searchbtn" type="submit" value="Search">            
	         </div>
        </form>
    </div>
    <!-- Searchform.end -->

    <!-- Diary card list -->
    <div class="container">
        <c:choose>
            <c:when test="${empty diaryLists}">
                <p>No diary entries found</p>
            </c:when>
            <c:otherwise>
                <c:forEach items="${diaryLists}" var="row" varStatus="loop">
                    <div class="card">
                        <div class="card-header">
                            <a href="/view.do?no=${row.no}">${row.title}</a>
                        </div>
                        <div class="card-content">
                            <p class="content">${row.content}</p>
                            <p class="weather">Weather: ${row.weather}</p>
                            <p class="date">Postdate: ${row.postdate}</p>
                        </div>
                        <div class="card-footer">
                            <c:if test="${not empty row.ofile}">
                                <a href="/download.do?ofile=${row.ofile}&sfile=${row.sfile}&no=${row.no}">Download</a>
                            </c:if>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
    <!-- End CardList -->

    <!-- Pagination -->
    <div class="pagination" >
        ${map.pagingImg} 
    </div>
    

    
    
    
    <!-- dropdown -->
    <script>
	    const selectTrigger = document.querySelector('.custom-select-trigger');
	    const customOptions = document.querySelector('.custom-options');
	    const hiddenSelect = document.getElementById('category-select');
	
	    selectTrigger.addEventListener('click', function() {
	        customOptions.style.display = customOptions.style.display === 'block' ? 'none' : 'block';
	    });
	
	    document.querySelectorAll('.custom-option').forEach(function(option) {
	        option.addEventListener('click', function() {
	            const value = this.getAttribute('data-value');
	            selectTrigger.innerHTML = this.innerHTML + '<img src="/img/dropdownbtn.png" alt="dropdown_icon" class="dropdown-icon" style="width:15px; height:15px;">';
	            hiddenSelect.value = value;
	            customOptions.style.display = 'none';
	        });
	    });
	
	    document.addEventListener('click', function(e) {
	        if (!e.target.closest('.custom-select')) {
	            customOptions.style.display = 'none';
	        }
	    });
    </script>
</body>
</html>
