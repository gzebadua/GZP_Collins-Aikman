<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="displayUsers.aspx.vb" Inherits="Sphynx.displayUsers" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

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
<body topmargin="0" leftmargin="0">
    
    <form id="form1" runat="server">
    
    <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    
        <asp:UpdatePanel ID="updatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
            <ContentTemplate>
    
                <asp:Panel ID="pnlImgHeader" runat="server" Width="100%" style="z-index: 119; position: fixed; top: 0px; left: 0px; background-image:url('images/header2.png'); background-repeat:repeat-x;">
		            <asp:Image id="imgHeader" runat="server" Height="114px" ImageAlign="Top" ImageUrl="images/header.png"></asp:Image>
		        </asp:Panel>
        		
		        <asp:Panel id="pnlHeader" runat="server" style="z-index: 120; top: 88px; left: 0px; position: fixed; color:White;">
		            <asp:Label id="lblWelcomeName" runat="server" CssClass="largelabel" Font-Bold="True" ForeColor="White">lblWelcomeName</asp:Label>
	                <br />
	                <asp:Label id="lblWelcomeCompany" runat="server" CssClass="smalllabel" Font-Bold="True" ForeColor="White">lblWelcomeCompany</asp:Label>
		        </asp:Panel>
                
                <asp:Panel id="pnlFlags" runat="server" Height="32px" Width="152px" style="z-index: 120; top: 2px; left: 684px; position: fixed;">
        		
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
        		
		        <asp:Panel id="pnlBtnShowMenu" runat="server" style="z-index: 120; top: 90px; left: 632px; position: fixed; ">
		            <asp:Button id="btnShowMenu" runat="server" CssClass="buttonmenu" BorderStyle="None" Text="btnShowMenu"></asp:Button>    
		        </asp:Panel>
                
                <asp:Panel id="pnlMenu" runat="server" style="z-index: 120; top: 125px; left: 175px; position: absolute;" Visible="False">
			        <asp:Repeater id="rptMenu" runat="server">
		                <HeaderTemplate>
			                <table width="397" border="0" cellpadding="0" cellspacing="0">
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
				                        <center><a href='<%#DataBinder.Eval(Container.DataItem, "surl")%>'><img src="images/menu/goarrow.png" style="border:0px;" alt=""></a></center>
				                    </td>
				                    <td width="331" style="background-image:url(images/menu/menu_r2_c2.png);">
                                        <a href='<%#DataBinder.Eval(Container.DataItem, "surl")%>'>
                                            <asp:Label ID="Label1" runat="server" CssClass="linx" Text='<%#DataBinder.Eval(Container.DataItem, Session("preferredLanguage") & "_" & "title")%>'></asp:Label>
                                        </a>
                                        &nbsp;
                                        <asp:Label ID="lblActive" runat="server" CssClass="menudesc" Text='<%#If(DataBinder.Eval(Container.DataItem, "surl") = "#", DataBinder.Eval(Container.DataItem, Session("preferredLanguage")), "")%>'></asp:Label>
				                    </td>
				                    <td width="16" rowspan="3" style="background-image:url(images/menu/menu_r2_c3.png);"></td>
			                    </tr>
			                    <tr>
				                    <td width="331" height="5" style="background-image:url(images/menu/menu_r2_c2.png);" class="menudesc">
				                        <%#DataBinder.Eval(Container.DataItem, Session("preferredLanguage") & "_" & "description")%>
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
        		
		        <asp:Panel id="pnlLogout" runat="server" style="z-index: 120; top: 59px; left: 722px; position: fixed;">
                    <asp:LinkButton ID="lblLogout" runat="server" CssClass="logoutlink" ForeColor="White">lblLogout</asp:LinkButton>
                </asp:Panel>
                
                <asp:Button id="btnShowAll" style="z-index: 104; left: 16px; position: absolute; top: 136px"
		        runat="server" Width="152px" Font-Size="XX-Small" CssClass="button" Text="btnShowAll" BackColor="LightSteelBlue" BorderStyle="Solid" 
		        BorderColor="Navy" BorderWidth="1px" Height="25px"></asp:Button>
		        <asp:Button id="btnShowActive" style="z-index: 105; left: 168px; position: absolute; top: 136px"
		        runat="server" Width="152px" Font-Size="XX-Small" CssClass="button" Text="btnShowActive" BackColor="Lavender" 
		        BorderStyle="Solid" BorderColor="Navy" BorderWidth="1px" Height="25px"></asp:Button>
		        <asp:Button id="btnShowInactive" style="z-index: 106; left: 320px; position: absolute; top: 136px"
		        runat="server" Width="152px" Font-Size="XX-Small" CssClass="button" Text="btnShowInactive" BackColor="Lavender" 
		        BorderStyle="Solid" BorderColor="Navy" BorderWidth="1px" Height="25px"></asp:Button>
		        <asp:Button id="btnShowbyNP" style="z-index: 109; left: 472px; position: absolute; top: 136px"
		        runat="server" Width="152px" Height="25px" Text="btnShowbyNP" CssClass="button" Font-Size="XX-Small"
		        BackColor="Lavender" BorderStyle="Solid" BorderColor="Navy" BorderWidth="1px"></asp:Button>
		        <asp:Button id="btnAddUser" style="z-index: 107; left: 624px; position: absolute; top: 136px"
		        runat="server" Width="136px" Font-Size="XX-Small" CssClass="button" Text="btnAddUser" Height="25px" BackColor="Lavender" 
		        BorderStyle="Solid" BorderColor="Navy" BorderWidth="1px"></asp:Button>
		        <asp:Button id="btnUpdateStatus" style="z-index: 107; left: 760px; position: absolute; top: 136px"
		        runat="server" Width="136px" Font-Size="XX-Small" CssClass="button" Visible="False" Text="btnUpdateStatus" Height="25px" 
		        BackColor="Lavender" BorderStyle="Solid" BorderColor="Navy" BorderWidth="1px"></asp:Button>
		        
		        <div style="z-index: 107; top: 140px; left: 900px; position: absolute;">
					    
		            <center>
			            <asp:Label id="lblStatus" runat="server" Visible="False" Font-Size="XX-Small">lblStatus</asp:Label>
			        </center>
				    
	            </div >
        		
		        <asp:Panel id="pnlSetupUser" style="z-index: 110;  top: 162px; left: 16px; position: absolute;"
		        runat="server" Visible="False" Width="95%" BackColor="Transparent" BorderStyle="Solid" 
		        BorderWidth="2px" BorderColor="DarkRed" BackImageUrl="images/backgrounds/pixelMistyRose.png">
		            <br />
			        <center>&nbsp;</center>
			        <center>&nbsp;</center>
			        <center>&nbsp;</center>
			        <center>&nbsp;</center>
			        <center>&nbsp;</center>
			        <center>
				        <asp:Button id="btnSetupCA" runat="server" Width="200px" Height="40px" BorderColor="Maroon"
				        BorderStyle="Outset" CssClass="button" Text="btnSetupCA"></asp:Button>
			        </center>
			        <center>&nbsp;</center>
			        <center>
				        <asp:Button id="btnSetup" runat="server" Width="200px" Height="40px" BorderColor="Maroon"
				        BorderStyle="Outset" CssClass="button" Text="btnSetupVe"></asp:Button>
			        </center>
			        <center>&nbsp;</center>
			        <center>&nbsp;</center>
			        <center>&nbsp;</center>
		        </asp:Panel>
        		
		        <table id="Table1" style="z-index: 108; left: 16px; position: absolute; top: 160px; border-color:#000066;" cellspacing="1"
		        cellpadding="5" width="95%" border="1" >
		            <tr>
			            <td style="border-color:White;">
        			    
				            <div>
        				    
					            <asp:Panel id="pnlSearchName" runat="server" Visible="False" Height="65px">   
	                                <br />
	                                <asp:Label id="lblSearchByNamePart" runat="server" Font-Size="XX-Small">lblSearchByNamePart</asp:Label>
	                                &nbsp;
		                            <asp:TextBox id="txtNP" runat="server" Width="208px" MaxLength="50" 
		                            onkeypress="validateInput(event,'[a-zA-z0-9 .ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')">
		                            </asp:TextBox>
			                        &nbsp;
			                        <asp:Button id="btnGoSearch" runat="server" CssClass="button" Text="btnGoSearch" Font-Size="XX-Small"></asp:Button>
			                        <br />
		                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		                            <asp:Label id="lblErrorC" runat="server" ForeColor="Red" CssClass="smalllabel">lblErrorC</asp:Label>
		                            <br />
		                            <br />
		                            <br />
		                            <br />
		                        </asp:Panel>
        				        
                                <asp:GridView ID="gvUsers" runat="server" Font-Size="XX-Small" Font-Names="Verdana" 
					            DataKeyNames="susername" AllowSorting="true" AllowPaging="True" Pagesize="15">
					                <AlternatingRowStyle BackColor="Lavender"></AlternatingRowStyle>
						            <HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#000066"></HeaderStyle>
						            <RowStyle HorizontalAlign="center"></RowStyle>
						            <Columns>
						                <asp:TemplateField>
						                    <ItemStyle HorizontalAlign="center"></ItemStyle>
						                    <ItemTemplate>
									            <center>
										            <asp:CheckBox id="chkActive" runat="server" Enabled="false"></asp:CheckBox>
										        </center>
								            </ItemTemplate>
							            </asp:TemplateField>
							            <asp:TemplateField>
								            <ItemTemplate>
									            <asp:LinkButton id="lnkEdit" runat="server" Font-Size="XX-Small" Cssclass="hlink" CommandName="Edit"
										        CommandArgument="susername">lnkEdit</asp:LinkButton>
										        &nbsp; / &nbsp;
										        <asp:LinkButton id="lnkChangeStatus" runat="server" Font-Size="XX-Small" Cssclass="hlink" CommandName="ChangeStatus"
										        CommandArgument="susername">lnkChangeStatus</asp:LinkButton>
										    </ItemTemplate>
							            </asp:TemplateField>
							        </Columns>
							        <PagerSettings Mode="Numeric" />
                                </asp:GridView>
                                        					            					    
				            </div >
        				    
			            </td>
		            </tr>
	            </table>
        				
		        <asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
		            <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0"></asp:Label>
			        <asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"></asp:HyperLink>
		        </asp:Panel>
		
	        </ContentTemplate>
	    </asp:UpdatePanel>
		
    </form>
</body>
</html>
