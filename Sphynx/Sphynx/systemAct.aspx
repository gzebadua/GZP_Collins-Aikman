<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="systemAct.aspx.vb" Inherits="Sphynx.systemAct" %>

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
		
		<asp:Panel id="pnlSystemStatusIntro" runat="server" style="z-index: 100; top: 157px; left: 21px; position: absolute; ">
		    <asp:Label id="lblSystemStatutIntro" runat="server" Height="6px" Width="240px" CssClass="labelcentered">lblSystemStatutIntro</asp:Label>
		</asp:Panel>
		
		<asp:Panel id="pnlSystemStatus" runat="server" style="z-index: 100; top: 175px; left: 20px; position: absolute; ">
		    <asp:Label id="lblSysStat" runat="server" Height="21px" Width="243px" CssClass="labelcentered" Font-Size="X-Small" BackColor="Yellow" BorderStyle="Solid" ForeColor="Black" Font-Bold="True" BorderColor="Gold" BorderWidth="2px">lblSysStat</asp:Label>
		</asp:Panel>
		
		<asp:Panel id="pnlServerTime" runat="server" style="z-index: 100; top: 128px; left: 8px; position: absolute;">
            <asp:Label id="lblServerTime" runat="server" Width="761px" CssClass="tableheader" Font-Size="X-Small" BackColor="White" BorderStyle="Solid" ForeColor="#0000C0" Font-Bold="True" BorderColor="#FF8000" BorderWidth="2px">lblServerTime</asp:Label>    		    
		</asp:Panel>
		
		<asp:Panel id="pnpSystemStatusSince" runat="server" style="z-index: 100; top: 197px; left: 40px; position: absolute; ">
		    <asp:Label id="lblStatusSince" runat="server" Height="6px" Width="204px" CssClass="labelcentered" Font-Size="XX-Small">lblStatusSince</asp:Label>
		</asp:Panel>
		
		<asp:Panel id="pnlActivateDeactivate" runat="server" style="z-index: 100; top: 223px; left: 39px; position: absolute;">
		    <asp:Button id="btnActDeact" runat="server" Width="209px" BorderStyle="Solid" BorderColor="Black" BorderWidth="2px" Text="lblActDeact"></asp:Button>
		</asp:Panel>
		
		<asp:Panel id="pnlShutdownInfo" runat="server" style="z-index: 100; top: 161px; left: 322px; position: absolute; "
		Visible="False" Height="67px" Width="358px" BackColor="#FFC0C0" BorderStyle="Solid" BorderColor="Red" BorderWidth="2px">
			
			<div align="center">
				<asp:Label id="lblURAbout" runat="server" Font-Size="Small" Font-Bold="True" ForeColor="Red">lblURAbout</asp:Label>
				<br />
				<br />
				<asp:Label id="lblIfUWish" runat="server" Font-Size="XX-Small">lblIfUWish</asp:Label>
				<br />
				<asp:TextBox id="txtWhenWBB" runat="server" Width="115px" Height="20px" Font-Size="XX-Small" MaxLength="19"></asp:TextBox>
			</div >
			<br />
			<div align="right">
			    <asp:Button id="btnDoShut" runat="server" Text="cmdDoShut"></asp:Button>
			    &nbsp;&nbsp;
			</div >
		</asp:Panel>
			
	    <asp:Panel id="pnlModulesHeader" runat="server" style="z-index: 100; top: 285px; left: 8px; position: absolute; ">
		    <asp:Label id="lblIModStat" runat="server" Width="765px" Font-Size="X-Small" BackColor="Navy" ForeColor="White" Font-Bold="True">lblIModStat</asp:Label>
		</asp:Panel>
			
		<asp:Panel id="pnlModulesDescription" runat="server" style="z-index: 100; top: 309px; left: 34px; position: absolute;">
		    <asp:Label id="lblDirIMod" runat="server" Width="724px" Font-Size="XX-Small">lblDirIMod</asp:Label>
		</asp:Panel>
			
		<asp:Panel id="pnlModulesStatus" runat="server" style="z-index: 100; left: 33px; position: absolute; top: 341px" Height="158px" Width="346px">
			<asp:Repeater id="rptModulesStatus" runat="server">
				<HeaderTemplate>
					<table cellpadding="0" cellspacing="0">
				</HeaderTemplate>
				<ItemTemplate>
					<tr>
						<td valign="top">
							<asp:Image id="imgModStat" runat="server"></asp:Image>&nbsp;
						</td>
						<td>
							<asp:Button id="cmdModTitle" runat="server" Height="20px" Width="290px" Font-Size="XX-Small" BorderStyle="Solid" BorderColor="Black" BorderWidth="1px" Text="cmdModTitle" Font-Names="Verdana" CommandName="AD" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "moduleID") %>'></asp:Button>
							<asp:ImageButton id="ImageButton3" runat="server" ImageUrl="images/moreInfo.gif" CommandName="showDetails"></asp:ImageButton>
							<br />
							<asp:Label id="lblModuleStatusAuthor" runat="server" Width="350px" Height="15px" Font-Size="XX-Small" Visible="False">lblModuleStatusAuthor</asp:Label>
						</td>
					</tr>
				</ItemTemplate>
				<FooterTemplate>
					</table>
				</FooterTemplate>
			</asp:Repeater>
		</asp:Panel>
			
		<asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
		    <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0"></asp:Label>
			<asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"></asp:HyperLink>
		</asp:Panel>
    
    </form>
</body>
</html>
