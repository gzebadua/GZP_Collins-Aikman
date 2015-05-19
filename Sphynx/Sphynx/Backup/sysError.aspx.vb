Public Partial Class sysError
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)
            loadMenu(Me, rptMenu)

            PageTitle.Text = getMessage(Me, "PageTitle") & " - " & Session("realname")

            lblErrorDescription.Text = Server.GetLastError.ToString

        End If

    End Sub


    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then

                .Visible = False
                btnShowMenu.Text = getMessage(Me, "btnShowMenu")

            Else

                .Visible = True
                btnShowMenu.Text = getMessage(Me, "HideMenu")

            End If

        End With

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("language") = e.CommandArgument

        setLabels(Me)
        loadMenu(Me, rptMenu)

        PageTitle.Text = getMessage(Me, "PageTitle") & " - " & Session("realname")

    End Sub


    Private Sub lblLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblLogout.Click

        If logLogout(Me, Session("username"), findRemoteIP(Me), findRemoteMachineName) = True Then
            Response.Redirect("login.aspx")
        End If

    End Sub


End Class