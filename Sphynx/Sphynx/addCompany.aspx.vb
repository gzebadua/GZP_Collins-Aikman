Public Partial Class addCompany
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        uHaveRight(Me)

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)

        End If

        lblStatus.Visible = False

    End Sub


    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then

                .Visible = False
                btnShowMenu.Text = getMessage(Me, "btnShowMenu")

            Else

                btnShowMenu.Text = getMessage(Me, "btnHideMenu")
                .Visible = True

            End If

        End With

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("language") = e.CommandArgument
        setLabels(Me)

    End Sub


    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        'validar datos
        If txtCFID.Text.Trim() = "" Or txtCompany.Text.Trim() = "" Or txtFacility.Text.Trim() = "" Or txtName.Text.Trim() = "" Or txtLibrary.Text.Trim = "" Or txtRemoteSystem.Text.Trim = "" Then

            lblStatus.Text = getMessage(Me, "ERROR_NODATA")
            lblStatus.Visible = True
            Return

        End If

        If Not IsNumeric(txtCompany.Text) Or Not IsNumeric(txtFacility.Text) Then

            lblStatus.Text = getMessage(Me, "ERROR_NONUMERIC")
            lblStatus.Visible = True
            Return

        End If

        'Internal pfID declaration for database
        Dim pfID As String = txtCompany.Text & txtFacility.Text

        If getSQLQueryAsBoolean("SELECT * FROM companies WHERE pfid = " & pfID) Then

            lblStatus.Text = getMessage(Me, "ERROR_DUPLICATE")
            lblStatus.Visible = True
            Return

        End If

        Dim cadena As String = "insert into companies values(" & pfID & "," & preventSQLInjection(txtCFID.Text) & "," & txtCompany.Text & "," & txtFacility.Text & "," & preventSQLInjection(txtName.Text) & "," & preventSQLInjection(txtLibrary.Text) & "," & preventSQLInjection(txtRemoteSystem.Text) & "," & 1 & "," & preventSQLInjection(Session("username")) & ",getDate() )"

        If executeSQLCommand(cadena) Then
            lblStatus.Text = getMessage(Me, "SUCCESS_ADD")
        Else
            lblStatus.Text = getMessage(Me, "ERROR_ADD")
        End If

        lblStatus.Visible = True

    End Sub


End Class