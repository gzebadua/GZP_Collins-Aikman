<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="displayLang.aspx.vb" Inherits="Sphynx.displayLang" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title id="PageTitle" runat="server"></title>
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
                
                <asp:Button id="btnShowAll" style="z-index: 103; left: 16px; position: absolute; top: 136px"
		        runat="server" Height="25px" Width="152px" CssClass="button" BackColor="LightSteelBlue" Text="btnShowAll" 
		        BorderStyle="Solid" Font-Size="XX-Small" BorderColor="Navy" BorderWidth="1px"></asp:Button>
                <asp:Button id="btnFilter" style="z-index: 106; left: 168px; position: absolute; top: 136px"
		        runat="server" Height="25px" Width="152px" CssClass="button" BackColor="Lavender" Text="btnFilter"
		        BorderStyle="Solid" Font-Size="XX-Small" BorderColor="Navy" BorderWidth="1px"></asp:Button>
                <asp:Button id="btnAddLanguage" style="z-index: 104; left: 320px; position: absolute; top: 136px" runat="server"
		        Height="25px" Width="136px" CssClass="button" BackColor="Lavender" Text="btnAdd" BorderStyle="Solid" 
		        Font-Size="XX-Small" BorderColor="Navy" BorderWidth="1px"></asp:Button>
		        <asp:Button id="btnAddLabel" style="z-index: 110; left: 456px; position: absolute; top: 136px"
		        runat="server" Width="152px" Height="25px" BackColor="Lavender" CssClass="button" BorderStyle="Solid"
		        Text="btnAddLabel" BorderWidth="1px" BorderColor="Navy" Font-Size="XX-Small"></asp:Button>
        		
		        <asp:Panel id="pnlNewLang" style="z-index: 109; top: 160px; left: 16px;position: absolute;"
		        runat="server" Visible="False" Width="95%" BackColor="White" BorderStyle="Outset" BorderColor="MediumBlue" BorderWidth="2px">
			        <center>
			            <br />
			            <br />
				        <asp:Label id="lblSpecifyNewLang" runat="server" Font-Size="XX-Small" ForeColor="#0000C0">lblSpecifyNewLang</asp:Label>
				        <br />
				        <asp:TextBox id="txtNewLangID" runat="server" MaxLength="2" Font-Size="X-Small"
				        BorderStyle="Solid" BorderColor="Black" Font-Names="Verdana" BorderWidth="1px" 
				        onkeypress="validateInput(event,'[a-zA-z]')"></asp:TextBox>
				        <br />
				        <br />
				        <asp:Repeater id="rptLangName" runat="server">
					        <ItemTemplate>
						        &nbsp;&nbsp;
						        <asp:Label id="lblLangName" runat="server" Width="300px" Font-Size="XX-Small">dgLang</asp:Label><br />
						        &nbsp;&nbsp;
						        <asp:TextBox id="txtNewLangName" runat="server" MaxLength="70" Font-Size="X-Small"
						        BorderStyle="Solid" BorderColor="Black" Font-Names="Verdana" BorderWidth="1px" 
						        onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓ.?_#¡!¿,:()ÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')"></asp:TextBox>
						        <br />
						        <br />
					        </ItemTemplate>
				        </asp:Repeater>
				        <br />
				        <asp:Button id="btnSaveNewLang" runat="server" Text="btnNewLang"></asp:Button>
				        <br />
				        <asp:Label id="lblLangAlreadyInUse" runat="server" Visible="False" Font-Size="XX-Small" ForeColor="Red"></asp:Label>
				        <br />
				        <br />
				        <br />
			        </center>
		        </asp:Panel>
        		
        		
		        <asp:Panel id="pnlNewLabel" style="z-index: 112; top: 160px; left: 16px; position: absolute;"
	            runat="server" Visible="False" Width="95%" BorderColor="MediumBlue" BorderWidth="2px"
	            BorderStyle="Outset" BackColor="White">
			        <center>
			            <br />
			            <br />
				        <asp:Label id="lblNewPage" runat="server" Font-Size="XX-Small" ForeColor="#0000C0"></asp:Label>
				        <br />
				        <asp:TextBox id="txtNewPage" runat="server" MaxLength="50" 
				        onkeypress="validateInput(event,'[a-zA-z0-9ñÑáéíóúäë._?#&amp;\/ïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')"></asp:TextBox>
				        <br />
				        <br />
				        <asp:Label id="lblNewLabel" runat="server" Font-Size="XX-Small" ForeColor="#0000C0"></asp:Label>
				        <br />
				        <asp:TextBox id="txtNewLabel" runat="server" MaxLength="70" 
				        onkeypress="validateInput(event,'[a-zA-z0-9ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')"></asp:TextBox>
				        <br />
				        <br />
				        <asp:Button id="btnCreateNewLabel" runat="server"></asp:Button><br />
				        <br />
				        <asp:Label id="lblLabelAlreadyExists" runat="server" Visible="False" Font-Size="XX-Small" ForeColor="Red"></asp:Label>
				        <br />
				        <br />
				        <br />
				        <br />
				        <br />
				        <br />
				        <br />
				        <br />
				        <br />
				        <br />
				        <br />
			        </center>
		        </asp:Panel>
        		
        		<asp:Panel id="pnlData" runat="server" style="z-index: 105; top: 160px; left: 16px; position: absolute;"
		        Width="95%" BorderStyle="Solid" BorderColor="Black" BorderWidth="1px">
		        
		            <asp:Panel id="pnlSearchName" runat="server" Visible="False" Height="60px">   
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
		            </asp:Panel>
				    
                    <asp:GridView ID="gvLabels" runat="server" Font-Size="XX-Small" Font-Names="Verdana"
				     DataKeyNames="spage, slabel" AllowPaging="True" Pagesize="15" Height="300px" Width="100%">
				        <AlternatingRowStyle BackColor="Lavender"></AlternatingRowStyle>
				        <HeaderStyle Font-Bold="True" ForeColor="White" BackColor="#000066"></HeaderStyle>
				        <Columns>
				            <asp:TemplateField>
						        <ItemStyle HorizontalAlign="center" Width="100px"></ItemStyle>
						        <ItemTemplate>
							        <asp:LinkButton id="lnkEdit" runat="server" Font-Size="XX-Small" CommandName="Edit" CommandArgument="spage" Cssclass="hlink">lnkEdit</asp:LinkButton>
							        &nbsp;/&nbsp;
							        <asp:LinkButton id="lnkDelete" runat="server" Font-Size="XX-Small" CommandName="Delete" CommandArgument="spage" Cssclass="hlink">lnkDelete</asp:LinkButton>
						        </ItemTemplate>
					        </asp:TemplateField>
				        </Columns>
				        <PagerSettings Mode="Numeric" />
                    </asp:GridView>
			        
					<br />
		            <br />
		        
		        </asp:Panel>
		        
		        <asp:Panel id="pnlEdit" style="z-index: 118; left: 16px; position: absolute; top: 160px" runat="server"
		        Visible="False" BackColor="White" Width="95%" Height="300px" BorderStyle="Solid" BorderWidth="2px" BorderColor="Navy"
		        BackImageUrl="images/backgrounds/WhitePixel.png">
        			
			        <p>
			            &nbsp;&nbsp;&nbsp;
				        <asp:Label id="lblHeader" runat="server" Font-Size="Medium" Font-Bold="True">lblHeader</asp:Label><br />
				        &nbsp;&nbsp;&nbsp;&nbsp;
				        <asp:Label id="lblLabel" runat="server"></asp:Label><br />
				        &nbsp;&nbsp;&nbsp;<br />
				        &nbsp;&nbsp;
				        <br />
				        <asp:Repeater id="rptLabels" runat="server">
					        <ItemTemplate>
						        &nbsp;&nbsp;
						        <asp:Label id="dgLang" runat="server" Width="300px" Font-Size="XX-Small">dgLang</asp:Label><br />
						        &nbsp;&nbsp;
						        <asp:TextBox id="txtNewLabel" runat="server" Height="20px" MaxLength="70" Width="208px" Font-Size="X-Small"
						        BorderStyle="Solid" BorderColor="Black" Font-Names="Verdana" BorderWidth="1px" 
						        onkeypress="validateInput(event,'[a-zA-z0-9 ñÑáéíóúäëïöüâêîôûàèìòùÁÉÍÓ.?_#¡!¿,:()ÚÄËÏÖÜÀÈÌÒÙÂÊÎÔÛ-]')"></asp:TextBox>
						        <br />
						        <br />
					        </ItemTemplate>
				        </asp:Repeater>
				        &nbsp;&nbsp;
			        </p>
			        <p>
			            &nbsp;
				        <asp:Button id="btnCancel" runat="server" Width="112px" BackColor="#E0E0E0" BorderStyle="Solid"
				        BorderWidth="1px" BorderColor="Black" Text="btnCancel"></asp:Button>
				        &nbsp;&nbsp;
				        <asp:Button id="btnSaveLabel" runat="server" Width="200px" BackColor="#E0E0E0" BorderStyle="Solid"
				        BorderWidth="1px" BorderColor="Black" Text="btnSave"></asp:Button>
				        <asp:Button id="btnModify" runat="server" Width="200px" BackColor="#E0E0E0" BorderStyle="Solid"
				        BorderWidth="1px" BorderColor="Black" Text="btnModify"></asp:Button>
				        <asp:Button id="btnDelete" runat="server" Width="200px" BackColor="#E0E0E0" BorderStyle="Solid"
				        BorderWidth="1px" BorderColor="Black" Text="btnDelete" designtimedragdrop="154"></asp:Button>
				        <br />
				        <br />
				        <asp:Label id="lblSaveError" runat="server" Font-Size="Medium" Font-Bold="True"></asp:Label>
				        <br />
				        <br />
			        </p>
        			
		        </asp:Panel>
		        
		        <asp:Panel id="pnlDeleteWarning" style="z-index: 119; left: 16px; position: absolute; top: 160px" runat="server"
		        Visible="False" BackColor="Red" Width="95%" Height="300px" BorderStyle="Solid" BorderWidth="2px" BorderColor="Red"
		        BackImageUrl="images/backgrounds/RedPixel.png">
        			<center>
			            <br />
				        <asp:Label id="lblDeleteWarning" runat="server" Height="25px" Font-Bold="True" ForeColor="White" Font-Size="Medium"></asp:Label>
				        <br />
				        <br />
				        <asp:Button id="btnCancelDelete" runat="server" Height="25px" Width="152px" CssClass="button" 
				        BackColor="LightSteelBlue" Font-Bold="True" ForeColor="Black" BorderStyle="Solid" Font-Size="Medium" 
				        BorderColor="Navy" BorderWidth="1px"></asp:Button>
				        &nbsp;&nbsp;
				        <asp:Button id="btnDeleteConfirmation" runat="server" Height="25px" Width="200px" CssClass="button" 
				        BackColor="LightSteelBlue" Font-Bold="True" ForeColor="Black" BorderStyle="Solid" Font-Size="Medium" 
				        BorderColor="Navy" BorderWidth="1px"></asp:Button>
				        <br />
				        <br />
			        </center>
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
