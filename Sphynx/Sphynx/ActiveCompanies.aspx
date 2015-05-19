<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ActiveCompanies.aspx.vb" Inherits="Sphynx.ActiveCompanies" %>

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
        
        <asp:Panel id="pnlContent" runat="server" style="z-index: 106; left: 16px; position: absolute; top: 125px">
            
            <asp:RadioButtonList id="rblCompanias" runat="server" Width="296px" Height="32px" CssClass="LabelLarge" AutopostBack="True">
			    <asp:ListItem Value="1" Selected="True">Active Companies</asp:ListItem>
			    <asp:ListItem Value="0">Inactive Companies</asp:ListItem>
		    </asp:RadioButtonList>
		    <br />
		    <br />
		    <asp:DataGrid id="dgCompanies" runat="server" Width="280px" Height="105px" AutoGenerateColumns="False" DataKeyField="username">
			    <AlternatingItemStyle BackColor="Lavender"></AlternatingItemStyle>
			    <ItemStyle HorizontalAlign="Justify"></ItemStyle>
			    <HeaderStyle Font-Bold="True" HorizontalAlign="center" ForeColor="White" BackColor="#000066"></HeaderStyle>
			    <Columns>
				    <asp:BoundColumn Visible="False" DataField="username" HeaderText="ID"></asp:BoundColumn>
				    <asp:BoundColumn DataField="Usuario" HeaderText="Company"></asp:BoundColumn>
				    <asp:TemplateColumn HeaderText="Activar">
					    <HeaderStyle Width="10px"></HeaderStyle>
					    <ItemStyle HorizontalAlign="center"></ItemStyle>
					    <ItemTemplate>
						    <asp:CheckBox id="chkAD" runat="server"></asp:CheckBox>
					    </ItemTemplate>
				    </asp:TemplateColumn>
			    </Columns>
		    </asp:DataGrid>
					
        </asp:Panel>
        
        <asp:Panel id="pnlButtons" runat="server" style="z-index: 107; left: 312px; position: absolute; top: 195px">
            
            <asp:Label id="lblError" runat="server" Width="371px" Height="11px" CssClass="LabelLarge" ForeColor="Red">Label</asp:Label>
            <br />
            <br />
			<asp:Button id="btnActualizar" runat="server" Width="120px" Height="32px" CssClass="btn" Text="Actualizar" Visible="False"></asp:Button>
            
        </asp:Panel>
        		
		<asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
		    <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0"></asp:Label>
			<asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"></asp:HyperLink>
		</asp:Panel>
		
    </form>
</body>
</html>
