<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수정 일기</title>
<link href="https://fonts.googleapis.com/css2?family=Caveat:wght@400..700&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Josefin+Sans:ital,wght@0,100..700;1,100..700&family=PT+Sans:ital,wght@0,400;0,700;1,400;1,700&display=swap" rel="stylesheet">

<style>
    body {
        background-image: url('/img/bg3.png') !important;
        background-size:cover !important;
        background-repeat:no-repeat !important;
        font-family: "Caveat", cursive;
        font-size: 20px;
        display: flex;
        justify-content: center;
        height: 90vh;
        position:relative;
    }
    h2 {
        position:absolute;
        text-align: center;
        top: 30px;
    }
    h2 img{
    	width:430px;
    }
    form {
        position:absolute;
        top:230px;
        background: #F4DECB;
        padding: 20px;
        width: 70%;
        height:65vh;
        box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        border-radius: 10px;
    }
    table {
        width: 100%;
    }
    td {
        font-family: "Caveat", cursive !important;
        font-size:25px;
        padding-bottom:20px;
        color: #8E4752;
    }
    td:first-child{
    	width:12%;
    }
    input[type="text"], textarea {
        border:0px;
        font-family: "Josefin Sans", sans-serif;
        font-size:20px;
        font-weight:350;
        width: 95%;
        padding: 10px;
        border-radius: 5px;
        background: #F3F1E8;
        color: #555;
        outline:none !important;
    }
    input[type="text"]:focus, textarea:focus{
        outline:none;
        border: 1px solid #E8660C;
        background: #FFE7D7;
    
    }
    textarea {
        height: 280px;
        resize: none;
    }
    .file-input-container {
        display: flex;
        align-items: center;
    }
    .custom-file-label {
        font-family: "Josefin Sans", sans-serif;
        font-size: 20px;
        color: #D89DA0;
        margin-right: 20px;
    }
    
    .custom-file-button {
        padding: 5px 12px;
        background-color:#EDB59C;
        color: white;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s ease;
        font-size: 1em;
    }
    .custom-file-button:hover{
    	background-color: #E49978;
    }
    .file-name {
        font-family: "Caveat", cursive;
        font-size: 25px;
        color: #880015;
        margin-left:15px;
    }
   
    .btn-group {
        text-align: center;
        margin-top: 20px;
        padding-bottom:20px ;
    }
    
    .btn-group button{
        font-family: "Caveat", cursive;
        background-color:#E49978;
        padding: 10px 20px;
		margin-right:8px;
        border: none;
        border-radius: 48%;
        color: white;
        font-size: 22px;
        cursor: pointer;
        transition: background-color 0.3s ease;
    }
    .btn-group button:hover{
    	border: 1px solid #D89DA0;
    	color:#D89DA0;
    	background-color:#EDEBDE;
    }
    /* Hide original file input */
    #file {
        display: none;
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
        overflow:hidden;
    }
</style>

<script type="text/javascript">
    function validateForm(form) {
        if (form.title.value == "") {
            alert("Please enter the title");
            form.title.focus();
            return false;
        }
        if (form.content.value == "") {
            alert("Please enter the content");
            form.content.focus();
            return false;
        }
        if (form.weather.value == "") {
            alert("Please enter the weather");
            form.weather.focus();
            return false;
        }
     // check file size
        var inputFile = document.getElementById("file");
        var files = inputFile.files;       
        if(files.length > 0 && files[0].size > 15 * 1024 * 1024){
            alert("File size cannot exceed 15MB");
            return false;
        }
    }
    
    function handleFileSelect() {
        const fileInput = document.getElementById('file');
        const fileNameDisplay = document.getElementById('file-name');
        if (fileInput.files.length > 0) {
            fileNameDisplay.textContent = fileInput.files[0].name;
        } else {
            fileNameDisplay.textContent = "No file chosen";
        }
    }
</script>

</head>
<body>

    <h2><img src="/img/Edit-main.png" alt="daily-journal"></h2>
    <div class="vertical-line"></div>
    
    <!-- write btn -->
    <div class="write-btn">
        <button class="cover" type="button" onclick="location.href='/index.jsp'">Cover</button>
        <button class="main" type="button" onclick="location.href='/list.do'">Main</button>
    </div>
    
    
    <form name="writeFrm" method="post" enctype="multipart/form-data" onsubmit="return validateForm(this);">
        <input type="hidden" name="no" value="${dto.no}">
        <input type="hidden" name="prevOfile" value="${dto.ofile}">
        <input type="hidden" name="prevSfile" value="${dto.sfile}">

        <table>
            <tr>
                <td>Title</td>
                <td><input type="text" name="title" value="${dto.title}"></td>
            </tr>
            <tr>
                <td>Content</td>
                <td><textarea name="content">${dto.content}</textarea></td>
            </tr>
            <tr>
                <td>Weather</td>
                <td><input type="text" name="weather" value="${dto.weather}"></td>
            </tr>
            <tr>
                <td class="left">Attached File</td>
                <td>
                    <div class="file-input-container">
                        <label class="custom-file-button" for="file">Choose File</label>
                        <span id="file-name" class="file-name">No file chosen</span>
                        <input type="file" name="ofile" id="file" onchange="handleFileSelect()">
                    </div>
                </td>
            </tr>
            <tr>
                <td colspan="2" class="btn-group">
                    <button type="submit">Edit Complete</button>
                    <button type="reset">Undo</button>
                    <button type="button" onclick="location.href='/list.do'">Cancel Edit</button>
                </td>                
            </tr>
        </table>
    </form>

</body>
</html>
