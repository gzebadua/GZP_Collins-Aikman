Partial Public Class answerSecretQuestion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)

            lblWelcomeDate.Text = Date.Now.ToLongDateString
            lblWelcomeTime.Text = Date.Now.ToShortTimeString()

            Try

                Session("providedUsername") = verifyIfUserResetHashIsCorrect(Request.QueryString("v").Replace(" ", "+"))

            Catch ex As Exception
                Session("providedUsername") = ""
            End Try
            
            If Session("providedUsername") <> "" Then

                lblWelcome.Text = getMessage(Me, "welcomePart1") & " " & getSQLQueryAsString("SELECT suserfullname FROM users WHERE susername = '" & Session("providedUsername") & "'") & "! " & getMessage(Me, "welcomePart2")

                lblSecretQuestion.Text = getSQLQueryAsString("SELECT suserrescuequestion FROM users WHERE susername = '" & Session("providedUsername") & "'")

            Else

                Response.Redirect("login.aspx")

            End If

        End If

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("preferredLanguage") = e.CommandArgument

        setLabels(Me)

    End Sub


    Private Sub btnAnswer_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAnswer.Click

        If isSystemOnline() = False Then
            Exit Sub
        End If

        txtSecretAnswer.Text = txtSecretAnswer.Text.Trim()
        txtSecretAnswer.Text = txtSecretAnswer.Text.Replace("'", "")
        txtSecretAnswer.Text = txtSecretAnswer.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")

        If logRescueAnswerAttempts(Me, Session("providedUsername"), txtSecretAnswer.Text) = True Then

            createUserSessionVariables(Me, Session("providedUsername"))
            Response.Redirect("resetPassword.aspx")

        End If

    End Sub


    Private Function logRescueAnswerAttempts(ByVal origen As System.Web.UI.Page, ByVal username As String, ByVal providedanswer As String) As Boolean

        Dim ip As String = findRemoteIP(origen)
        Dim machinename As String = findRemoteMachineName()
        Dim dbrescueanswer As String = getSQLQueryAsString("SELECT suserrescueanswerhash FROM users WHERE susername = '" & username & "'")

        Dim fecha As String = getMySQLDate()

        Dim encryptedProvidedAnswer As String = EncryptText(providedanswer)

        Dim ilogid As Integer = 1
        ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

        If dbrescueanswer <> encryptedProvidedAnswer Then

            executeSQLCommand("INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & origen.Session("username") & "', '" & origen.Session.SessionID & "', '" & ip & "', '" & machinename & "', 'Rescue Answer Attempt - Result : False', '0')")

            Return False

        Else

            executeSQLCommand("INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & origen.Session("username") & "', '" & origen.Session.SessionID & "', '" & ip & "', '" & machinename & "', 'Rescue Answer Attempt - Result : True', '1')")

            Return True

        End If

    End Function


End Class