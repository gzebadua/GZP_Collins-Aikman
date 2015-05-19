<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="sessionEnd.aspx.vb" Inherits="Sphynx.sessionEnd" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="PageTitle" runat="server">Sphynx :: Oops!</title>
    <meta http-equiv="refresh" content="2;URL=login.aspx" />
    <link href="StylesMain.css" type="text/css" rel="stylesheet" />
    <script src="AC_RunActiveContent.js" type="text/javascript"></script>
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
        		
		        <asp:Panel id="pnlAccessDeniedFlash" runat="server" style="z-index: 104; left: 7px; position: absolute; top: 125px">
                    
                    <script type="text/javascript">
                    AC_FL_RunContent( 'codebase','http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0','width','320','height','222','src','images/noright','quality','high','pluginspage','http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash','movie','images/noright' ); //end AC code
                    </script>
                    <noscript>
                        <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,28,0" width="320" height="222">
                            <param name="movie" value="images/noright.swf" />
                            <param name="quality" value="high" />
                            <embed src="images/noright.swf" quality="high" pluginspage="http://www.adobe.com/shockwave/download/download.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="320" height="222"></embed>
                        </object>
                    </noscript>
        			
                </asp:Panel>
        			
		        <asp:Panel id="pnlInfo" runat="server" style="z-index: 108; top: 136px; left: 344px; position: absolute; ">
                    
                    <asp:Label id="lblHeader" runat="server" Width="336px" Height="40px" Font-Names="Verdana" Font-Size="Medium" Font-Bold="true" ForeColor="Navy">lblHeader</asp:Label>
                    <br />
			        <asp:Label id="lblSessionMessage" runat="server" Width="405px" Height="51px" CssClass="largelabel"></asp:Label>
        			
                </asp:Panel>
                
                <asp:Panel id="pnlLnkToLogin" runat="server" style="z-index: 107; top: 320px; left: 616px; position: absolute;">
                    <asp:HyperLink id="lnkLogin" runat="server" Width="160px" Height="24px" NavigateUrl="login.aspx" CssClass="hlink" Font-Size="X-Small"></asp:HyperLink>
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
