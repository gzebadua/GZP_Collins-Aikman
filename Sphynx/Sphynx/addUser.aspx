<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="addUser.aspx.vb" Inherits="Sphynx.addUser" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="PageTitle"></title>
	<link href="StylesMain.css" type="text/css" rel="stylesheet" />
	<script type="text/javascript">
		var isIE4up = (document.all) ? 1 : 0;
		var isIE5 = (isIE4up && navigator.appVersion.indexOf("MSIE 5") != -1) ? 1 : 0;
		var isIE6 = (isIE4up && navigator.appVersion.indexOf("MSIE 6") != -1) ? 1 : 0;
		function validateInput(e, strPattern)
		{
			var chr = (isIE4up || isIE6 || isIE6)?e.keyCode:e.which;
			var ch = String.fromCharCode(chr);
     
			if (chr != 13 && chr !=  8 )
			{
				var re = new RegExp(strPattern);
     
				if (ch.search(re) == -1)
				{
					if(isIE4up || isIE6 || isIE6)
					{
						e.returnValue = false;
					}
					else
					{
						e.preventDefault();
					}
				}
			}
		}
	</script>
</head>
<body topmargin="0" leftmargin="0" background="images/background.png" onkeydown="if(event.keyCode == 13){document.getElementById('btnSave').click();}">
    
    <form id="form1" runat="server">
    
        <asp:Panel id="pnlImgHeader" runat="server" Height="114px" Width="100%" style="z-index: 101; top: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
		    <img src="images/header.png" alt="" />
		</asp:Panel>
		
		<asp:Panel id="pnlHeader" runat="server" style="z-index: 102; top: 88px; left: 0px; position: fixed; color:White;">
		    <asp:Label id="lblWelcomeName" runat="server" Font-Names="Verdana" Font-Size="Medium" Font-Bold="True" ForeColor="White">lblWelcomeName</asp:Label>
	        <br />
	        <asp:Label id="lblWelcomeCompany" runat="server" Font-Names="Verdana" Font-Size="XX-Small" Font-Bold="True" ForeColor="White">lblWelcomeCompany</asp:Label>
		</asp:Panel>
        
        <asp:Panel id="pnlFlags" runat="server" Height="32px" Width="152px" style="z-index: 102; top: 2px; left: 684px; position: fixed;">
		
			<p>
				<asp:Repeater id="rptFlags" runat="server">
					<HeaderTemplate>
						<table border="0" cellspacing="3" cellpadding="0" width="60">
							<tr>
					</HeaderTemplate>
					<ItemTemplate>
						        <td>
							        <asp:ImageButton id="ibtnFlag" runat="server" CommandName="DS" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "col") %>' ImageUrl='<%# "images/flags/" & DataBinder.Eval(Container.DataItem, "col") & ".png" %>'></asp:ImageButton>
						        </td>
					</ItemTemplate>
					<FooterTemplate>
						    </tr>
					    </table>
					</FooterTemplate>
				</asp:Repeater>
			</p>
				
		</asp:Panel>
		
		<asp:Panel id="pnlBtnShowMenu" runat="server" style="z-index: 102; top: 96px; left: 632px; position: absolute; ">
		    <asp:Button id="btnShowMenu" runat="server" CssClass="buttonmenu" BorderStyle="None" Text="btnShowMenu"></asp:Button>    
		</asp:Panel>
        
        <asp:Panel id="pnlMenu" runat="server" style="z-index: 120; top: 125px; left: 175px; position: absolute;" Visible="False">
			<asp:Repeater id="rptMenu" runat="server">
		        <HeaderTemplate>
			        <table width="400" border="0" cellpadding="0" cellspacing="0">
				        <tr>
					        <td width="16" height="16" style="background-image:url(images/menu/menu_r1_c1.png);"></td>
					        <td height="16" colspan="2" style="background-image:url(images/menu/menu_r1_c2.png);"></td>
					        <td width="16" height="16" style="background-image:url(images/menu/menu_r1_c3.png);"></td>
				        </tr>
		        </HeaderTemplate>
		        <ItemTemplate>
			            <tr>
				            <td width="15" rowspan="3" style="background-image:url(images/menu/menu_r2_c1.png);"></td>
				            <td width="34" rowspan="2" style="background-image:url(images/menu/menu_r2_c2.png);">
				                <center><a href='<%#DataBinder.Eval(Container.DataItem, "url")%>'><img src="images/menu/goarrow.png" style="border:0px;"></a></center>
				            </td>
				            <td width="331" style="background-image:url(images/menu/menu_r2_c2.png);">
				                <asp:LinkButton id="lblTitle" runat="server" CommandName="GoTo" CommandArgument='<%#DataBinder.Eval(Container.DataItem, "moduleID")%>' CssClass="linx"><%#DataBinder.Eval(Container.DataItem, "title")%></asp:LinkButton>
				            </td>
				            <td width="16" rowspan="3" style="background-image:url(images/menu/menu_r2_c3.png);"></td>
			            </tr>
			            <tr>
				            <td width="331" height="5" style="background-image:url(images/menu/menu_r2_c2.png);" class="menudesc">
				                <%#DataBinder.Eval(Container.DataItem, "description")%>
                            </td>
                        </tr>
                        <tr>
	                        <td height="5" style="background-image:url(images/menu/menu_r2_c2.png);"></td>
	                        <td height="5" style="background-image:url(images/menu/menu_r2_c2.png);"></td>
                        </tr>
                </ItemTemplate>
                <FooterTemplate>
			            <tr>
		                    <td width="16" height="16" style="background-image:url(images/menu/menu_r3_c1.png);"></td>
		                    <td height="16" colspan="2" style="background-image:url(images/menu/menu_r3_c2.png);"></td>
		                    <td width="16" height="16" style="background-image:url(images/menu/menu_r3_c3.png);"></td>
	                    </tr>
			        </table>
		        </FooterTemplate>
            </asp:Repeater>
		</asp:Panel>
		
		<asp:Panel id="pnlLogout" runat="server" style="z-index: 102; top: 59px; left: 722px; position: fixed;">
            <asp:HyperLink id="lblLogout" runat="server" CssClass="logoutlink" NavigateUrl="logout.aspx" ForeColor="White" >lblLogout</asp:HyperLink>
        </asp:Panel>
        
        <asp:Label id="lblPage" style="z-index: 136; left: 24px; position: absolute; top: 139px" runat="server"
        Width="629px" CssClass="largelabel" Font-Bold="True"></asp:Label>
		
		<asp:Label id="lblHeader" style="z-index: 111; left: 16px; position: absolute; top: 176px"
		runat="server" Height="18px" Width="392px" CssClass="headertable" BackColor="Navy" ForeColor="White"> lblHeader</asp:Label>
				
		<asp:Panel id="pnlMainInfo" style="z-index: 110; left: 16px; position: absolute; top: 192px"
		runat="server" Height="242px" Width="560px" BorderColor="Navy" BorderStyle="Solid" BorderWidth="2px"
		BackColor="Lavender">
		    
		    <asp:Label id="lblUsername" runat="server" Height="16px" Width="192px" CssClass="largelabel">lblUsername</asp:Label>
			<asp:TextBox id="txtUsername" runat="server" Width="192px" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px" 
			MaxLength="10" tabIndex="1" onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')">
			</asp:TextBox>
			<asp:RequiredFieldValidator id="FVUser" runat="server" CssClass="smalllabel" Font-Size="XX-Small" ControlToValidate="txtUsername">*</asp:RequiredFieldValidator>
		    <asp:Button id="btnVerify" runat="server" Height="20px" Width="128px" CausesValidation="False" Text="btnVerify" CssClass="btn"
			BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" Font-Size="XX-Small" BackColor="#C0C0FF"></asp:Button>
		    <br />
		    <br />
		    <asp:Label id="lblReal" runat="server" Height="16px" Width="192px" CssClass="largelabel">lblReal</asp:Label>
		    <asp:TextBox id="txtName" runat="server" Width="192px" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px" 
		    MaxLength="50" tabIndex="2" onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')">
		    </asp:TextBox>
		    <asp:RequiredFieldValidator id="FVReal" runat="server" CssClass="smalllabel" Font-Size="XX-Small" ControlToValidate="txtName">*</asp:RequiredFieldValidator>
		    <asp:Label id="lblUserExists" runat="server" Visible="False" Width="128px" CssClass="labelcentered" Font-Size="XX-Small"
			ForeColor="Red" Font-Bold="True"> lblUserExists</asp:Label>
		    <br />
		    <br />
		    <asp:Label id="lblPass" runat="server" Height="8px" Width="192px" CssClass="largelabel">lblPass</asp:Label>
		    <asp:TextBox id="txtPass" runat="server" Width="192px" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px" 
		    MaxLength="10" TextMode="Password" tabIndex="3" onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')"></asp:TextBox>
		    <asp:RequiredFieldValidator id="FVPass" runat="server" CssClass="smalllabel" Font-Size="XX-Small" ControlToValidate="txtPass">*</asp:RequiredFieldValidator>
		    <br />
		    <br />
		    <asp:Label id="lblConfirm" runat="server" Width="192px" CssClass="largelabel"> lblConfirm</asp:Label>
		    <asp:TextBox id="txtPass2" runat="server" Width="192px" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px" MaxLength="10" 
		    TextMode="Password" tabIndex="4" onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')">
		    </asp:TextBox>
		    <asp:RequiredFieldValidator id="FVConfirm1" runat="server" CssClass="smalllabel" Font-Size="XX-Small" ControlToValidate="txtPass2">*</asp:RequiredFieldValidator>
		    <asp:CompareValidator id="FVConfirm" runat="server" CssClass="smalllabel" Font-Size="XX-Small" ControlToValidate="txtPass2"
			ControlToCompare="txtPass">*</asp:CompareValidator>
		    <br />
		    <br />
		    <asp:Label id="lblEmail" runat="server" Height="16px" Width="192px" CssClass="largelabel">lblEmail</asp:Label>
		    <asp:TextBox id="txtEmail" runat="server" Width="192px" BorderColor="Navy" BorderStyle="Solid" BorderWidth="1px" MaxLength="50" tabIndex="5">
		    </asp:TextBox>
		    <asp:RegularExpressionValidator id="RSEmail" runat="server" CssClass="smalllabel" Font-Size="XX-Small" ControlToValidate="txtEmail" 
		    ValidationExpression="\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>
		    <br />
		    <br />
		    <asp:Label id="lblCompany" runat="server" Visible="False" Width="192px" CssClass="largelabel">lblCompany</asp:Label>
		    <asp:DropDownList id="ddlVendors" runat="server" Visible="False" Height="24px" Width="192px" tabIndex="6"></asp:DropDownList>
		    <br />
		    <br />
		</asp:Panel>
			
		<asp:Panel id="pnlErrors" style="z-index: 112; left: 597px; position: absolute; top: 232px" runat="server"
			Height="115px" Width="150px">
			<asp:Label id="lblErr1" runat="server" Width="150px" BorderStyle="Solid" BorderColor="Red"
				BorderWidth="1px" Font-Size="XX-Small" CssClass="labelcentered" ForeColor="Red" visible="False"></asp:Label>
			<br />
			<asp:Label id="lblErr2" runat="server" Width="150px" BorderStyle="Solid" BorderColor="Red"
				BorderWidth="1px" Font-Size="XX-Small" CssClass="labelcentered" ForeColor="Red" visible="False"></asp:Label>
			<br />
			<asp:Label id="lblErr3" runat="server" Width="150px" BorderStyle="Solid" BorderColor="Red"
				BorderWidth="1px" Font-Size="XX-Small" CssClass="labelcentered" ForeColor="Red" visible="False"></asp:Label>
		</asp:Panel>
			
		<asp:Button id="btnSave" style="z-index: 113; left: 592px; position: absolute; top: 176px" runat="server"
		Width="164px" Text="btnSave" CssClass="btn" BorderColor="MidnightBlue" BorderStyle="Solid"
		tabIndex="9"></asp:Button>
		
		<asp:Button id="btnCancel" style="z-index: 114; left: 592px; position: absolute; top: 200px"
		runat="server" Height="23px" Width="164px" CausesValidation="False" Text="btnCancel" CssClass="btn"
		BorderColor="DarkBlue" BorderStyle="Solid" tabIndex="10"></asp:Button>
		
		<asp:Label id="lblPlantTableHeader" style="z-index: 108; left: 16px; position: absolute; top: 456px" runat="server"
		Height="16px" Width="150px" CssClass="headertable" BackColor="Navy">lblPlant</asp:Label>
		
		<asp:Label id="lblModuleTableHeader" style="z-index: 135; left: 400px; position: absolute; top: 456px"
		runat="server" Height="16px" Width="150px" CssClass="headertable" BackColor="Navy">lblModule</asp:Label>
				
		<asp:Panel id="pnlCheckAllModuleCheckboxes" style="z-index: 105; left: 374px; position: absolute; top: 472px" runat="server"
		Width="47px" Height="24px" Visible="False">
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
            <asp:CheckBox id="chkCheckAllModuleCheckboxes" runat="server" Width="8px" Text=" " AutopostBack="True"></asp:CheckBox>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
        </asp:Panel>
        <asp:Panel id="pnlCheckAllPlantsCheckboxes" style="z-index: 109; left: 21px; position: absolute; top: 473px" runat="server"
			Width="334px" Height="32px" Visible="False"> 
			<asp:CheckBox id="chkCheckAllPlantsCheckboxes" runat="server" Text=" " AutopostBack="True"></asp:CheckBox>
		</asp:Panel>
		
		<asp:Panel id="pnlPlants" style="z-index: 107; left: 16px; position: absolute; top: 472px" runat="server"
		Width="320px" BorderColor="Navy" BorderStyle="Solid" BorderWidth="2px">
			
			<asp:DataGrid id="dgPlants" tabIndex="7" runat="server" Height="64px" Width="318px" AutoGenerateColumns="False"
			Font-Names="Verdana" DataKeyField="pfid" Font-Size="X-Small" HorizontalAlign="left">
				<AlternatingItemStyle BackColor="Lavender"></AlternatingItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="center" ForeColor="White" BackColor="#000066"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Width="15px"></HeaderStyle>
						<ItemTemplate>
							<asp:CheckBox id="chkPlant" runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn DataField="company" HeaderText="Compa&#241;&#237;a">
						<HeaderStyle HorizontalAlign="center" Width="25px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="facility" HeaderText="Planta">
						<HeaderStyle HorizontalAlign="center" Width="25px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="name" HeaderText="Nombre">
						<HeaderStyle HorizontalAlign="center" Width="253px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
					</asp:BoundColumn>
				</Columns>
			</asp:DataGrid>
		</asp:Panel>
		
		<asp:Panel id="pnlPermissions" style="z-index: 101; left: 400px; position: absolute; top: 472px" runat="server"
		Width="350px" BorderWidth="2px" BorderColor="Navy" BorderStyle="Solid">
			
			<asp:DataGrid id="dgPermissions" tabIndex="8" runat="server" Height="64px" Width="350px" 
			AutoGenerateColumns="False" Font-Names="Verdana" DataKeyField="moduleid" Font-Size="X-Small">
				<AlternatingItemStyle BackColor="Lavender"></AlternatingItemStyle>
				<ItemStyle HorizontalAlign="left"></ItemStyle>
				<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#000066"></HeaderStyle>
				<Columns>
					<asp:TemplateColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						<HeaderTemplate>
							<div align="center">&nbsp;</div >
						</HeaderTemplate>
						<ItemTemplate>
							<asp:CheckBox id="chkMod" runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn DataField="moduleID" HeaderText="ID">
						<HeaderStyle HorizontalAlign="Center"></HeaderStyle>
						<ItemStyle Font-Size="XX-Small" HorizontalAlign="Left"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="title" HeaderText="M&#243;dulo">
						<HeaderStyle HorizontalAlign="Center" Width="250px"></HeaderStyle>
						<ItemStyle HorizontalAlign="Left"></ItemStyle>
					</asp:BoundColumn>
				</Columns>
			</asp:DataGrid>
			
		</asp:Panel>
				
		<asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
		    <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0"></asp:Label>
			<asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"></asp:HyperLink>
		</asp:Panel>
		
    </form>
</body>
</html>
