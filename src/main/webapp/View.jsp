<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MVC Diary</title>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:ital,wght@0,100..700;1,100..700&family=PT+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

<style>
    body {
        background-image: url('/img/bg4.png') !important;
        background-size: cover !important;
        background-repeat: no-repeat !important;
        font-family: "Caveat", cursive;
        font-size: 20px;
        display: flex;
        justify-content: center;
        height: 90vh;
        position: relative;
    }
    h2 {
        position: absolute;
        text-align:center;
    }
    table {
        width: 80%;
        margin-top: 250px;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        position:relative;
    }
    td {
        font-family: "Caveat", cursive;
        font-size: 25px;
        padding-bottom: 20px;
        color: #E67B1F;
        vertical-align: top;
    }
    td:first-child{
    	color:#8E4752;
    }
    td:nth-child(3){
    	color:#8E4752;
    }
    
    
    .file-link {
        color: #8E4752;
        text-decoration: none;
        margin-left:20px;
    }
    .file-link:hover {
        color: #AB6448;
        text-decoration: underline;
    }
    .btn-group {
        text-align: center;
        margin-top: 210px;
       	left:270px;
        position:absolute;
    }
    .btn-group button {
        font-family: "Caveat", cursive;
        background-color: #E49978;
        padding: 6px 9px;
        margin-right: 8px;
        border: none;
        border-radius: 3px;
        color: white;
        font-size: 22px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .btn-group button:hover {
        border: 1px solid #D89DA0;
        color: #D89DA0;
        background-color: #EDEBDE;
        transform: translateY(-15px);
    	transition:transform 0.4s ease;
    	overflow:hidden !important;
    }
    
    
    /* Vertical line *********************************************/
    .vertical-line {
        position: absolute;
        top:-7px;
        height:240px;
        right: 140px;
        width: 2px;
        background-color: #8E4752;
    }
    
    /* Side btn ***********************************************************/
    .write-btn {
        text-align: center;
    }
    .write-btn button {
    	position: absolute;
        right: 100px; 
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
    	right:77px;
    	top:90px;
    }
    
    .write-btn .main{
    	right:86px;
    	top:172px;
    	color: #8E4752;
        background-color: #DFCBC7;
        border:1px solid #8E4752;
    }
    .write-btn .main:hover{
    	background-color: #D89DA0;
        color: white;
    }
</style>

</head>
<body>
	<h2><img src="/img/detail-title.png" alt="daily-journal"></h2>
    <div class="vertical-line"></div>
    
    <!-- write btn -->
    <div class="write-btn">
        <button class="cover" type="button" onclick="location.href='/index.jsp'">Cover</button>
        <button class="main" type="button" onclick="location.href='/list.do'">Main</button>
    </div>

    <table>
        <colgroup>
            <col width="10%">
            <col width="55%">
            <col width="10%">
            <col width="*">
        </colgroup>
        <tr>
            <td>#</td>
            <td>${dto.no}</td>
            <td>Creation Date</td>
            <td>${dto.postdate}</td>
        </tr>
        <tr>
            <td>Title</td>
            <td colspan="3">${dto.title}</td>
        </tr>
        <tr>
            <td>Content</td>
            <td colspan="3" style="height:100px;">${dto.content}</td>
        </tr>
        <tr>
            <td>Weather</td>
            <td colspan="3">${dto.weather}</td>
        </tr>
        <tr>
            <td>Attached File</td>
            <td >
                <c:if test="${not empty dto.ofile}">
                    ${dto.ofile} 
                    <a href="/download.do?ofile=${dto.ofile}&sfile=${dto.sfile}&no=${dto.no}" class="file-link">Download</a>
                </c:if>
            </td>
            <td>Download Count</td>
            <td>${dto.downcount}</td>
        </tr>
    </table>

    <div class="btn-group">
        <button type="button edit" onclick="location.href='/edit.do?no=${param.no}'">Edit</button>
        <button type="button delete" onclick="location.href='/delete.do?no=${param.no}'">Delete</button>
    </div>

</body>
</html>
