<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="deleteOrigin.aspx.vb" Inherits="Sphynx.deleteOrigin" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="PageTitle"></title>
	<link href="StylesMain.css" type="text/css" rel="stylesheet" />
</head>
<body topmargin="0" leftmargin="0" background="images/background.png">
    
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
		
		<asp:Panel id="pnlLogout" runat="server" style="z-index: 102; top: 59px; left: 722px; position: fixed;">
            <asp:HyperLink id="lblLogout" runat="server" CssClass="logoutlink" NavigateUrl="logout.aspx" ForeColor="White" >lblLogout</asp:HyperLink>
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
		
		<asp:Panel id="pnlInstructions" runat="server" style="z-index: 100; top: 144px; left: 41px; position: absolute;">
		    <asp:Label id="lblAnnounce" runat="server" Width="632px">Select the user to erase his login at the system:</asp:Label>
		</asp:Panel>
				
		<asp:Panel id="pnlUsers" runat="server" style="z-index: 100; top: 179px; left: 52px; position: absolute;">
		    
		    <asp:DataGrid id="dgUsers" runat="server" Width="552px" AutoGenerateColumns="False" Font-Names="Verdana" 
		    Pagesize="15" AllowPaging="True" Font-Size="XX-Small" DataKeyField="username">
				<AlternatingItemStyle BackColor="Lavender"></AlternatingItemStyle>
				<HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#000066"></HeaderStyle>
				<Columns>
					<asp:BoundColumn DataField="username" HeaderText="Username">
						<HeaderStyle HorizontalAlign="center" Width="70px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="realName" HeaderText="Nombre de usuario">
						<HeaderStyle Width="220px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="name" HeaderText="Proveedor">
						<HeaderStyle Width="150px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="lastLogin" HeaderText="Last Login">
						<HeaderStyle Width="300px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:TemplateColumn>
						<HeaderStyle Width="100px"></HeaderStyle>
						<ItemTemplate>
							<asp:Button id="btnLogoff" runat="server" Font-Size="XX-Small" CssClass="button" CommandArgument="username" CommandName="Logoff"></asp:Button>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
				<PagerStyle HorizontalAlign="center" ForeColor="White" BackColor="#000066" Mode="NumericPages"></PagerStyle>
			</asp:DataGrid>
			
		</asp:Panel>
		
		<asp:Panel id="pnlLnkGoBack" runat="server" style="z-index: 100; top: 128px; left: 632px; position: absolute;">
            <asp:LinkButton id="goBack" runat="server" Width="137px" CssClass="labelright"></asp:LinkButton>
        </asp:Panel>
					
		<asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
		    <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0"></asp:Label>
			<asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"></asp:HyperLink>
		</asp:Panel>
		
    </form>
</body>
</html>
