Public Partial Class displayUsers
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        clearanceCheck(Me)

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)
            loadMenu(Me, rptMenu)

            gvUsers.DataSource = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, c.scompanyname, IF(c.bactive = 1, '" & getMessage(Me, "CompanyActive") & "', '" & getMessage(Me, "CompanyInactive") & "') AS bcompanyactive, u.suseremail, ln.slanguagename_" & Session("preferredLanguage") & ", IF(u.bonline = 1, '" & getMessage(Me, "UserOnline") & "', '" & getMessage(Me, "UserOffline") & "') AS bonline, IF(u.bapproved = 1, '" & getMessage(Me, "UserApproved") & "', '" & getMessage(Me, "UserNotApproved") & "') AS bapproved, IF(u.blockedout = 1, '" & getMessage(Me, "UserLockedOut") & "', '" & getMessage(Me, "UserNotLockedOut") & "') AS blockedout, u.iuserlevel, u.sparentusername, u.suserrescuequestion FROM users u JOIN companies c ON u.icompanyid = c.icompanyid LEFT JOIN companyplants cp ON u.icompanyid = cp.icompanyid LEFT JOIN languages l ON u.spreferredlanguage = l.slanguagecode LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")
            gvUsers.DataBind()

            formatDataGrid()

            lblStatus.Visible = False

            lblWelcomeName.Text = Session("desiredName")
            lblWelcomeCompany.Text = Session("companyName")

            PageTitle.Text = getMessage(Me, "PageTitle") & " - " & Session("fullName")

            If permissionCheck(Session("username"), "", "addUser") = False Then
                btnAddUser.Visible = False
            End If

            txtNP.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + btnGoSearch.UniqueID + "').click();return false;}} else {return true}; ")

        End If

    End Sub


    Sub formatDataGrid()

        Dim tlnb As LinkButton
        Dim tchk As CheckBox

        Dim permForMod As Boolean = permissionCheck(Session("username"), "", "deactivateUser")

        Dim dsUsers As DataSet = getSQLQueryAsDataset("SELECT susername, bactive FROM users")

        With gvUsers

            '.Columns(0).ControlStyle.Width = 50
            '.Columns(0).ControlStyle.Width = 70

            'For i As Integer = 0 To 15
            '    .Columns(0).HeaderText = getMessage(Me, "dgHeader" & i)
            '    .Columns(0).HeaderStyle.HorizontalAlign = HorizontalAlign.Center
            'Next

            For i As Integer = 0 To .Rows.Count - 1

                tlnb = .Rows(i).FindControl("lnkEdit")
                tlnb.Text = getMessage(Me, "lnkEdit")
                tlnb.Visible = permForMod

                tlnb = .Rows(i).FindControl("lnkChangeStatus")
                tlnb.Text = getMessage(Me, "lnkChangeStatus")
                tlnb.Visible = permForMod

                tchk = .Rows(i).FindControl("chkActive")

                If dsUsers.Tables.Count > 0 Then

                    If dsUsers.Tables(0).Rows.Count > 0 Then

                        For j = 0 To dsUsers.Tables(0).Rows.Count - 1

                            If gvUsers.Rows(i).Cells(2).Text = dsUsers.Tables(0).Rows(j).Item(0) Then

                                If dsUsers.Tables(0).Rows(j).Item(1) = "1" Then
                                    tchk.Checked = True
                                Else
                                    tchk.Checked = False
                                End If

                            End If

                        Next j

                    End If

                End If

            Next

        End With

    End Sub


    Sub formatDatagridHeaders()

        Try

            gvUsers.HeaderRow.Cells(0).Width = 50
            gvUsers.HeaderRow.Cells(1).Width = 70

            For i As Integer = 0 To 15
                gvUsers.HeaderRow.Cells(i).Text = getMessage(Me, "dgHeader" & i)
                gvUsers.HeaderRow.Cells(i).HorizontalAlign = HorizontalAlign.Center
            Next

        Catch ex As Exception

        End Try

    End Sub


    Sub enableDisableStatusCheckboxes(ByVal active As Boolean)

        Dim tchk As CheckBox

        With gvUsers

            For i As Integer = 0 To .Rows.Count - 1

                tchk = .Rows(i).FindControl("chkActive")
                tchk.Enabled = active

            Next

        End With

    End Sub


    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then

                btnShowMenu.Text = getMessage(Me, "btnShowMenu")
                .Visible = False

            Else

                btnShowMenu.Text = getMessage(Me, "HideMenu")
                .Visible = True

            End If

        End With

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("preferredLanguage") = e.CommandArgument

        setLabels(Me)
        loadMenu(Me, rptMenu)

        formatDataGrid()
        formatDatagridHeaders()

        PageTitle.Text = getMessage(Me, "PageTitle") & " - " & Session("realname")

    End Sub


    Private Sub lblLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblLogout.Click

        If logLogout(Me, Session("username"), findRemoteIP(Me), findRemoteMachineName) = True Then
            Response.Redirect("login.aspx")
        End If

    End Sub


    Private Sub btnShowAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowAll.Click

        txtNP.Text = ""

        gvUsers.PageIndex = 0

        gvUsers.DataSource = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, c.scompanyname, IF(c.bactive = 1, '" & getMessage(Me, "CompanyActive") & "', '" & getMessage(Me, "CompanyInactive") & "') AS bcompanyactive, u.suseremail, ln.slanguagename_" & Session("preferredLanguage") & ", IF(u.bonline = 1, '" & getMessage(Me, "UserOnline") & "', '" & getMessage(Me, "UserOffline") & "') AS bonline, IF(u.bapproved = 1, '" & getMessage(Me, "UserApproved") & "', '" & getMessage(Me, "UserNotApproved") & "') AS bapproved, IF(u.blockedout = 1, '" & getMessage(Me, "UserLockedOut") & "', '" & getMessage(Me, "UserNotLockedOut") & "') AS blockedout, u.iuserlevel, u.sparentusername, u.suserrescuequestion FROM users u JOIN companies c ON u.icompanyid = c.icompanyid LEFT JOIN companyplants cp ON u.icompanyid = cp.icompanyid LEFT JOIN languages l ON u.spreferredlanguage = l.slanguagecode LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")
        gvUsers.DataBind()

        formatDataGrid()

        lblStatus.Visible = False

        btnShowAll.BackColor = System.Drawing.Color.LightSteelBlue
        btnShowActive.BackColor = System.Drawing.Color.Lavender
        btnShowInactive.BackColor = System.Drawing.Color.Lavender
        btnShowbyNP.BackColor = System.Drawing.Color.Lavender
        btnAddUser.BackColor = System.Drawing.Color.Lavender
        btnUpdateStatus.BackColor = System.Drawing.Color.Lavender

        btnUpdateStatus.Visible = False

        pnlSearchName.Visible = False

    End Sub


    Private Sub btnShowActive_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowActive.Click

        gvUsers.DataSource = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, c.scompanyname, IF(c.bactive = 1, '" & getMessage(Me, "CompanyActive") & "', '" & getMessage(Me, "CompanyInactive") & "') AS bcompanyactive, u.suseremail, ln.slanguagename_" & Session("preferredLanguage") & ", IF(u.bonline = 1, '" & getMessage(Me, "UserOnline") & "', '" & getMessage(Me, "UserOffline") & "') AS bonline, IF(u.bapproved = 1, '" & getMessage(Me, "UserApproved") & "', '" & getMessage(Me, "UserNotApproved") & "') AS bapproved, IF(u.blockedout = 1, '" & getMessage(Me, "UserLockedOut") & "', '" & getMessage(Me, "UserNotLockedOut") & "') AS blockedout, u.iuserlevel, u.sparentusername, u.suserrescuequestion FROM users u JOIN companies c ON u.icompanyid = c.icompanyid LEFT JOIN companyplants cp ON u.icompanyid = cp.icompanyid LEFT JOIN languages l ON u.spreferredlanguage = l.slanguagecode LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid WHERE u.susername LIKE '%" & txtNP.Text & "%' OR u.suserfullname LIKE '%" & txtNP.Text & "%' OR u.suserdesiredname LIKE '%" & txtNP.Text & "%' OR c.scompanyname LIKE '%" & txtNP.Text & "%' OR cp.splantname LIKE '%" & txtNP.Text & "%' OR cp.remotesystemandport LIKE '%" & txtNP.Text & "%' OR u.suseremail LIKE '%" & txtNP.Text & "%' OR u.spreferredlanguage LIKE '%" & txtNP.Text & "%' OR ln.slanguagename_" & Session("preferredLanguage") & " LIKE '%" & txtNP.Text & "%' OR u.sparentusername LIKE '%" & txtNP.Text & "%' OR u.suserrescuequestion LIKE '%" & txtNP.Text & "%'")
        gvUsers.DataBind()

        formatDataGrid()

        lblStatus.Visible = False

        btnShowAll.BackColor = System.Drawing.Color.Lavender
        btnShowActive.BackColor = System.Drawing.Color.LightSteelBlue
        btnShowInactive.BackColor = System.Drawing.Color.Lavender
        btnShowbyNP.BackColor = System.Drawing.Color.Lavender
        btnAddUser.BackColor = System.Drawing.Color.Lavender
        btnUpdateStatus.BackColor = System.Drawing.Color.Lavender

        btnUpdateStatus.Visible = False

        pnlSearchName.Visible = False

    End Sub


    Private Sub btnShowInactive_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowInactive.Click

        gvUsers.DataSource = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, c.scompanyname, IF(c.bactive = 1, '" & getMessage(Me, "CompanyActive") & "', '" & getMessage(Me, "CompanyInactive") & "') AS bcompanyactive, u.suseremail, ln.slanguagename_" & Session("preferredLanguage") & ", IF(u.bonline = 1, '" & getMessage(Me, "UserOnline") & "', '" & getMessage(Me, "UserOffline") & "') AS bonline, IF(u.bapproved = 1, '" & getMessage(Me, "UserApproved") & "', '" & getMessage(Me, "UserNotApproved") & "') AS bapproved, IF(u.blockedout = 1, '" & getMessage(Me, "UserLockedOut") & "', '" & getMessage(Me, "UserNotLockedOut") & "') AS blockedout, u.iuserlevel, u.sparentusername, u.suserrescuequestion FROM users u JOIN companies c ON u.icompanyid = c.icompanyid LEFT JOIN companyplants cp ON u.icompanyid = cp.icompanyid LEFT JOIN languages l ON u.spreferredlanguage = l.slanguagecode LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid WHERE u.bactive = 0")
        gvUsers.DataBind()

        formatDataGrid()

        lblStatus.Visible = False

        btnShowAll.BackColor = System.Drawing.Color.Lavender
        btnShowActive.BackColor = System.Drawing.Color.Lavender
        btnShowInactive.BackColor = System.Drawing.Color.LightSteelBlue
        btnShowbyNP.BackColor = System.Drawing.Color.Lavender
        btnAddUser.BackColor = System.Drawing.Color.Lavender
        btnUpdateStatus.BackColor = System.Drawing.Color.Lavender

        btnUpdateStatus.Visible = False

        pnlSearchName.Visible = False

    End Sub


    Private Sub btnGoSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGoSearch.Click

        txtNP.Text = txtNP.Text.Trim
        lblErrorC.Visible = False

        Dim dsUsers As DataSet = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, c.scompanyname, IF(c.bactive = 1, '" & getMessage(Me, "CompanyActive") & "', '" & getMessage(Me, "CompanyInactive") & "') AS bcompanyactive, u.suseremail, ln.slanguagename_" & Session("preferredLanguage") & ", IF(u.bonline = 1, '" & getMessage(Me, "UserOnline") & "', '" & getMessage(Me, "UserOffline") & "') AS bonline, IF(u.bapproved = 1, '" & getMessage(Me, "UserApproved") & "', '" & getMessage(Me, "UserNotApproved") & "') AS bapproved, IF(u.blockedout = 1, '" & getMessage(Me, "UserLockedOut") & "', '" & getMessage(Me, "UserNotLockedOut") & "') AS blockedout, u.iuserlevel, u.sparentusername, u.suserrescuequestion FROM users u JOIN companies c ON u.icompanyid = c.icompanyid LEFT JOIN companyplants cp ON u.icompanyid = cp.icompanyid LEFT JOIN languages l ON u.spreferredlanguage = l.slanguagecode LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid WHERE u.susername LIKE '%" & txtNP.Text & "%' OR u.suserfullname LIKE '%" & txtNP.Text & "%' OR u.suserdesiredname LIKE '%" & txtNP.Text & "%' OR c.scompanyname LIKE '%" & txtNP.Text & "%' OR cp.splantname LIKE '%" & txtNP.Text & "%' OR cp.remotesystemandport LIKE '%" & txtNP.Text & "%' OR u.suseremail LIKE '%" & txtNP.Text & "%' OR u.spreferredlanguage LIKE '%" & txtNP.Text & "%' OR ln.slanguagename_" & Session("preferredLanguage") & " LIKE '%" & txtNP.Text & "%' OR u.sparentusername LIKE '%" & txtNP.Text & "%' OR u.suserrescuequestion LIKE '%" & txtNP.Text & "%'")

        If dsUsers.Tables(0).Rows.Count <= 0 Then

            gvUsers.PageIndex = 0

            lblErrorC.Visible = True
            lblErrorC.Text = getMessage(Me, "NoSearchResults")

            Exit Sub

        Else

            gvUsers.PageIndex = 0

            gvUsers.DataSource = dsUsers
            gvUsers.DataBind()

            formatDataGrid()

            btnUpdateStatus.Visible = False

            lblStatus.Visible = False

        End If

    End Sub


    Private Sub btnAddUser_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddUser.Click

        With pnlSetupUser

            If .Visible = True Then

                .Visible = False

                btnShowAll.Enabled = True
                btnShowActive.Enabled = True
                btnShowInactive.Enabled = True
                btnShowbyNP.Enabled = True

                btnShowAll.BackColor = System.Drawing.Color.Lavender
                btnShowActive.BackColor = System.Drawing.Color.Lavender
                btnShowInactive.BackColor = System.Drawing.Color.Lavender
                btnShowbyNP.BackColor = System.Drawing.Color.Lavender
                btnAddUser.BackColor = System.Drawing.Color.Lavender
                btnUpdateStatus.BackColor = System.Drawing.Color.Lavender

                btnAddUser.Text = getMessage(Me, "btnAddUser")

            Else

                .Visible = True

                btnShowAll.Enabled = False
                btnShowActive.Enabled = False
                btnShowInactive.Enabled = False
                btnShowbyNP.Enabled = False

                btnShowAll.BackColor = System.Drawing.Color.LightGray
                btnShowActive.BackColor = System.Drawing.Color.LightGray
                btnShowInactive.BackColor = System.Drawing.Color.LightGray
                btnShowbyNP.BackColor = System.Drawing.Color.LightGray
                btnAddUser.BackColor = System.Drawing.Color.LightSteelBlue
                btnUpdateStatus.BackColor = System.Drawing.Color.LightGray

                btnAddUser.Text = getMessage(Me, "CancelNewUser")

            End If

        End With

    End Sub


    Private Sub btnSetupCA_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSetupCA.Click

        Session("usertype") = "ca" 'c&a employee
        Response.Redirect("addUser.aspx")

    End Sub


    Private Sub btnSetup_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSetup.Click

        Session("usertype") = ""
        Response.Redirect("addUser.aspx")

    End Sub


    Private Sub btnUpdateStatus_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnUpdateStatus.Click

        Dim chk As CheckBox
        Dim queries(gvUsers.Rows.Count) As String
        Dim updateSucceeded As Boolean = True
        Dim status As String = "0"

        Dim dsUsers As DataSet = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, c.scompanyname, IF(c.bactive = 1, '" & getMessage(Me, "CompanyActive") & "', '" & getMessage(Me, "CompanyInactive") & "') AS bcompanyactive, u.suseremail, ln.slanguagename_" & Session("preferredLanguage") & ", IF(u.bonline = 1, '" & getMessage(Me, "UserOnline") & "', '" & getMessage(Me, "UserOffline") & "') AS bonline, IF(u.bapproved = 1, '" & getMessage(Me, "UserApproved") & "', '" & getMessage(Me, "UserNotApproved") & "') AS bapproved, IF(u.blockedout = 1, '" & getMessage(Me, "UserLockedOut") & "', '" & getMessage(Me, "UserNotLockedOut") & "') AS blockedout, u.iuserlevel, u.sparentusername, u.suserrescuequestion FROM users u JOIN companies c ON u.icompanyid = c.icompanyid LEFT JOIN companyplants cp ON u.icompanyid = cp.icompanyid LEFT JOIN languages l ON u.spreferredlanguage = l.slanguagecode LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid WHERE u.susername LIKE '%" & txtNP.Text & "%' OR u.suserfullname LIKE '%" & txtNP.Text & "%' OR u.suserdesiredname LIKE '%" & txtNP.Text & "%' OR c.scompanyname LIKE '%" & txtNP.Text & "%' OR cp.splantname LIKE '%" & txtNP.Text & "%' OR cp.remotesystemandport LIKE '%" & txtNP.Text & "%' OR u.suseremail LIKE '%" & txtNP.Text & "%' OR u.spreferredlanguage LIKE '%" & txtNP.Text & "%' OR ln.slanguagename_" & Session("preferredLanguage") & " LIKE '%" & txtNP.Text & "%' OR u.sparentusername LIKE '%" & txtNP.Text & "%' OR u.suserrescuequestion LIKE '%" & txtNP.Text & "%'")

        If dsUsers.Tables.Count = 0 Then
            Exit Sub
        End If

        If dsUsers.Tables(0).Rows.Count = 0 Then
            Exit Sub
        End If

        With gvUsers

            For i As Integer = 0 To .Rows.Count - 1

                chk = .Rows(i).FindControl("chkActive")

                If chk.Checked = True Then
                    status = "1"
                Else
                    status = "0"
                End If

                queries(i) = "UPDATE users SET bactive = '" & status & "' WHERE susername = '" & dsUsers.Tables(0).Rows(i).Item("susername") & "'"

                If executeTransactedSQLCommand(queries) = False Then
                    updateSucceeded = False
                End If

            Next

        End With

        If updateSucceeded = False Then

            lblStatus.Visible = True
            lblStatus.Text = getMessage(Me, "updateFailed")
            lblStatus.ForeColor = Drawing.Color.Red

        Else

            lblStatus.Visible = True
            lblStatus.Text = getMessage(Me, "updateSucceeded")
            lblStatus.ForeColor = Drawing.Color.LimeGreen

            btnUpdateStatus.Visible = False

            enableDisableStatusCheckboxes(False)

        End If

        btnShowAll.Enabled = True
        btnShowActive.Enabled = True
        btnShowInactive.Enabled = True
        btnShowbyNP.Enabled = True
        btnAddUser.Enabled = True

        btnShowAll.BackColor = System.Drawing.Color.Lavender
        btnShowActive.BackColor = System.Drawing.Color.Lavender
        btnShowInactive.BackColor = System.Drawing.Color.Lavender
        btnShowbyNP.BackColor = System.Drawing.Color.Lavender
        btnAddUser.BackColor = System.Drawing.Color.Lavender
        btnUpdateStatus.BackColor = System.Drawing.Color.Lavender

    End Sub


    Private Sub btnShowbyNP_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowbyNP.Click

        pnlSearchName.Visible = True
        lblErrorC.Visible = False

        btnShowAll.BackColor = System.Drawing.Color.Lavender
        btnShowActive.BackColor = System.Drawing.Color.Lavender
        btnShowInactive.BackColor = System.Drawing.Color.Lavender
        btnShowbyNP.BackColor = System.Drawing.Color.LightSteelBlue

        enableDisableStatusCheckboxes(False)

        btnUpdateStatus.Visible = False

    End Sub


    Private Sub gvUsers_PageIndexChanged(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridPageChangedEventArgs) Handles gvUsers.PageIndexChanged

        gvUsers.PageIndex = e.NewPageIndex

        gvUsers.DataSource = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, c.scompanyname, IF(c.bactive = 1, '" & getMessage(Me, "CompanyActive") & "', '" & getMessage(Me, "CompanyInactive") & "') AS bcompanyactive, u.suseremail, ln.slanguagename_" & Session("preferredLanguage") & ", IF(u.bonline = 1, '" & getMessage(Me, "UserOnline") & "', '" & getMessage(Me, "UserOffline") & "') AS bonline, IF(u.bapproved = 1, '" & getMessage(Me, "UserApproved") & "', '" & getMessage(Me, "UserNotApproved") & "') AS bapproved, IF(u.blockedout = 1, '" & getMessage(Me, "UserLockedOut") & "', '" & getMessage(Me, "UserNotLockedOut") & "') AS blockedout, u.iuserlevel, u.sparentusername, u.suserrescuequestion FROM users u JOIN companies c ON u.icompanyid = c.icompanyid LEFT JOIN companyplants cp ON u.icompanyid = cp.icompanyid LEFT JOIN languages l ON u.spreferredlanguage = l.slanguagecode LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid WHERE u.susername LIKE '%" & txtNP.Text & "%' OR u.suserfullname LIKE '%" & txtNP.Text & "%' OR u.suserdesiredname LIKE '%" & txtNP.Text & "%' OR c.scompanyname LIKE '%" & txtNP.Text & "%' OR cp.splantname LIKE '%" & txtNP.Text & "%' OR cp.remotesystemandport LIKE '%" & txtNP.Text & "%' OR u.suseremail LIKE '%" & txtNP.Text & "%' OR u.spreferredlanguage LIKE '%" & txtNP.Text & "%' OR ln.slanguagename_" & Session("preferredLanguage") & " LIKE '%" & txtNP.Text & "%' OR u.sparentusername LIKE '%" & txtNP.Text & "%' OR u.suserrescuequestion LIKE '%" & txtNP.Text & "%'")
        gvUsers.DataBind()

        formatDataGrid()

    End Sub


    Private Sub gvUsers_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvUsers.RowCommand

        If e.CommandName = "Edit" Then

            Session("userToModify") = e.CommandArgument

            Dim row As GridViewRow = DirectCast(DirectCast(e.CommandSource, LinkButton).NamingContainer, GridViewRow)

            If gvUsers.Rows(row.RowIndex).Cells(5).Text = getSQLQueryAsString("SELECT scompanyname FROM companies WHERE icompanyid = 1") Then
                Session("usertype") = "ca" 'c&a employee
            Else
                Session("usertype") = ""
            End If

            Response.Redirect("modifyUser.aspx")

        ElseIf e.CommandName = "ChangeStatus" Then

            enableDisableStatusCheckboxes(True)

            btnUpdateStatus.Visible = True

            btnShowAll.Enabled = False
            btnShowActive.Enabled = False
            btnShowInactive.Enabled = False
            btnShowbyNP.Enabled = False
            btnAddUser.Enabled = False

            btnShowAll.BackColor = System.Drawing.Color.LightGray
            btnShowActive.BackColor = System.Drawing.Color.LightGray
            btnShowInactive.BackColor = System.Drawing.Color.LightGray
            btnShowbyNP.BackColor = System.Drawing.Color.LightGray
            btnAddUser.BackColor = System.Drawing.Color.LightGray
            btnUpdateStatus.BackColor = System.Drawing.Color.LightSteelBlue

        End If

    End Sub


    Private Sub gvUsers_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvUsers.RowCreated

        If e.Row.RowType = DataControlRowType.Header Then

            Try

                e.Row.Cells(0).Width = 50
                e.Row.Cells(1).Width = 70

                For i As Integer = 0 To 15
                    e.Row.Cells(i).Text = getMessage(Me, "dgHeader" & i)
                    e.Row.Cells(i).HorizontalAlign = HorizontalAlign.Center
                Next

            Catch ex As Exception

            End Try

        End If

    End Sub

End Class