Public Partial Class sessionEnd
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)

            PageTitle.Text = getMessage(Me, "PageTitle")

            lblSessionMessage.Text = getMessage(Me, "sessionMessagePart1") & " " & getMinutesOfInactivityToLogout() & " " & getMessage(Me, "sessionMessagePart2")

        End If

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("language") = e.CommandArgument

        setLabels(Me)

        PageTitle.Text = getMessage(Me, "PageTitle")

        lblSessionMessage.Text = getMessage(Me, "sessionMessagePart1") & " " & getMinutesOfInactivityToLogout() & " " & getMessage(Me, "sessionMessagePart2")

    End Sub


    Private Sub lblLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblLogout.Click

        If logLogout(Me, Session("username"), findRemoteIP(Me), findRemoteMachineName) = True Then
            Response.Redirect("login.aspx")
        End If

    End Sub


End Class