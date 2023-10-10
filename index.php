<?php
	include "conn3.php";
   	$aSQL = "
	
	SELECT answer_status, COUNT(answer_status) AS answer FROM t_quiz_answer
	GROUP BY answer_status
	ORDER BY answer_status desc
	
	";
	$aQResult=mysqli_query($connect, $aSQL);
?>

<?php
$script_name=trim($_SERVER["SCRIPT_NAME"]);
?>
<html>
<head>
	<title>Administrasi >> user</title>
	<LINK href="style2.css" type=text/css rel=STYLESHEET>
</head>

<body bgcolor="#D8D8D8">
<center>
<table align="center" border="0" cellpadding="0" cellspacing="1" bgcolor="#FFC68C" height="100%" width="100%">
<tr><td align="center" bgcolor="FFFFFF"  background="../../images/background.jpg" valign="top">
<br>
<font color="black" size="4" face="Verdana, Arial, Helvetica"><b>YOUR SCORE</b></font>
<br><br><br>
<table border="0" cellpadding="1" cellspacing="1" bgColor=#cccccc>
<?php
       $no=0;
	   $total=0;
       while ($aRow = mysqli_fetch_array($aQResult))
       {
	   $no++;
?>

	<tr class="isi">
		<td align="right"><font color="blue" size="4" face="Verdana, Arial, Helvetica"><?php print $aRow["answer_status"];?></font></td>
		<td align="right" width="50"><font color="blue" size="4" face="Verdana, Arial, Helvetica"><?php print $aRow["answer"];?></font></td>
	</tr>
	
<?php
}
?>

</table>

</body>
</html>
