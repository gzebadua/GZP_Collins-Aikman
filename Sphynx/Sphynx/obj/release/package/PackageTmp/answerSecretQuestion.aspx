<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="answerSecretQuestion.aspx.vb" Inherits="Sphynx.answerSecretQuestion" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >

<head runat="server">
    <title runat="server" id="PageTitle">Answer your Secret Question :: Collins & Aikman's Sphynx</title>
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

    <form id="form1" runat="server">
    
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>
    
        <asp:UpdatePanel ID="updatePanel1" runat="server" ChildrenAsTriggers="true" UpdateMode="Always">
            <ContentTemplate>
            
                <asp:Panel ID="pnlImgHeader" runat="server" style="z-index: 110; position: fixed; top: 0px; left: 0px;">
                    <asp:Image id="imgHeader" runat="server" Height="114px" Width="760px" ImageAlign="Top" ImageUrl="images/header.png"></asp:Image>
                </asp:Panel>
                
                <asp:Panel id="pnlFlags" runat="server" Height="32px" Width="152px" style="z-index: 110; top: 2px; left: 684px; position: fixed;">
        		
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
		            <asp:Label id="lblWelcome" runat="server" ForeColor="Navy" Font-Bold="True" Font-Size="Large">Hi Guest! Please answer your secret question.</asp:Label>
		        </asp:Panel>
        		
		        <asp:Panel ID="pnlSecretAnswer" runat="server" Width="600px" style="z-index: 101; position: absolute; top: 200px; left: 180px; text-align:left;">
        		
		            <br />
		            <br />
		            <asp:Label id="lblSecretQuestion" runat="server" CssClass="largelabel"></asp:Label>
		            <br />
		            <br />
		            <asp:Label id="lblSecretAnswer" runat="server" Height="18px" Width="120px" CssClass="largelabel">Secret Answer:</asp:Label>
		            <asp:TextBox id="txtSecretAnswer" runat="server" Width="126px" CssClass="txtbox" MaxLength="12" tabIndex="2" BorderStyle="Inset" TextMode="Password"
		            onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')">
		            </asp:TextBox>
		            <asp:RequiredFieldValidator id="rfvSecretAnswer" runat="server" ControlToValidate="txtSecretAnswer" ErrorMessage="The secret answer is required.">*</asp:RequiredFieldValidator>
		            <br />
		            <br />
		            <asp:Button id="btnAnswer" runat="server" Height="24px" Text="Submit"></asp:Button>
		            <br />
		            <br />
		            <br />
		            <asp:ValidationSummary id="ValidationSummary1" runat="server" Height="25px" Width="303px" Font-Size="XX-Small"></asp:ValidationSummary>
		            <br />
        		      
		        </asp:Panel>
        				
	            <asp:Image id="imgGhost" runat="server" ImageUrl="images/GhostInTheMachinery.jpg" style="z-index: 115; top: 200px; left: 50px; position: absolute;"></asp:Image>
        	    
	            <asp:Panel id="pnlDateTime" runat="server" Height="27px" style="z-index: 110; top: 505px; left: 655px; position: absolute; ">
        			
			        <p align="right">
				        <asp:Label id="lblWelcomeDate" runat="server" Font-Size="XX-Small" ForeColor="Gray"></asp:Label>
				        <br />
				        <asp:Label id="lblWelcomeTime" runat="server" Font-Size="XX-Small" ForeColor="Gray"></asp:Label>
			        </p>
        			
		        </asp:Panel>
		        
		    </ContentTemplate>
		</asp:UpdatePanel>
		
    </form>
    
</body>

</html>
