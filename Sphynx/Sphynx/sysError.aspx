<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="sysError.aspx.vb" Inherits="Sphynx.sysError" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="PageTitle" runat="server">Sphynx :: System Error - Oops!</title>
    <link href="StylesMain.css" type="text/css" rel="stylesheet" />
</head>
<body topmargin="0" leftmargin="0" background="images/background.png">
    
    <form id="form1" runat="server">
    
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    
        <asp:UpdatePanel ID="updatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
            <ContentTemplate>
    
                <asp:Panel ID="pnlImgHeader" runat="server" Width="100%" style="z-index: 119; position: fixed; top: 0px; left: 0px; background-image:url('images/header2.png'); background-repeat:repeat-x;">
		            <asp:Image id="imgHeader" runat="server" Height="114px" ImageAlign="Top" ImageUrl="images/header.png"></asp:Image>
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
        		
		        <asp:Panel id="pnlLogout" runat="server" style="z-index: 120; top: 59px; left: 722px; position: fixed;">
                    <asp:LinkButton ID="lblLogout" runat="server" CssClass="logoutlink" ForeColor="White">lblLogout</asp:LinkButton>
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
        		
		        <asp:Panel id="pnlErrorImage" runat="server" style="z-index: 105; top: 144px; left: 24px; position: absolute; ">
                    <img src="images/bits.gif" alt="" />
                </asp:Panel>
        			
		        <asp:Panel id="pnlInfo" runat="server" style="z-index: 108; top: 136px; left: 144px; position: absolute; ">
                    
                    <asp:Label id="lblHeader" runat="server" Width="336px" Height="40px" Font-Names="Verdana" Font-Size="Medium" Font-Bold="true" ForeColor="Navy">lblServer</asp:Label>
                    <br />
			        <asp:Label id="lblError" runat="server" CssClass="largelabel">lblError</asp:Label>
			        <br />
			        <br />
			        <br />
			        <asp:Label id="lblErrorDescription" runat="server" Width="593px" CssClass="largelabel"></asp:Label>
        			
                </asp:Panel>
                
                <asp:Panel id="pnlLnkGoBack" runat="server" style="z-index: 107; top: 128px; left: 632px; position: absolute;">
                    <asp:HyperLink id="lnkGoBack" runat="server" Width="160px" Height="24px" NavigateUrl="javascript:history.back();" CssClass="hlink" Font-Size="X-Small"></asp:HyperLink>
                </asp:Panel>
        			
		        <asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
	                <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0"></asp:Label>
		            <asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"></asp:HyperLink>
	            </asp:Panel>
	            
	        </ContentTemplate>
	    </asp:UpdatePanel>
	    
    </form>
    
</body>
</html>
