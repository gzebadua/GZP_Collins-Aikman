Public Partial Class reopen
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            cleanSession(Me)

            setLabels(Me)
            showFlags(rptFlags)

            lblWelcomeDate.Text = Date.Now.ToLongDateString
            lblWelcomeTime.Text = Date.Now.ToShortTimeString()

            randomizeGhostImage(imgLock)

            txtUsername.Focus()

        End If
        
    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("preferredLanguage") = e.CommandArgument

        setLabels(Me)

    End Sub


    Private Sub btnLogin_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnLogin.Click

        txtUsername.Text = txtUsername.Text.Trim()
        txtUsername.Text = txtUsername.Text.Replace("'", "")
        txtUsername.Text = txtUsername.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
        txtPassword.Text = txtPassword.Text.Trim()
        txtPassword.Text = txtPassword.Text.Replace("'", "")
        txtPassword.Text = txtPassword.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")

        Dim loginVerifier As String
        loginVerifier = checkLogin(txtUsername.Text, txtPassword.Text)

        If loginVerifier = "-5" Then

            logLogin(Me, txtUsername.Text, findRemoteIP(Me), findRemoteMachineName(), False)

            lblWrongUP.Visible = True
            lblWrongUP.Text = getMessage(Me, "userNotExists")
            lblLostPassword.Visible = False
            lnkLostPassword.Visible = False
            txtPassword.Focus()

        ElseIf loginVerifier = "-4" Then

            logLogin(Me, txtUsername.Text, findRemoteIP(Me), findRemoteMachineName(), False)
            lblWrongUP.Visible = True
            lblWrongUP.Text = getMessage(Me, "passwordNotValid")
            lblLostPassword.Visible = True
            lnkLostPassword.Visible = True
            txtPassword.Focus()

        ElseIf loginVerifier = "-3" Then

            logLogin(Me, txtUsername.Text, findRemoteIP(Me), findRemoteMachineName(), False)
            lblWrongUP.Visible = True
            lblWrongUP.Text = getMessage(Me, "userInactive")
            lblLostPassword.Visible = False
            lnkLostPassword.Visible = False
            txtPassword.Focus()

        ElseIf loginVerifier = "-2" Then

            logLogin(Me, txtUsername.Text, findRemoteIP(Me), findRemoteMachineName(), False)
            lblWrongUP.Visible = True
            lblWrongUP.Text = getMessage(Me, "userNotApproved")
            lblLostPassword.Visible = False
            lnkLostPassword.Visible = False
            txtPassword.Focus()

        ElseIf loginVerifier = "-1" Then

            logLogin(Me, txtUsername.Text, findRemoteIP(Me), findRemoteMachineName(), False)

            lblWrongUP.Visible = True
            lblWrongUP.Text = getMessage(Me, "userLockedOut") & " " & getMinutesOfInactivityToLogout() & " " & getMessage(Me, "userLockedOut2")
            lblLostPassword.Visible = False
            lnkLostPassword.Visible = False
            txtPassword.Focus()

        ElseIf loginVerifier = "0" Then

            logLogin(Me, txtUsername.Text, findRemoteIP(Me), findRemoteMachineName(), False)

            lblWrongUP.Visible = True
            lblWrongUP.Text = getMessage(Me, "alreadyLoggedIn")
            lblLostPassword.Visible = False
            lnkLostPassword.Visible = False
            txtPassword.Focus()

        Else

            logLogin(Me, txtUsername.Text, findRemoteIP(Me), findRemoteMachineName(), True)

            Response.Redirect("systemAct.aspx")

        End If

    End Sub


    Private Sub lnkLostPassword_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lnkLostPassword.Click

        pnlLostPassword.Visible = True
        txtLostUser.Text = txtUsername.Text
        txtLostUser.Focus()

    End Sub


    Private Sub btnGetMyPass_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGetMyPass.Click

        If isSystemOnline() = False Then
            Exit Sub
        End If

        Dim dsUserInfo As DataSet = getSQLQueryAsDataset("SELECT * FROM users WHERE susername = '" & txtLostUser.Text & "'")

        Try

            If dsUserInfo.Tables(0).Rows.Count > 0 Then

                If sendHTMLMail(dsUserInfo.Tables(0).Rows(0).Item("suseremail"), "Sphynx password reset", "<br />Forgetting your password needn't cause you any sleepless nights as all you have to do to reset it is follow the link below (it expires in 24 hrs):<br /><br />http://www.memozebadua.me/websphynx/answerSecretQuestion.aspx?v=" & EncryptText(dsUserInfo.Tables(0).Rows(0).Item("susername") & getYYYYMMDDMySQLDate()) & " <br /><br />If you've remembered the password now, or didn't make this request yourself, just feel free to forget about this mail.<br /><br />All the best,<br /><br />The Sphynx Team") = True Then

                    Dim irequestid As Integer = 1
                    irequestid = getSQLQueryAsInteger("SELECT IF(MAX(ipasswordresetrequestid) + 1 IS NULL, 1, MAX(ipasswordresetrequestid) + 1) AS ipasswordresetrequestid FROM passwordresetrequests ORDER BY requestdate DESC LIMIT 1")

                    executeSQLCommand("INSERT INTO passwordresetrequests VALUES (" & irequestid & ", '" & txtLostUser.Text & "', '" & getMySQLDate() & "')")

                    lblLostPasswordInstructions.Text = getMessage(Me, "restoreYourPasswordEmailSent")
                    lblLostUsername.Visible = False
                    txtLostUser.Visible = False
                    btnCancel.Visible = False
                    btnGetMyPass.Visible = False

                Else
                    lblLostUsername.Text = getMessage(Me, "restoreYourPasswordEmailError")
                End If

            Else
                lblLostUsername.Text = getMessage(Me, "restoreYourPasswordUsernameNotFound")
            End If

        Catch ex As Exception

            lblLostUsername.Text = getMessage(Me, "restoreYourPasswordEmailError")

        End Try


    End Sub


    Private Sub btnCancel_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        txtLostUser.Text = ""
        pnlLostPassword.Visible = False
        If txtUsername.Text.Length > 0 Then
            txtPassword.Focus()
        Else
            txtUsername.Focus()
        End If

    End Sub


End Class