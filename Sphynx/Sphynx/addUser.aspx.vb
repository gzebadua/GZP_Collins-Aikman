Public Partial Class addUser
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        clearanceCheck(Me)

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)
            loadMenu(Me, rptMenu)

            setDataGridlabel()

            PageTitle.Text = getMessage(Me, "PageTitle") & " " & Session("realname") & " - " & getMessage(Me, "lblHeader")

            If Not Session("usertype") = "ca" Then

                lblCompany.Visible = True
                ddlVendors.Visible = True

                dgPermissions.DataSource = getSQLQueryAsDataset("SELECT smoduleId, " & Session("language") & "_title 'title' FROM modules where smoduleid != 'ADM_FIRST' order by smoduleid ASC")
                dgPermissions.DataBind()

                dgPlants.DataSource = "SELECT c.icompanyid, c.scompanyname, cp.iplantid, cp.splantname FROM companies c JOIN companyplants cp where c.bactive = 1 and cp.bactive = 1 order by cp.splantname ASC"
                dgPlants.DataBind()

                Dim lds As DataSet
                lds = getSQLQueryAsDataset("SELECT icompanyid, scompanyname FROM companies WHERE icompanyid > 1 AND bactive = 1 ORDER BY 2")

                For i As Integer = 0 To lds.Tables(0).Rows.Count - 1
                    ddlVendors.Items.Add(lds.Tables(0).Rows(i).Item(1))
                    ddlVendors.Items(ddlVendors.Items.Count - 1).Value = lds.Tables(0).Rows(i).Item(0)
                Next

                ddlVendors.Items.Insert(0, New ListItem(getMessage(Me, "SelectComp")))
                ddlVendors_SelectedIndexChanged(Me, Nothing)

                Dim ut As Integer
                Dim actPerm As String
                Dim chk As CheckBox

                For ut = 0 To dgPermissions.Items.Count - 1
                    actPerm = dgPermissions.DataKeys(ut)
                    If actPerm = "A_MPROF" Then
                        chk = dgPermissions.Items(ut).FindControl("chkMod")
                        chk.Checked = True
                    End If

                Next

            Else

                lblCompany.Visible = False
                ddlVendors.Visible = False
                
                dgPermissions.DataSource = getSQLQueryAsDataset("SELECT smoduleId, " & Session("language") & "_title 'title' FROM modules where smoduleid != 'ADM_FIRST' order by smoduleid ASC")
                dgPermissions.DataBind()

                dgPlants.DataSource = "SELECT c.icompanyid, c.scompanyname, cp.iplantid, cp.splantname FROM companies c JOIN companyplants cp where c.bactive = 1 and cp.bactive = 1 order by cp.splantname ASC"
                dgPlants.DataBind()

                Dim ut As Integer
                Dim actPerm As String
                Dim chk As CheckBox

                For ut = 0 To dgPermissions.Items.Count - 1
                    actPerm = dgPermissions.DataKeys(ut)
                    If actPerm = "A_MPROF" Then
                        chk = dgPermissions.Items(ut).FindControl("chkMod")
                        chk.Checked = True
                    End If

                Next

            End If

            FVUser.ErrorMessage = getMessage(Me, "FVUser")
            FVReal.ErrorMessage = getMessage(Me, "FVReal")
            FVPass.ErrorMessage = getMessage(Me, "FVPass")
            FVConfirm.ErrorMessage = getMessage(Me, "FVConfirm")
            FVConfirm1.ErrorMessage = getMessage(Me, "FVConfirm1")
            RSEmail.ErrorMessage = getMessage(Me, "RSEmail")
            btnSave.Text = getMessage(Me, "btnSave")
            btnVerify.Text = getMessage(Me, "btnVerify")
            lblErr1.Text = getMessage(Me, "LblError1")
            lblErr2.Text = getMessage(Me, "LblError2")
            lblErr3.Text = getMessage(Me, "LblError3")
            txtUsername.ToolTip = getMessage(Me, "Tooltxtusername")
            txtName.ToolTip = getMessage(Me, "Tooltxtname")
            txtPass.ToolTip = getMessage(Me, "Tooltxtpass")
            txtPass2.ToolTip = getMessage(Me, "Tooltxtpass2")
            ddlVendors.ToolTip = getMessage(Me, "Toolddlvendors")
            btnVerify.ToolTip = getMessage(Me, "ToolbtnVerify")
            btnCancel.ToolTip = getMessage(Me, "ToolbtnCancel")

            colorPermissions()

        Else

            ddlVendors.Enabled = True

        End If

    End Sub


    Sub colorPermissions()

        Dim st As Integer

        For st = 0 To dgPermissions.Items.Count - 1

            Select Case Left(dgPermissions.Items(st).Cells(1).Text, 3)
                Case "ADM"
                    dgPermissions.Items(st).BackColor = System.Drawing.ColorTranslator.FromHtml("#FFCCCC")
                Case "VEM"
                    dgPermissions.Items(st).BackColor = System.Drawing.ColorTranslator.FromHtml("#D7FF9B")
                Case "VND"
                    dgPermissions.Items(st).BackColor = System.Drawing.ColorTranslator.FromHtml("#F1C6FF")
            End Select

        Next

    End Sub


    Sub setDataGridlabel()

        With dgPlants

            .Columns(1).HeaderText = getMessage(Me, "PlantsCol1")
            .Columns(2).HeaderText = getMessage(Me, "PlantsCol2")
            .Columns(3).HeaderText = getMessage(Me, "PlantsCol3")
        End With

        With dgPermissions

            .Columns(2).HeaderText = getMessage(Me, "PermCol1")

        End With

    End Sub

    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then

                .Visible = False
                If Not Request.QueryString("usertype") = "ca" Then
                    ddlVendors.Visible = True
                End If

            Else

                .Visible = True
                ddlVendors.Visible = False

            End If

        End With

    End Sub

    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("language") = e.CommandArgument

        'setLabels(Me)

        txtUsername.ToolTip = getMessage(Me, "Tooltxtusername")
        txtName.ToolTip = getMessage(Me, "Tooltxtname")
        txtPass.ToolTip = getMessage(Me, "Tooltxtpass")
        txtPass2.ToolTip = getMessage(Me, "Tooltxtpass2")
        ddlVendors.ToolTip = getMessage(Me, "Toolddlvendors")
        btnVerify.ToolTip = getMessage(Me, "ToolbtnVerify")
        btnCancel.ToolTip = getMessage(Me, "ToolbtnCancel")

        Dim path() As String = Me.Request.FilePath.Split("/")
        Me.Response.Redirect(path(path.Length - 1))

        'fillDatagrid("SELECT moduleId, " & Session("language") & "_title 'title' FROM module where moduleid != 'ADM_FIRST' ORDER BY title ASC", dgPermissions)
        'fillDatagrid("SELECT pfid, company, facility, name FROM companies where Active= '1' ORDER BY name ASC", dgPlants)
        'setDataGridlabel()
        'ddlVendors.Items.Clear()
        'Dim lds As DataSet
        'lds = GetVendors()
        'For i As Integer = 0 To lds.Tables(0).Rows.Count - 1
        '    ddlVendors.Items.Add(lds.Tables(0).Rows(i).Item(1))
        '    ddlVendors.Items(ddlVendors.Items.Count - 1).Value = lds.Tables(0).Rows(i).Item(0)
        'Next
        ''ddlVendors.Items.Insert(0, New ListItem(getMessage(Me,"SelectComp")))

    End Sub


    Private Sub chkCheckAllModuleCheckboxes_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkCheckAllModuleCheckboxes.CheckedChanged

        Dim cht As CheckBox

        For i As Integer = 0 To dgPermissions.Items.Count - 1

            cht = dgPermissions.Items(i).FindControl("chkMod")
            cht.Checked = chkCheckAllModuleCheckboxes.Checked

        Next

    End Sub


    Private Sub chkCheckAllPlantsCheckboxes_CheckedChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles chkCheckAllPlantsCheckboxes.CheckedChanged

        Dim cht As CheckBox

        For i As Integer = 0 To dgPlants.Items.Count - 1

            cht = dgPlants.Items(i).FindControl("chkPlant")
            cht.Checked = chkCheckAllPlantsCheckboxes.Checked

        Next

    End Sub


    Private Sub btnSave_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSave.Click

        If txtEmail.Text = "" Then
            RSEmail.Enabled = False
        End If

        txtUsername.Text = txtUsername.Text.Trim()
        txtEmail.Text = txtEmail.Text.Trim()
        txtUsername.Text = txtUsername.Text.Replace("'", "")
        txtUsername.Text = txtUsername.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
        txtName.Text = txtName.Text.Trim()
        txtName.Text = txtName.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
        txtPass.Text = txtPass.Text.Trim()
        txtPass.Text = txtPass.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
        txtPass2.Text = txtPass2.Text.Trim()
        txtPass2.Text = txtPass2.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
        lblErr1.Visible = False
        lblErr2.Visible = False
        lblErr3.Visible = False

        If verifyIfUserExists(txtUsername.Text) = True Then

            If Not txtUsername.Text = "" Then

                lblUserExists.Visible = True
                lblUserExists.Text = getMessage(Me, "userExists")
                lblUserExists.ForeColor = System.Drawing.Color.Red

            End If

        Else

            lblUserExists.Visible = True
            lblUserExists.Text = getMessage(Me, "userNotExists")
            lblUserExists.ForeColor = System.Drawing.Color.Green

            Dim i As Integer
            Dim contador As Integer
            contador = 0
            Dim cht As CheckBox

            For i = 0 To dgPermissions.Items.Count - 1

                cht = dgPermissions.Items(i).FindControl("chkMod")

                If cht.Checked Then
                    contador = contador + 1
                End If

            Next

            If contador = 0 Then

                lblErr1.Visible = True
                Exit Sub

            Else

                Dim i2 As Integer
                Dim contador2 As Integer
                contador2 = 0
                Dim cht2 As CheckBox

                For i = 0 To dgPlants.Items.Count - 1

                    cht2 = dgPlants.Items(i).FindControl("chkPlant")
                    If cht2.Checked Then
                        contador2 = contador2 + 1
                    End If

                Next

                If contador2 = 0 Then

                    lblErr2.Visible = True
                    Exit Sub

                Else

                    'acá iniciamos a meter a la base de datos 
                    'iniciamos con la tabla usuarios

                    'Dim transaccion As OleDbTransaction
                    'Dim strconnect As String = "Provider=SQLOLEDB.1;data source=bloquesis.qro.itesm.mx;initial catalog=sphynxdb;user id=ligerdb;Password=solutionsdb"
                    'Dim objCon As New OleDbConnection(strconnect)

                    'transaccion = objCon.BeginTransaction
                    'Try

                    Dim valida1 As Boolean = True
                    Dim valida2 As Boolean = True
                    Dim valida3 As Boolean = True

                    If Request.QueryString("usertype") = "ca" Then

                        'si es usuario c&a
                        valida1 = insertValidUser(txtUsername.Text, txtPass.Text, txtName.Text, 0, txtEmail.Text, Session("username"))

                    Else

                        'si es usuario vendor
                        If ddlVendors.SelectedValue = "" Or ddlVendors.SelectedValue = getMessage(Me, "SelectComp") Then
                            lblErr3.Visible = True
                            Exit Sub
                        Else

                            Dim vendor As Integer
                            vendor = ddlVendors.SelectedItem.Value
                            valida1 = insertValidUser(txtUsername.Text, txtPass.Text, txtName.Text, vendor, txtEmail.Text, Session("username"))
                        End If

                    End If

                    'iniciamos con los ciclos de la tabla de permisos

                    For i = 0 To dgPermissions.Items.Count - 1
                        cht = dgPermissions.Items(i).FindControl("chkMod")
                        If cht.Checked Then

                            If Not insertUserPermission(txtUsername.Text, dgPermissions.DataKeys(i), Session("username")) Then
                                valida2 = False
                            End If
                        End If

                    Next

                    'iniciamos con los ciclos de la tabla de userFacility

                    For i = 0 To dgPlants.Items.Count - 1
                        cht2 = dgPlants.Items(i).FindControl("chkPlant")
                        If cht2.Checked Then

                            If Not insertUserFacility(txtUsername.Text, dgPlants.DataKeys(i), Session("username")) Then
                                valida3 = False
                            End If
                        End If

                    Next

                    If Not (valida1 And valida2 And valida3) Then

                        If valida1 = False Then
                            executeSQLCommand("DELETE FROM users where username = '" & txtUsername.Text & "'")
                        End If

                        If valida2 = False Then
                            executeSQLCommand("DELETE FROM permission where username = '" & txtUsername.Text & "'")
                        End If

                        If valida3 = False Then
                            executeSQLCommand("DELETE FROM userFacility where username ='" & txtUsername.Text & "'")
                        End If

                        lblErr1.Text = getMessage(Me, "AddFailure")
                        Exit Sub

                    End If

                    'Ahora, si todo va bien, nos lleva a la página de despliega usuarios.

                    Response.Redirect("displayUsers.aspx")

                End If

            End If

        End If

    End Sub


    Private Sub btnVerify_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnVerify.Click

        ddlVendors.Enabled = True
        btnSave.Enabled = True
        RSEmail.Enabled = True

        txtUsername.Text = txtUsername.Text.Trim()
        txtUsername.Text = txtUsername.Text.Replace("'", "")
        txtUsername.Text = txtUsername.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")

        If verifyIfUserExists(txtUsername.Text) Then

            If Not txtUsername.Text = "" Then
                lblUserExists.Visible = True
                lblUserExists.Text = getMessage(Me, "userExists")
                lblUserExists.ForeColor = System.Drawing.Color.Red
            End If

        Else

            If Not txtUsername.Text = "" Then

                lblUserExists.Visible = True
                lblUserExists.Text = getMessage(Me, "userNotExists")
                lblUserExists.ForeColor = System.Drawing.Color.Green

            End If

        End If
    End Sub


    Private Sub ddlVendors_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles ddlVendors.SelectedIndexChanged

    End Sub


    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click
        Response.Redirect("displayUsers.aspx")
    End Sub


End Class