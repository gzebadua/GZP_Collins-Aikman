<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="releaseDetails.aspx.vb" Inherits="Sphynx.releaseDetails" %>

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
        
		<asp:LinkButton id="goBack" style="z-index: 1001; left: 632px; position: absolute; top: 128px" runat="server"
		Width="137px" CssClass="labelright"></asp:LinkButton>
		<asp:Label id="lblPage" style="z-index: 111; left: 16px; position: absolute; top: 136px" runat="server"
		Width="560px" Font-Bold="True" CssClass="largelabel"></asp:Label>
		<asp:Label id="lblTracking" style="z-index: 106; left: 360px; position: absolute; top: 176px"
		runat="server" Width="198px" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="True" ForeColor="White">lblTracking</asp:Label>
		<asp:Label id="lblReleaseInfo" style="z-index: 104; left: 16px; position: absolute; top: 168px"
		runat="server" Width="264px" BackColor="DarkBlue" Font-Names="Verdana" Font-Size="X-Small" Font-Bold="True" ForeColor="White">lblReleaseInfo</asp:Label>
		
		<asp:Panel id="Panel2" style="z-index: 105; left: 16px; position: absolute; top: 184px" runat="server"
		Width="326px" Height="52px" BackColor="Lavender" BorderStyle="Solid" BorderColor="DarkBlue" BorderWidth="2px">&nbsp; 
    
            <asp:Label id="lblReleaseNumber" runat="server" Font-Bold="True" Font-Size="X-Small">lblReleaseNumber</asp:Label><br />&nbsp; 
            <asp:Label id="lblRequestingPlant" runat="server" Font-Size="XX-Small">lblRequestingPlant</asp:Label><br />&nbsp; 
            <asp:Label id="lblRequestedVendor" runat="server" Font-Size="XX-Small">lblRequestedVendor</asp:Label>
            
        </asp:Panel>
        
        <asp:Panel id="Panel3" style="z-index: 107; left: 360px; position: absolute; top: 192px" runat="server"
		Width="317px" Height="29px">
	
			<asp:Label id="lblPublisher" runat="server" Height="15px" Width="406px" Font-Size="XX-Small"
			BackColor="Lavender" BorderStyle="Solid" BorderWidth="1px" BorderColor="Navy">lblPublisher</asp:Label>
			<asp:Label id="lblViewer" runat="server" Visible="False" Height="14px" Width="406px" Font-Size="XX-Small"
			BackColor="Lavender" BorderStyle="Solid" BorderWidth="1px" BorderColor="Navy">lblViewer</asp:Label>
			<asp:Label id="lblACKer" runat="server" Visible="False" Height="15px" Width="406px" Font-Size="XX-Small"
			BackColor="Lavender" BorderStyle="Solid" BorderWidth="1px" BorderColor="Navy">lblACKer</asp:Label>
				
		</asp:Panel>
		
		<asp:Panel id="Panel4" style="z-index: 108; left: 8px; position: absolute; top: 248px" runat="server"
		Width="758px" Height="174px">
			
			<asp:DataGrid id="dgDetails" runat="server" Width="758px" Font-Size="XX-Small" Font-Names="Verdana"
			DataKeyField="releaseDetailsID" AutoGenerateColumns="False">
				<AlternatingItemStyle BackColor="Lavender"></AlternatingItemStyle>
				<HeaderStyle Font-Bold="True" HorizontalAlign="center" ForeColor="White" BackColor="Navy"></HeaderStyle>
				<Columns>
					<asp:BoundColumn DataField="partID" HeaderText="dgCAPartN">
						<HeaderStyle Width="100px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="vpartID" HeaderText="dgVPartN">
						<HeaderStyle Width="100px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="description" HeaderText="dgDescription">
						<HeaderStyle Width="180px"></HeaderStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="units" HeaderText="dgUnits">
						<HeaderStyle Width="50px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
					</asp:BoundColumn>
					<asp:BoundColumn DataField="quantity" HeaderText="dgQty">
						<HeaderStyle Width="50px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
					</asp:BoundColumn>
					<asp:TemplateColumn>
						<HeaderStyle Width="20px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
						<ItemTemplate>
							<asp:ImageButton id=ImageButton3 runat="server" ImageUrl="images/forecastIcon.gif" CommandName="showForecast" CommandArgument='<%# DataBinder.Eval(Container.DataItem, "partID") %>'>
							</asp:ImageButton>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:BoundColumn DataField="dueDate" HeaderText="dgDate" DataFormatString="{0:MM-dd-yyyy hh:mm}">
						<HeaderStyle Width="75px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
					</asp:BoundColumn>
					<asp:TemplateColumn>
						<HeaderStyle Width="30px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
						<ItemTemplate>
							<asp:CheckBox id="chkAccept" runat="server"></asp:CheckBox>
						</ItemTemplate>
					</asp:TemplateColumn>
					<asp:TemplateColumn>
						<HeaderStyle Width="150px"></HeaderStyle>
						<ItemStyle HorizontalAlign="center"></ItemStyle>
						<ItemTemplate>
							<asp:TextBox id="txtComments" runat="server" Visible="False" Height="18px" Width="149px" Font-Size="XX-Small"
								BorderStyle="Solid" BorderWidth="1px" MaxLength="300"></asp:TextBox>
						</ItemTemplate>
					</asp:TemplateColumn>
				</Columns>
			</asp:DataGrid>
			
			<div style="width: 758px; position: relative; height: 55px">
				
				<asp:Panel id="Panel5" style="z-index: 101; left: 488px; position: absolute; top: 6px" runat="server"
				Width="267px">
				
					<center>
						<asp:Button id="btnACK" runat="server" Height="18px" Width="266px" CssClass="btn" Font-Size="XX-Small"
						Font-Names="Verdana" BackColor="#C0C0FF" BorderStyle="Solid" Text="btnACK" BorderWidth="1px"></asp:Button>
						<asp:Button id="btnComment" runat="server" Visible="False" Height="18px" Width="266px" CssClass="btn"
						Font-Size="XX-Small" Font-Names="Verdana" BackColor="#C0C0FF" BorderStyle="Solid" Text="btnComment"
						BorderWidth="1px"></asp:Button>
					</center>
				
				</asp:Panel>
				
			</div >
			
			<asp:Panel id="Panel6" runat="server" Height="6px" Width="200px" BorderStyle="Solid" BorderWidth="1px"
			BorderColor="Navy">
				
				<center>
				    <img src="images/excelDoc.jpg" alt="" />
					<asp:HyperLink id="hplGetExcelDoc" runat="server" Font-Size="X-Small" Font-Names="Verdana">hplGetExcelDoc</asp:HyperLink>
				</center>
				
			</asp:Panel>
		</asp:Panel>
		
		<asp:Panel id="pnlForecast" style="z-index: 109; left: 504px; position: absolute; top: 240px"
		runat="server" Width="264px" BorderStyle="Solid" BorderColor="Green" BorderWidth="2px" HorizontalAlign="center"
		BackColor="Honeydew">
		
			<center>&nbsp;</center>
			<center>
				<asp:Label id="lblNothing" runat="server" Visible="False" CssClass="largelabel" ForeColor="DarkGreen"
				Font-Bold="True" Font-Size="XX-Small" Font-Names="Verdana"></asp:Label>
			</center>
			<center>&nbsp;</center>
			<center>
				<asp:DataGrid id="dgForecasts" runat="server" Width="224px" Font-Size="XX-Small" Font-Names="Verdana"
				DataKeyField="partId" AutoGenerateColumns="False">
					<AlternatingItemStyle BackColor="Lavender"></AlternatingItemStyle>
					<ItemStyle HorizontalAlign="center" BackColor="White"></ItemStyle>
					<HeaderStyle Font-Bold="True" HorizontalAlign="center" ForeColor="White" BackColor="Navy"></HeaderStyle>
					<Columns>
						<asp:BoundColumn DataField="date" HeaderText="Fecha" DataFormatString="{0:MM-dd-yyyy hh:mm}">
							<HeaderStyle HorizontalAlign="center" Width="125px"></HeaderStyle>
						</asp:BoundColumn>
						<asp:BoundColumn DataField="quantity" HeaderText="Cantidad">
							<HeaderStyle Width="50px"></HeaderStyle>
						</asp:BoundColumn>
					</Columns>
				</asp:DataGrid>
			</center>
			<center>&nbsp;</center>
			<center>
				<asp:Button id="btnCloseForecast" runat="server" Height="16px" Width="177px" Font-Size="XX-Small"
				BorderStyle="Solid" Text="btnCloseForecast" BorderWidth="1px" BorderColor="Green"></asp:Button>
			</center>
			<center></center>
		
		</asp:Panel>
				
		<asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
		    <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0"></asp:Label>
			<asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"></asp:HyperLink>
		</asp:Panel>
		
    </form>
</body>
</html>
