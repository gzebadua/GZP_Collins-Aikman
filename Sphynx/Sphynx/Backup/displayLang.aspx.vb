Partial Public Class displayLang
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        clearanceCheck(Me)

        If Not IsPostBack Then

            showFlags(rptFlags)
            setLabels(Me)
            loadMenu(Me, rptMenu)

            gvLabels.DataSource = getSQLQueryAsDataset("SELECT * FROM labels")
            gvLabels.DataBind()

            formatDataGrid()

            lblWelcomeName.Text = Session("desiredName")
            lblWelcomeCompany.Text = Session("companyName")

            PageTitle.Text = getMessage(Me, "PageTitle") & " - " & Session("fullName")

            If permissionCheck(Session("username"), "", "addLanguage") = False Then
                btnAddLanguage.Visible = False
            End If

            txtNP.Attributes.Add("onkeydown", "if(event.which || event.keyCode){if ((event.which == 13) || (event.keyCode == 13)) {document.getElementById('" + btnGoSearch.UniqueID + "').click();return false;}} else {return true}; ")

        End If

    End Sub


    Sub formatDataGrid()

        Dim tlnb As LinkButton

        With gvLabels

            For i As Integer = 0 To .Rows.Count - 1

                tlnb = .Rows(i).FindControl("lnkEdit")
                tlnb.Text = getMessage(Me, "lnkEdit")

                tlnb = .Rows(i).FindControl("lnkDelete")
                tlnb.Text = getMessage(Me, "lnkDelete")

            Next

        End With

        formatDataGridHeaders()

    End Sub


    Sub formatDataGridHeaders()

        Dim dheaders As DataSet = getSQLQueryAsDataset("SELECT ln.ilanguageid,  l.slanguagecode, ln.slanguagename_" & Session("preferredLanguage") & " FROM languagenames ln JOIN languages l ON l.ilanguageid = ln.ilanguageid")

        Try

            gvLabels.HeaderRow.Cells(1).Text = getMessage(Me, "dgHeader1")
            gvLabels.HeaderRow.Cells(1).HorizontalAlign = HorizontalAlign.Center

            gvLabels.HeaderRow.Cells(2).Text = getMessage(Me, "dgHeader2")
            gvLabels.HeaderRow.Cells(2).HorizontalAlign = HorizontalAlign.Center

            For i As Integer = 3 To dheaders.Tables(0).Rows.Count - 1 + 3
                gvLabels.HeaderRow.Cells(i).Text = dheaders.Tables(0).Rows(i - 3).Item("slanguagename_" & Session("preferredLanguage"))
                gvLabels.HeaderRow.Cells(i).HorizontalAlign = HorizontalAlign.Center
            Next

        Catch ex As Exception

        End Try

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

        PageTitle.Text = getMessage(Me, "PageTitle") & " - " & Session("realname")

    End Sub


    Private Sub btnShowAll_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowAll.Click

        txtNP.Text = ""

        gvLabels.PageIndex = 0

        gvLabels.DataSource = getSQLQueryAsDataset("SELECT * FROM labels")
        gvLabels.DataBind()

        formatDataGrid()

        btnShowAll.BackColor = System.Drawing.Color.LightSteelBlue
        btnFilter.BackColor = System.Drawing.Color.Lavender
        btnAddLanguage.BackColor = System.Drawing.Color.Lavender
        btnAddLabel.BackColor = System.Drawing.Color.Lavender

        pnlSearchName.Visible = False

    End Sub


    Private Sub btnGoSearch_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnGoSearch.Click

        txtNP.Text = txtNP.Text.Trim
        lblErrorC.Visible = False

        Dim query As String = "SELECT * FROM labels WHERE spage LIKE '%" & txtNP.Text & "%' OR slabel LIKE '%" & txtNP.Text & "%' "

        Dim langColumns As DataSet = getSQLQueryAsDataset("SELECT slanguagecode FROM languages l JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")

        For i = 0 To langColumns.Tables(0).Rows.Count - 1

            query = query & "OR " & langColumns.Tables(0).Rows(i).Item(0) & " LIKE '%" & txtNP.Text & "%' "

        Next i

        Dim dsLabels As DataSet = getSQLQueryAsDataset(query)

        If dsLabels.Tables(0).Rows.Count <= 0 Then

            gvLabels.PageIndex = 0

            lblErrorC.Visible = True
            lblErrorC.Text = getMessage(Me, "NoSearchResults")

            Exit Sub

        Else

            gvLabels.PageIndex = 0

            gvLabels.DataSource = dsLabels
            gvLabels.DataBind()

            formatDataGrid()

        End If

    End Sub


    Private Sub btnAddLanguage_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddLanguage.Click

        With pnlNewLang

            If .Visible = True Then

                executeSQLCommand("DELETE FROM languages WHERE slanguagecode = '' AND blive = 0")

                .Visible = False

                gvLabels.Visible = True

                btnShowAll.Enabled = True
                btnFilter.Enabled = True
                btnAddLabel.Enabled = True

                btnShowAll.BackColor = System.Drawing.Color.Lavender
                btnFilter.BackColor = System.Drawing.Color.Lavender
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

                btnAddLanguage.Text = getMessage(Me, "btnAddLanguage")

            Else

                .Visible = True

                gvLabels.Visible = False

                btnShowAll.Enabled = False
                btnFilter.Enabled = False
                btnAddLabel.Enabled = False

                btnShowAll.BackColor = System.Drawing.Color.LightGray
                btnFilter.BackColor = System.Drawing.Color.LightGray
                btnAddLanguage.BackColor = System.Drawing.Color.LightSteelBlue
                btnAddLabel.BackColor = System.Drawing.Color.LightGray

                btnAddLanguage.Text = getMessage(Me, "CancelNewLanguage")

                lblLangAlreadyInUse.Visible = False
                txtNewLangID.Text = ""

                Dim newlangid As Integer = 1
                newlangid = getSQLQueryAsInteger("SELECT IF(MAX(ilanguageid) + 1 IS NULL, 1, MAX(ilanguageid) + 1) AS ilanguageid FROM languages LIMIT 1")

                executeSQLCommand("INSERT IGNORE INTO languages VALUES(" & newlangid & ", '', 0)")

                Dim langDef As DataSet
                langDef = getSQLQueryAsDataset("SELECT IF(ln.ilanguageid IS NULL, MAX(l.ilanguageid), ln.ilanguageid) AS ilanguageid, l.slanguagecode, IF(ln.slanguagename_" & Session("preferredLanguage") & " IS NULL, '" & getMessage(Me, "NewLanguage") & "', ln.slanguagename_" & Session("preferredLanguage") & ") AS slanguagename_" & Session("preferredLanguage") & " FROM languages l LEFT JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid GROUP BY l.ilanguageid")
                rptLangName.DataSource = langDef
                rptLangName.DataBind()

                Dim tlbl As Label

                For i As Integer = 0 To rptLangName.Items.Count - 1
                    tlbl = rptLangName.Items(i).FindControl("lblLangName")
                    tlbl.Text = langDef.Tables(0).Rows(i).Item(2)
                Next

            End If

        End With

        pnlSearchName.Visible = False

    End Sub


    Private Sub btnFilter_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnFilter.Click

        pnlSearchName.Visible = True
        lblErrorC.Visible = False

        btnShowAll.BackColor = System.Drawing.Color.Lavender
        btnFilter.BackColor = System.Drawing.Color.LightSteelBlue
        btnAddLanguage.BackColor = System.Drawing.Color.Lavender
        btnAddLabel.BackColor = System.Drawing.Color.Lavender

    End Sub


    Private Sub btnSaveNewLang_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveNewLang.Click

        txtNewLangID.Text = txtNewLangID.Text.Trim
        txtNewLangID.Text = txtNewLangID.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")

        Dim dlang As DataSet = getSQLQueryAsDataset("SELECT ln.ilanguageid, l.slanguagecode, ln.slanguagename_" & Session("preferredLanguage") & " FROM languagenames ln JOIN languages l ON l.ilanguageid = ln.ilanguageid")

        If txtNewLangID.Text = "" Then

            lblLangAlreadyInUse.Text = getMessage(Me, "LanguageCodeRequired")
            lblLangAlreadyInUse.Visible = True
            Exit Sub

        End If

        For i As Integer = 0 To dlang.Tables(0).Rows.Count - 1

            If dlang.Tables(0).Rows(i).Item("slanguagecode") = txtNewLangID.Text Then
                lblLangAlreadyInUse.Text = getMessage(Me, "LanguageAlreadyInUse")
                lblLangAlreadyInUse.Visible = True
                Exit Sub
            End If

        Next

        Dim countLangs As Integer = dlang.Tables(0).Rows.Count
        Dim tDs(countLangs) As String 'No es -1 porque estamos agregando el nuevo ahorita...

        Dim ttxt As TextBox

        For i As Integer = 0 To rptLangName.Items.Count - 1

            ttxt = rptLabels.Items(i).FindControl("txtNewLangName")
            ttxt.Text = ttxt.Text.Trim
            ttxt.Text = ttxt.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")

            If ttxt.Text = "" Then

                lblLangAlreadyInUse.Text = getMessage(Me, "LanguagesNamesRequired")
                lblLangAlreadyInUse.Visible = True
                Exit Sub

            Else

                tDs(i) = ttxt.Text.Replace("á", "&aacute;").Replace("é", "&eacute;").Replace("í", "&iacute;").Replace("ó", "&oacute;").Replace("ú", "&uacute;").Replace("Á", "&Aacute;").Replace("É", "&Eacute;").Replace("Í", "&Iacute;").Replace("Ó", "&Oacute;").Replace("Ú", "&Uacute;").Replace("ñ", "&ntilde;").Replace("Ñ", "&Ntilde;").Replace("à", "&agrave;").Replace("è", "&egrave;").Replace("ì", "&igrave;").Replace("ò", "&ograve;").Replace("ù", "&ugrave;").Replace("À", "&Agrave;").Replace("È", "&Egrave;").Replace("Ì", "&Igrave;").Replace("Ò", "&Ograve;").Replace("Ù", "&Ugrave;").Replace("â", "&acirc;").Replace("ê", "&ecirc;").Replace("î", "&icirc;").Replace("ô", "&ocirc;").Replace("û", "&ucirc;").Replace("Â", "&Acirc;").Replace("Ê", "&Ecirc;").Replace("Î", "&Icirc;").Replace("Ô", "&Ocirc;").Replace("Û", "&Ucirc;")

            End If

        Next

        Dim newlangid As Integer = 0
        newlangid = getSQLQueryAsInteger("SELECT ilanguageid FROM languages WHERE slanguagecode = '' AND blive = 0 LIMIT 1")

        Dim queriesNewLangPart1(4) As String

        queriesNewLangPart1(0) = "UPDATE languages SET slanguagecode = '" & txtNewLangID.Text & "' WHERE ilanguageid = " & newlangid & " AND blive = 0"

        queriesNewLangPart1(1) = "ALTER TABLE languagenames ADD slanguagename_" & txtNewLangID.Text & " varchar(100)"
        queriesNewLangPart1(2) = "UPDATE languagenames SET slanguagename_" & txtNewLangID.Text & " = ''"

        queriesNewLangPart1(3) = "INSERT INTO languagenames VALUES(" & newlangid

        For i As Integer = 0 To tDs.Length - 1
            queriesNewLangPart1(3) &= ", '" & tDs(i) & "'"
        Next

        queriesNewLangPart1(3) &= ")"

        If executeTransactedSQLCommand(queriesNewLangPart1) = True Then

            Dim queriesNewLangPart2(6) As String

            queriesNewLangPart2(0) = "ALTER TABLE labels ADD " & txtNewLangID.Text & " varchar(7000) "
            queriesNewLangPart2(1) = "UPDATE labels SET " & txtNewLangID.Text & " = ''"

            queriesNewLangPart2(2) = "ALTER TABLE modules ADD " & txtNewLangID.Text & "_title varchar(70) "
            queriesNewLangPart2(3) = "ALTER TABLE modules ADD " & txtNewLangID.Text & "_description varchar(150) "
            queriesNewLangPart2(4) = "UPDATE modules SET " & txtNewLangID.Text & "_title = ''"
            queriesNewLangPart2(5) = "UPDATE modules SET " & txtNewLangID.Text & "_description = ''"

            If executeTransactedSQLCommand(queriesNewLangPart2) = True Then

                pnlNewLang.Visible = False

                gvLabels.DataSource = getSQLQueryAsDataset("SELECT * FROM labels")
                gvLabels.DataBind()

                lblLangAlreadyInUse.Text = ""
                lblLangAlreadyInUse.Visible = False

                btnShowAll.Enabled = True
                btnFilter.Enabled = True
                btnAddLanguage.Enabled = True
                btnAddLabel.Enabled = True

                btnShowAll.BackColor = System.Drawing.Color.LightSteelBlue
                btnFilter.BackColor = System.Drawing.Color.Lavender
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

            Else

                executeSQLCommand("ALTER TABLE labels DROP " & txtNewLangID.Text)
                executeSQLCommand("ALTER TABLE modules DROP " & txtNewLangID.Text & "_title")
                executeSQLCommand("ALTER TABLE modules DROP " & txtNewLangID.Text & "_description")

                executeSQLCommand("UPDATE languages SET slanguagecode = '' WHERE ilanguageid = " & newlangid & " AND blive = 0")
                executeSQLCommand("ALTER TABLE languagenames DROP slanguagename_" & txtNewLangID.Text)
                executeSQLCommand("DELETE FROM languagenames WHERE ilanguageid = " & newlangid)

                lblLangAlreadyInUse.Text = getMessage(Me, "NewLangError2")
                lblLangAlreadyInUse.Visible = True
                Exit Sub

            End If

        Else

            executeSQLCommand("UPDATE languages SET slanguagecode = '' WHERE ilanguageid = " & newlangid & " AND blive = 0")
            executeSQLCommand("ALTER TABLE languagenames DROP slanguagename_" & txtNewLangID.Text)
            executeSQLCommand("DELETE FROM languagenames WHERE ilanguageid = " & newlangid)

            lblLangAlreadyInUse.Text = getMessage(Me, "NewLangError")
            lblLangAlreadyInUse.Visible = True
            Exit Sub

        End If

    End Sub


    Private Sub btnAddLabel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnAddLabel.Click

        With pnlNewLabel

            If .Visible = True Then

                .Visible = False

                gvLabels.Visible = True

                btnShowAll.Enabled = True
                btnFilter.Enabled = True
                btnAddLabel.Enabled = True
                btnAddLanguage.Enabled = True

                btnShowAll.BackColor = System.Drawing.Color.Lavender
                btnFilter.BackColor = System.Drawing.Color.Lavender
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

                btnAddLabel.Text = getMessage(Me, "btnAddLabel")

            Else

                .Visible = True

                gvLabels.Visible = False

                lblHeader.Visible = False
                btnShowAll.Enabled = False
                btnFilter.Enabled = False
                btnAddLanguage.Enabled = False

                btnShowAll.BackColor = System.Drawing.Color.LightGray
                btnFilter.BackColor = System.Drawing.Color.LightGray
                btnAddLanguage.BackColor = System.Drawing.Color.LightGray
                btnAddLabel.BackColor = System.Drawing.Color.LightSteelBlue

                btnAddLabel.Text = getMessage(Me, "CancelEdit")

                lblLangAlreadyInUse.Visible = False
                btnModify.Visible = False
                btnDelete.Visible = False

                txtNewLangID.Text = ""
                txtNewPage.Text = ""
                txtNewLabel.Text = ""

            End If

        End With

    End Sub


    Private Sub btnCancel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCancel.Click

        pnlEdit.Visible = False

        btnShowAll.Enabled = True
        btnFilter.Enabled = True
        btnAddLabel.Enabled = True
        btnAddLanguage.Enabled = True

        Session("RefCommand") = ""
        Session("RefPage") = ""
        Session("RefLabel") = ""

        btnShowAll.BackColor = System.Drawing.Color.Lavender
        btnFilter.BackColor = System.Drawing.Color.Lavender
        btnAddLanguage.BackColor = System.Drawing.Color.Lavender
        btnAddLabel.BackColor = System.Drawing.Color.Lavender

        btnAddLabel.Text = getMessage(Me, "btnAddLabel")

        gvLabels.Visible = True

        'If Session("RefCommand") = "New" Then

        '    executeSQLCommand("DELETE FROM labels WHERE spage = '" & Session("RefPage") & "' AND slabel = '" & Session("RefLabel") & "'")

        '    Session("RefPage") = ""
        '    Session("RefLabel") = ""
        '    Session("RefCommand") = ""

        'End If

    End Sub


    Private Sub btnSaveLabel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveLabel.Click

        Dim langDS As DataSet = getSQLQueryAsDataset("SELECT ln.ilanguageid,  l.slanguagecode, ln.slanguagename_" & Session("preferredLanguage") & " FROM languagenames ln JOIN languages l ON l.ilanguageid = ln.ilanguageid")
        Dim countLangs As Integer = langDS.Tables(0).Rows.Count
        Dim tDs(countLangs - 1) As String

        Dim ttxt As TextBox

        For i As Integer = 0 To rptLabels.Items.Count - 1
            ttxt = rptLabels.Items(i).FindControl("txtNewLabel")
            ttxt.Text = ttxt.Text.Trim
            ttxt.Text = ttxt.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
            tDs(i) = ttxt.Text.Replace("á", "&aacute;").Replace("é", "&eacute;").Replace("í", "&iacute;").Replace("ó", "&oacute;").Replace("ú", "&uacute;").Replace("Á", "&Aacute;").Replace("É", "&Eacute;").Replace("Í", "&Iacute;").Replace("Ó", "&Oacute;").Replace("Ú", "&Uacute;").Replace("ñ", "&ntilde;").Replace("Ñ", "&Ntilde;").Replace("à", "&agrave;").Replace("è", "&egrave;").Replace("ì", "&igrave;").Replace("ò", "&ograve;").Replace("ù", "&ugrave;").Replace("À", "&Agrave;").Replace("È", "&Egrave;").Replace("Ì", "&Igrave;").Replace("Ò", "&Ograve;").Replace("Ù", "&Ugrave;").Replace("â", "&acirc;").Replace("ê", "&ecirc;").Replace("î", "&icirc;").Replace("ô", "&ocirc;").Replace("û", "&ucirc;").Replace("Â", "&Acirc;").Replace("Ê", "&Ecirc;").Replace("Î", "&Icirc;").Replace("Ô", "&Ocirc;").Replace("Û", "&Ucirc;")
        Next

        Dim queryInsert As String

        queryInsert = "INSERT INTO labels VALUES('" & Session("RefPage") & "','" & Session("RefLabel") & "'"
        For i As Integer = 0 To tDs.Length - 1
            queryInsert &= ", '" & tDs(i) & "'"
        Next

        queryInsert &= ")"

        If executeSQLCommand(queryInsert) = True Then

            pnlEdit.Visible = False
            pnlNewLabel.Visible = False

            lblSaveError.Visible = False

            txtNewPage.Text = ""
            txtNewLabel.Text = ""

            Session("RefCommand") = ""
            Session("RefPage") = ""
            Session("RefLabel") = ""

            btnShowAll.Enabled = True
            btnFilter.Enabled = True
            btnAddLabel.Enabled = True
            btnAddLanguage.Enabled = True

            If txtNP.Text.Trim <> "" And txtNP.Visible = True Then

                btnShowAll.BackColor = System.Drawing.Color.Lavender
                btnFilter.BackColor = System.Drawing.Color.LightSteelBlue
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

            Else

                btnShowAll.BackColor = System.Drawing.Color.LightSteelBlue
                btnFilter.BackColor = System.Drawing.Color.Lavender
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

            End If

            btnAddLabel.Text = getMessage(Me, "btnAddLabel")

            Dim query As String = "SELECT * FROM labels WHERE spage LIKE '%" & txtNP.Text & "%' OR slabel LIKE '%" & txtNP.Text & "%' "

            Dim langColumns As DataSet = getSQLQueryAsDataset("SELECT slanguagecode FROM languages l JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")

            For i = 0 To langColumns.Tables(0).Rows.Count - 1

                query = query & "OR " & langColumns.Tables(0).Rows(i).Item(0) & " LIKE '%" & txtNP.Text & "%' "

            Next i

            gvLabels.DataSource = getSQLQueryAsDataset(query)
            gvLabels.DataBind()

            formatDataGrid()

        Else

            lblSaveError.Visible = True
            lblSaveError.Text = getMessage(Me, "ErrorSavingLabel")
            Exit Sub

        End If

    End Sub


    Private Sub btnCreateNewLabel_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCreateNewLabel.Click

        txtNewPage.Text = txtNewPage.Text.Trim
        txtNewPage.Text = txtNewPage.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
        txtNewLabel.Text = txtNewLabel.Text.Trim
        txtNewLabel.Text = txtNewLabel.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")

        If txtNewPage.Text <> "" And txtNewLabel.Text <> "" Then

            If getSQLQueryAsString("SELECT slabel FROM labels WHERE spage = '" & txtNewPage.Text & "' AND slabel = '" & txtNewLabel.Text & "'") = "" Then

                pnlNewLabel.Visible = False
                pnlEdit.Visible = True

                pnlEdit.Height = pnlData.Height

                lblHeader.Visible = True
                lblLabel.Visible = True

                lblSaveError.Visible = False

                btnShowAll.Enabled = False
                btnFilter.Enabled = False
                btnAddLanguage.Enabled = False
                btnAddLabel.Enabled = False

                btnShowAll.BackColor = System.Drawing.Color.LightGray
                btnFilter.BackColor = System.Drawing.Color.LightGray
                btnAddLanguage.BackColor = System.Drawing.Color.LightGray
                btnAddLabel.BackColor = System.Drawing.Color.LightGray

                lblLangAlreadyInUse.Visible = False
                btnModify.Visible = False

                txtNewLangID.Text = ""

                btnAddLabel.Text = getMessage(Me, "CancelEdit")

                Dim langDS As DataSet = getSQLQueryAsDataset("SELECT ln.ilanguageid,  l.slanguagecode, ln.slanguagename_" & Session("preferredLanguage") & " FROM languagenames ln JOIN languages l ON l.ilanguageid = ln.ilanguageid")

                rptLabels.DataSource = langDS
                rptLabels.DataBind()

                Dim tlbl As Label

                For i As Integer = 0 To rptLabels.Items.Count - 1
                    tlbl = rptLabels.Items(i).FindControl("dgLang")
                    tlbl.Text = langDS.Tables(0).Rows(i).Item(1)
                Next

                btnCancel.Text = getMessage(Me, "btnCancel")

                lblHeader.Text = txtNewPage.Text
                lblLabel.Text = txtNewLabel.Text
                Session("RefCommand") = "New"

            Else

                lblLabelAlreadyExists.Text = getMessage(Me, "LabelAlreadyExists")
                lblLabelAlreadyExists.Visible = True
                Exit Sub

            End If

        Else

            lblLabelAlreadyExists.Text = getMessage(Me, "PageNameAndLabelNameRequired")
            lblLabelAlreadyExists.Visible = True

        End If

    End Sub


    Private Sub btnModify_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnModify.Click

        Dim langDS As DataSet = getSQLQueryAsDataset("SELECT ln.ilanguageid,  l.slanguagecode, ln.slanguagename_" & Session("preferredLanguage") & " FROM languagenames ln JOIN languages l ON l.ilanguageid = ln.ilanguageid")
        Dim countLangs As Integer = langDS.Tables(0).Rows.Count
        Dim tDs(countLangs - 1) As String

        Dim ttxt As TextBox

        For i As Integer = 0 To rptLabels.Items.Count - 1
            ttxt = rptLabels.Items(i).FindControl("txtNewLabel")
            ttxt.Text = ttxt.Text.Trim
            ttxt.Text = ttxt.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
            tDs(i) = ttxt.Text.Replace("á", "&aacute;").Replace("é", "&eacute;").Replace("í", "&iacute;").Replace("ó", "&oacute;").Replace("ú", "&uacute;").Replace("Á", "&Aacute;").Replace("É", "&Eacute;").Replace("Í", "&Iacute;").Replace("Ó", "&Oacute;").Replace("Ú", "&Uacute;").Replace("ñ", "&ntilde;").Replace("Ñ", "&Ntilde;").Replace("à", "&agrave;").Replace("è", "&egrave;").Replace("ì", "&igrave;").Replace("ò", "&ograve;").Replace("ù", "&ugrave;").Replace("À", "&Agrave;").Replace("È", "&Egrave;").Replace("Ì", "&Igrave;").Replace("Ò", "&Ograve;").Replace("Ù", "&Ugrave;").Replace("â", "&acirc;").Replace("ê", "&ecirc;").Replace("î", "&icirc;").Replace("ô", "&ocirc;").Replace("û", "&ucirc;").Replace("Â", "&Acirc;").Replace("Ê", "&Ecirc;").Replace("Î", "&Icirc;").Replace("Ô", "&Ocirc;").Replace("Û", "&Ucirc;")
        Next

        Dim queryUpdate As String

        queryUpdate = "UPDATE labels SET slabel = '" & Session("RefLabel") & "'"
        For i As Integer = 0 To (tDs.Length) - 1
            queryUpdate &= ", " & langDS.Tables(0).Rows(i).Item(0) & " = '" & tDs(i) & "'"
        Next
        queryUpdate &= " WHERE spage = '" & Session("RefPage") & "' AND slabel = '" & Session("RefLabel") & "'"

        If executeSQLCommand(queryUpdate) = True Then

            pnlEdit.Visible = False
            pnlNewLabel.Visible = False

            lblSaveError.Visible = False

            txtNewPage.Text = ""
            txtNewLabel.Text = ""

            Session("RefCommand") = ""
            Session("RefPage") = ""
            Session("RefLabel") = ""

            btnShowAll.Enabled = True
            btnFilter.Enabled = True
            btnAddLabel.Enabled = True
            btnAddLanguage.Enabled = True

            If txtNP.Text.Trim <> "" And txtNP.Visible = True Then

                btnShowAll.BackColor = System.Drawing.Color.Lavender
                btnFilter.BackColor = System.Drawing.Color.LightSteelBlue
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

            Else

                btnShowAll.BackColor = System.Drawing.Color.LightSteelBlue
                btnFilter.BackColor = System.Drawing.Color.Lavender
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

            End If

            btnAddLabel.Text = getMessage(Me, "btnAddLabel")

            Dim query As String = "SELECT * FROM labels WHERE spage LIKE '%" & txtNP.Text & "%' OR slabel LIKE '%" & txtNP.Text & "%' "

            Dim langColumns As DataSet = getSQLQueryAsDataset("SELECT slanguagecode FROM languages l JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")

            For i = 0 To langColumns.Tables(0).Rows.Count - 1

                query = query & "OR " & langColumns.Tables(0).Rows(i).Item(0) & " LIKE '%" & txtNP.Text & "%' "

            Next i

            gvLabels.DataSource = getSQLQueryAsDataset(query)
            gvLabels.DataBind()

            formatDataGrid()

        Else
            lblSaveError.Visible = True
            lblSaveError.Text = getMessage(Me, "ErrorSavingLabel")
            Exit Sub

        End If

    End Sub


    Private Sub btnDelete_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnDelete.Click

        pnlDeleteWarning.Visible = True
        pnlEdit.Visible = False

    End Sub


    Private Sub lblLogout_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles lblLogout.Click

        If logLogout(Me, Session("username"), findRemoteIP(Me), findRemoteMachineName) = True Then
            Response.Redirect("login.aspx")
        End If

    End Sub


    Private Sub gvLabels_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvLabels.PageIndexChanging

        gvLabels.PageIndex = e.NewPageIndex

        Dim query As String = "SELECT * FROM labels WHERE spage LIKE '%" & txtNP.Text & "%' OR slabel LIKE '%" & txtNP.Text & "%' "

        Dim langColumns As DataSet = getSQLQueryAsDataset("SELECT slanguagecode FROM languages l JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")

        For i = 0 To langColumns.Tables(0).Rows.Count - 1

            query = query & "OR " & langColumns.Tables(0).Rows(i).Item(0) & " LIKE '%" & txtNP.Text & "%' "

        Next i

        gvLabels.DataSource = getSQLQueryAsDataset(query)
        gvLabels.DataBind()

        formatDataGrid()

    End Sub


    Private Sub gvLabels_RowCommand(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewCommandEventArgs) Handles gvLabels.RowCommand

        If e.CommandName = "Edit" Then

            Dim row As GridViewRow = DirectCast(DirectCast(e.CommandSource, LinkButton).NamingContainer, GridViewRow)

            Session("RefCommand") = "Edit"
            Session("RefPage") = gvLabels.Rows(row.RowIndex).Cells(1).Text
            Session("RefLabel") = gvLabels.Rows(row.RowIndex).Cells(2).Text

            Dim dsLabel As DataSet = getSQLQueryAsDataset("SELECT * FROM labels WHERE spage = '" & Session("RefPage") & "' AND slabel = '" & Session("RefLabel") & "'")

            If dsLabel.Tables(0).Rows.Count <= 0 Then
                Exit Sub
            End If

            pnlEdit.Visible = True

            gvLabels.Visible = False

            lblSaveError.Visible = False

            lblHeader.Visible = True
            lblHeader.Text = gvLabels.Rows(row.RowIndex).Cells(1).Text
            lblLabel.Text = gvLabels.Rows(row.RowIndex).Cells(2).Text

            btnShowAll.Enabled = False
            btnFilter.Enabled = False
            btnAddLanguage.Enabled = False
            btnAddLabel.Enabled = False

            btnShowAll.BackColor = System.Drawing.Color.LightGray
            btnFilter.BackColor = System.Drawing.Color.LightGray
            btnAddLanguage.BackColor = System.Drawing.Color.LightGray
            btnAddLabel.BackColor = System.Drawing.Color.LightGray

            lblLangAlreadyInUse.Visible = False

            btnModify.Visible = True
            btnDelete.Visible = True
            btnSaveLabel.Visible = False

            txtNewLangID.Text = ""
            txtNewPage.Text = ""
            txtNewLabel.Text = ""

            Dim langDef As DataSet
            langDef = getSQLQueryAsDataset("SELECT ln.ilanguageid,  l.slanguagecode, ln.slanguagename_" & Session("preferredLanguage") & " FROM languagenames ln JOIN languages l ON l.ilanguageid = ln.ilanguageid")

            rptLabels.DataSource = langDef
            rptLabels.DataBind()

            Dim tlbl As Label
            Dim txtexamp As TextBox

            For i As Integer = 0 To rptLabels.Items.Count - 1

                tlbl = rptLabels.Items(i).FindControl("dgLang")
                tlbl.Text = langDef.Tables(0).Rows(i).Item(1)

                txtexamp = rptLabels.Items(i).FindControl("txtNewLabel")
                txtexamp.Text = dsLabel.Tables(0).Rows(0).Item(i + 2)

            Next

        ElseIf e.CommandName = "Delete" Then

            Dim row As GridViewRow = DirectCast(DirectCast(e.CommandSource, LinkButton).NamingContainer, GridViewRow)

            Session("RefPage") = gvLabels.Rows(row.RowIndex).Cells(1).Text
            Session("RefLabel") = gvLabels.Rows(row.RowIndex).Cells(2).Text

            gvLabels.Visible = False

            pnlDeleteWarning.Visible = True

            btnShowAll.Enabled = False
            btnFilter.Enabled = False
            btnAddLanguage.Enabled = False
            btnAddLabel.Enabled = False

            btnShowAll.BackColor = System.Drawing.Color.LightGray
            btnFilter.BackColor = System.Drawing.Color.LightGray
            btnAddLanguage.BackColor = System.Drawing.Color.LightGray
            btnAddLabel.BackColor = System.Drawing.Color.LightGray

            btnDeleteConfirmation.Visible = True
            lblSaveError.Visible = False

        End If

    End Sub


    Private Sub gvLabels_RowCreated(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvLabels.RowCreated

        If e.Row.RowType = DataControlRowType.Header Then

            Dim dheaders As DataSet = getSQLQueryAsDataset("SELECT ln.ilanguageid,  l.slanguagecode, ln.slanguagename_" & Session("preferredLanguage") & " FROM languagenames ln JOIN languages l ON l.ilanguageid = ln.ilanguageid")

            Try

                e.Row.Cells(1).Text = getMessage(Me, "dgHeader1")
                e.Row.Cells(1).HorizontalAlign = HorizontalAlign.Center

                e.Row.Cells(2).Text = getMessage(Me, "dgHeader2")
                e.Row.Cells(2).HorizontalAlign = HorizontalAlign.Center

                For i As Integer = 3 To dheaders.Tables(0).Rows.Count - 1 + 3
                    e.Row.Cells(i).Text = dheaders.Tables(0).Rows(i - 3).Item("slanguagename_" & Session("preferredLanguage"))
                    e.Row.Cells(i).HorizontalAlign = HorizontalAlign.Center
                Next

            Catch ex As Exception

            End Try

        End If

    End Sub


    Private Sub gvLabels_RowDeleting(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewDeleteEventArgs) Handles gvLabels.RowDeleting



    End Sub


    Private Sub gvLabels_RowEditing(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewEditEventArgs) Handles gvLabels.RowEditing



    End Sub


    Private Sub gvLabels_RowUpdating(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewUpdateEventArgs) Handles gvLabels.RowUpdating


    End Sub


    Private Sub btnDeleteConfirmation_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnDeleteConfirmation.Click

        If executeSQLCommand("DELETE FROM labels WHERE spage = '" & Session("RefPage") & "' AND slabel = '" & Session("RefLabel") & "'") Then

            Session("RefPage") = ""
            Session("RefLabel") = ""

            pnlEdit.Visible = False
            pnlNewLabel.Visible = False
            pnlDeleteWarning.Visible = False

            gvLabels.Visible = True

            txtNewPage.Text = ""
            txtNewLabel.Text = ""

            btnShowAll.Enabled = True
            btnFilter.Enabled = True
            btnAddLabel.Enabled = True
            btnAddLanguage.Enabled = True

            If txtNP.Text.Trim <> "" And txtNP.Visible = True Then

                btnShowAll.BackColor = System.Drawing.Color.Lavender
                btnFilter.BackColor = System.Drawing.Color.LightSteelBlue
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

            Else

                btnShowAll.BackColor = System.Drawing.Color.LightSteelBlue
                btnFilter.BackColor = System.Drawing.Color.Lavender
                btnAddLanguage.BackColor = System.Drawing.Color.Lavender
                btnAddLabel.BackColor = System.Drawing.Color.Lavender

            End If

            btnAddLabel.Text = getMessage(Me, "btnAddLabel")

            Dim query As String = "SELECT * FROM labels WHERE spage LIKE '%" & txtNP.Text & "%' OR slabel LIKE '%" & txtNP.Text & "%' "

            Dim langColumns As DataSet = getSQLQueryAsDataset("SELECT slanguagecode FROM languages l JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")

            For i = 0 To langColumns.Tables(0).Rows.Count - 1

                query = query & "OR " & langColumns.Tables(0).Rows(i).Item(0) & " LIKE '%" & txtNP.Text & "%' "

            Next i

            gvLabels.DataSource = getSQLQueryAsDataset(query)
            gvLabels.DataBind()

            formatDataGrid()

        End If

    End Sub


    Private Sub btnCancelDelete_Click(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCancelDelete.Click

        Session("RefPage") = ""
        Session("RefLabel") = ""

        pnlEdit.Visible = False
        pnlNewLabel.Visible = False
        pnlDeleteWarning.Visible = False

        gvLabels.Visible = True

        txtNewPage.Text = ""
        txtNewLabel.Text = ""

        btnShowAll.Enabled = True
        btnFilter.Enabled = True
        btnAddLabel.Enabled = True
        btnAddLanguage.Enabled = True

        If txtNP.Text.Trim <> "" And txtNP.Visible = True Then

            btnShowAll.BackColor = System.Drawing.Color.Lavender
            btnFilter.BackColor = System.Drawing.Color.LightSteelBlue
            btnAddLanguage.BackColor = System.Drawing.Color.Lavender
            btnAddLabel.BackColor = System.Drawing.Color.Lavender

        Else

            btnShowAll.BackColor = System.Drawing.Color.LightSteelBlue
            btnFilter.BackColor = System.Drawing.Color.Lavender
            btnAddLanguage.BackColor = System.Drawing.Color.Lavender
            btnAddLabel.BackColor = System.Drawing.Color.Lavender

        End If

        btnAddLabel.Text = getMessage(Me, "btnAddLabel")

        'Dim query As String = "SELECT * FROM labels WHERE spage LIKE '%" & txtNP.Text & "%' OR slabel LIKE '%" & txtNP.Text & "%' "

        'Dim langColumns As DataSet = getSQLQueryAsDataset("SELECT slanguagecode FROM languages l JOIN languagenames ln ON l.ilanguageid = ln.ilanguageid")

        'For i = 0 To langColumns.Tables(0).Rows.Count - 1

        '    query = query & "OR " & langColumns.Tables(0).Rows(i).Item(0) & " LIKE '%" & txtNP.Text & "%' "

        'Next i

        'gvLabels.DataSource = getSQLQueryAsDataset(query)
        'gvLabels.DataBind()

        'formatDataGrid()

    End Sub


End Class