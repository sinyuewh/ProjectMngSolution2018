<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Test1.aspx.cs" Inherits="OAWebSite2016.Test.Test1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>无标题页</title>
    <link rel="stylesheet" type="text/css" href="/EasyUI/themes/default/easyui.css" />
    <link rel="stylesheet" type="text/css" href="/EasyUI/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="/EasyUI/demo/demo.css" />

    <script type="text/javascript" src="/EasyUI/jquery.min.js"></script>

    <script type="text/javascript" src="/EasyUI/jquery.easyui.min.js"></script>

</head>
<body>
    <form id="form1" runat="server">
       
    
    <h2>ComboTree Actions</h2>
	
	<div style="margin:10px 0">
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="getValue()">GetValue</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="setValue()">SetValue</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="disable()">Disable</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" onclick="enable()">Enable</a>
	</div>
	<input id="cc" class="easyui-combotree" data-options="url:'/EasyUI/demo/combotree/tree_data1.json',method:'get',required:true" style="width:200px;">
	<script type="text/javascript">
		function getValue(){
			var val = $('#cc').combotree('getValue');
			alert(val);
		}
		function setValue(){
			$('#cc').combotree('setValue', '122');
		}
		function disable(){
			$('#cc').combotree('disable');
		}
		function enable(){
			$('#cc').combotree('enable');
		}
	</script>

    </form>
</body>
</html>
