Public Partial Class updateCompanies
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        uHaveRight(Me)

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)

            fillDropDownList(cmbCompanies, "SELECT pfID, name FROM companies")
            viewCompanyData()

        End If

    End Sub


    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then

                .Visible = False
                btnShowMenu.Text = getMessage(Me, "btnShowMenu")
                cmbCompanies.Visible = True

            Else

                btnShowMenu.Text = getMessage(Me, "btnHideMenu")
                .Visible = True
                cmbCompanies.Visible = False

            End If

        End With

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("language") = e.CommandArgument

        setLabels(Me)

    End Sub


    Private Sub viewCompanyData()

        lblStatus.Visible = False

        If cmbCompanies.SelectedIndex < 0 Then Return

        Dim datos As DataSet = getSQLQueryAsDataset("SELECT * FROM companies where pfid=" & cmbCompanies.SelectedValue)

        With datos.Tables(0).Rows.Item(0)

            txtCFID.Text = .Item("cfID")
            txtCompany.Text = .Item("company")
            txtFacility.Text = .Item("facility")
            txtName.Text = .Item("name")
            txtLibrary.Text = .Item("library")
            txtRemoteSystem.Text = .Item("remoteSystem")
            chkActive.Checked = .Item("active")

        End With

    End Sub


    Private Sub cmbCompanies_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmbCompanies.SelectedIndexChanged

        viewCompanyData()

    End Sub


    Private Sub btnSubmit_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSubmit.Click

        If txtName.Text.Trim() = "" Or txtLibrary.Text.Trim = "" Or txtRemoteSystem.Text.Trim = "" Then

            lblStatus.Text = getMessage(Me, "ERROR_NODATA")
            lblStatus.Visible = True
            Return

        End If

        Dim activo As Integer = 0 'default

        If chkActive.Checked Then activo = 1

        Dim cadena As String = "UPDATE companies set name=" & preventSQLInjection(txtName.Text) & ",library=" & preventSQLInjection(txtLibrary.Text) & ",remotesystem=" & preventSQLInjection(txtRemoteSystem.Text) & ",active=" & activo & ",lastReviewingUser=" & preventSQLInjection(Session("username")) & ",lastReviewingDT=getDate() where pfid=" & preventSQLInjection(cmbCompanies.SelectedValue)

        If executeSQLCommand(cadena) Then

            lblStatus.Text = getMessage(Me, "SUCCESS_UPDATE")

        Else

            lblStatus.Text = getMessage(Me, "ERROR_UPDATE")

        End If

        lblStatus.Visible = True

    End Sub


End Class