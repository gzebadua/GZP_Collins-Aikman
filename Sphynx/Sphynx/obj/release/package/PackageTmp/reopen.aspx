<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="reopen.aspx.vb" Inherits="Sphynx.reopen" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
    <title runat="server" id="PageTitle">Login :: Collins & Aikman's Sphynx</title>
    <link href="StylesMain.css" type="text/css" rel="stylesheet" />
    <script type="text/javascript">
        var isIE4up = (document.all) ? 1 : 0;
        var isIE5 = (isIE4up && navigator.appVersion.indexOf("MSIE 5") != -1) ? 1 : 0;
        var isIE6 = (isIE4up && navigator.appVersion.indexOf("MSIE 6") != -1) ? 1 : 0;
        function validateInput(e, strPattern) {
            var chr = (isIE4up || isIE6 || isIE6) ? e.keyCode : e.which;
            var ch = String.fromCharCode(chr);

            if (chr != 13 && chr != 8) {
                var re = new RegExp(strPattern);

                if (ch.search(re) == -1) {
                    if (isIE4up || isIE6 || isIE6) {
                        e.returnValue = false;
                    }else {
                        e.preventDefault();
                    }
                }
            }
        }
	</script>

</head>

<body leftmargin="0" topmargin="0" background="images/background.png">

    <form id="form1" runat="server" defaultbutton="btnLogin">
    
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
                
                <asp:Panel ID="pnlWelcome" runat="server" Height="36px" Width="710px" style="z-index: 110; position: absolute; top: 136px; left: 48px;">
	                <asp:Label id="lblWelcome" runat="server" ForeColor="Navy" Font-Bold="True" Font-Size="Large">Welcome to Sphynx.</asp:Label>
	            </asp:Panel>
    	
	            <asp:Panel ID="pnlLogin" runat="server" Width="368px" style="z-index: 101; position: absolute; top: 224px; left: 272px; text-align:center;">
        		    
        		    <table width="368px" border="0">
                        <tr>
                            <td colspan="2" style="text-align:left;">
                                <asp:Label id="lblLoginInstructions" runat="server" ForeColor="Navy" Font-Size="X-Small">Type your username and password to login.</asp:Label>
                                <br />
                                <br />
                            </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">
                                <asp:Label id="lblUsername" runat="server" Height="18px" CssClass="largelabel">Username:</asp:Label>
                            </td>
                            <td>
                                <asp:TextBox id="txtUsername" runat="server" Width="126px" CssClass="usernametxtbox" MaxLength="100" tabIndex="1" BorderStyle="Inset"
	                            onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')"  >
	                            </asp:TextBox>
	                            <asp:RequiredFieldValidator id="rfvUsername" runat="server" ControlToValidate="txtUsername" ErrorMessage="You must specify a username.">*</asp:RequiredFieldValidator>
	                        </td>
                        </tr>
                        <tr>
                            <td style="text-align:right;">
                                <asp:Label id="lblPassword" runat="server" Height="18px" CssClass="largelabel">Password:</asp:Label>
                            </td>
                            <td>
	                            <asp:TextBox id="txtPassword" runat="server" Width="126px" CssClass="txtbox" MaxLength="100" tabIndex="2" BorderStyle="Inset" TextMode="Password"
	                            onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')">
	                            </asp:TextBox>
	                            <asp:RequiredFieldValidator id="rfvPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="The password is required.">*</asp:RequiredFieldValidator>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                                <asp:Label id="lblLostPassword" runat="server" Height="18px" Font-Size="XX-Small" style="vertical-align:middle;">Lost password?</asp:Label>
	                            &nbsp;
	                            <asp:LinkButton id="lnkLostPassword" runat="server" Height="18px" Font-Size="XX-Small" style="vertical-align:middle;" CausesValidation="False">Click here</asp:LinkButton>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <br />
                                <asp:Button id="btnLogin" runat="server" Height="24px" Text="Login"></asp:Button>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <asp:Label id="lblWrongUP" runat="server" Height="16px" Visible="False" ForeColor="Red" Font-Size="X-Small">Submitted username and passwords are not valid.</asp:Label>
	                            <br />
	                            <br />
	                            <asp:ValidationSummary id="ValidationSummary1" runat="server" Height="25px" Width="303px" Font-Size="XX-Small"></asp:ValidationSummary>
                            </td>
                        </tr>
                    </table>
        		      
	            </asp:Panel>
    	        
	            <asp:Panel id="pnlLostPassword" runat="server" Width="368px" Height="200px" ForeColor="Transparent" 
	            style="z-index: 108; position: absolute; top: 220px; left: 265px;" BackImageUrl="images/backgrounds/redPixel.png"
	            BorderStyle="Solid" BorderColor="Maroon" BorderWidth="3px" Font-Bold="True" Visible="False">
        	    
                    <div>
	                    <table width="368px" border="0">
	                        <tr>
	                            <td colspan="2" style="height:auto;">
	                                <asp:Label id="lblLostPasswordInstructions" runat="server" Font-Size="XX-Small" ForeColor="Yellow" BackColor="Transparent">If you can not remember your password, please enter your username and instructions will be emailed to you shortly.</asp:Label>            
	                                <br />
	                                <br />
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>
                                    <asp:Label id="lblLostUsername" runat="server" Font-Size="XX-Small" ForeColor="Yellow">My username is:</asp:Label>
	                                <asp:TextBox id="txtLostUser" runat="server" BorderStyle="Solid" BorderColor="Maroon" BorderWidth="2px" ForeColor="Black" BackColor="White" CssClass="usernametxtbox"
	                                MaxLength="100" onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')">
	                                </asp:TextBox>	                                
	                            </td>
	                            <td style="text-align:right;">
	                                <asp:Button id="btnGetMyPass" runat="server" Height="26px" CssClass="button" Font-Size="XX-Small" ForeColor="Black"
	                                Text="Get my password" CausesValidation="False"></asp:Button>
	                            </td>
	                        </tr>
	                        <tr>
	                            <td>&nbsp;</td>
	                            <td style="text-align:right;">
	                                <asp:Button id="btnCancel" runat="server" Height="26px" CssClass="button" Font-Size="XX-Small" ForeColor="Black"
	                                Text="Cancel" CausesValidation="False"></asp:Button>            
	                            </td>
	                        </tr>
	                    </table>
	                    <br />
	                    
	                    <br />
	                    <br />
	                    
                    </div>
        		
                </asp:Panel>
                
                <asp:Panel id="pnlImages" runat="server" Width="736px" Height="315px" style="z-index: 100; top: 176px; left: 16px; position: absolute;">
                    <asp:Image id="imgLock" runat="server" ImageUrl="images/lock.png" style="z-index: 117; top: 37px; left: 20px; position: absolute;"></asp:Image>
                    <asp:Image id="imgGhost" runat="server" ImageUrl="images/GhostInTheMachineryFadedOut.jpg" style="z-index: 115; top: 200px; left: 627px; position: absolute;"></asp:Image>
                </asp:Panel>
    		
	            <asp:Panel id="pnlDateTime" runat="server" Height="27px" style="z-index: 110; top: 505px; left: 655px; position: absolute; ">
    		
		            <p align="right">
			            <asp:Label id="lblWelcomeDate" runat="server" Font-Size="XX-Small" ForeColor="Gray"></asp:Label>
			            <br />
			            <asp:Label id="lblWelcomeTime" runat="server" Font-Size="XX-Small" ForeColor="Gray"></asp:Label>
		            </p>
        			
	            </asp:Panel>
            
                <asp:Panel id="pnlFooter" runat="server" Width="100%" style="z-index: 110; bottom: 0px; left: 0px; position: fixed; background-color:#00227b; color:White;">
	                <asp:Label id="lblShowCopyright" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0">All rights reserved. 2006. Collins and Aikman, Liger Solutions. The use of this site is subject to the </asp:Label>
		            <asp:HyperLink id="lnkTOS" runat="server" Font-Names="Verdana" Font-Size="XX-Small" ForeColor="#E0E0E0" NavigateUrl="tos.aspx"> terms of service.</asp:HyperLink>
	            </asp:Panel>
    	        
	        </ContentTemplate>
        </asp:UpdatePanel>
    
    </form>
</body>
</html>
