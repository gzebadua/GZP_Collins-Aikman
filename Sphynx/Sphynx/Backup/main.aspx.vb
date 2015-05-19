Public Partial Class main
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If verifyIfUserIsReallyLogged(Me) = False Then
            Response.Redirect("login.aspx")
        End If

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)
            loadMenu(Me, rptMenu)

            pnlMenu.Visible = True

            lblWelcomeName.Text = Session("desiredName")
            lblWelcomeCompany.Text = Session("companyName")

            PageTitle.Text = getMessage(Me, "PageTitle") & " - " & Session("fullName")

        End If

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("preferredLanguage") = e.CommandArgument

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