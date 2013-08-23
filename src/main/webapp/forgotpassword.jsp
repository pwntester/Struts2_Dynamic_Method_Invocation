<?xml version="1.0" encoding="ISO-8859-1" ?>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
<title>Forgot Password</title>
</head>
<body>
<h3>Forgot Your Password?</h3>

<p>Enter your username below to have your password sent to the email address
associated with your username.</p>

<s:form action="recoverpassword">

 	  <s:textfield name="username" label="Username" />

 	  
   	  <s:submit/>
   	  
</s:form>	
 
</body>
</html>