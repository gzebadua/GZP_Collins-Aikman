Public Partial Class systemAct
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        uHaveRight(Me)

        PageTitle.Text = getMessage(Me, "PageTitle") & " " & Session("realname") & " - " & getMessage(Me, "lblHeader")

        If Not IsPostBack Then

            setLabels(Me)

            rptModulesStatus.DataSource = getModules(Session("language"))
            rptModulesStatus.DataBind()

            fixModulesDataGridDisplay()

        End If

        showFlags(rptFlags)

        'show status incial del server
        showServerStatus()
        lblServerTime.Text = getMessage(Me, "lblCurrTime") & " " & Date.Now.ToShortTimeString

    End Sub

    Sub showServerStatus()

        With lblSysStat

            Dim pez As String
            pez = objWSsc.getStatus()(0)
            If pez = "1" Then
                .Text = getMessage(Me, "lblSysStatOnline")
                .BorderColor = System.Drawing.Color.Green
                .BackColor = System.Drawing.Color.LimeGreen
                btnActDeact.Text = getMessage(Me, "lblDeact")
            Else
                .Text = getMessage(Me, "lblSysStatOffline")
                .BorderColor = System.Drawing.Color.DarkRed
                .BackColor = System.Drawing.Color.Red
                btnActDeact.Text = getMessage(Me, "lblAct")
            End If
        End With

        lblStatusSince.Text = getMessage(Me, "lblStatusSince") & " " & objWSsc.getStatus()(1)

    End Sub


    Sub fixModulesDataGridDisplay()

        Dim tds As DataSet
        Dim ti As System.Web.UI.WebControls.Image
        Dim tb As Button
        Dim tl As Label

        tds = getModules(Session("language"))

        With rptModulesStatus

            For i As Integer = 0 To .Items.Count - 1

                ti = .Items(i).FindControl("imgModStat")
                tb = .Items(i).FindControl("cmdModTitle")
                tl = .Items(i).FindControl("lblModuleStatusAuthor")

                If tb.CommandArgument = "ADM_MODADM" Then tb.Enabled = False 'PARCHESOTE

                If tds.Tables(0).Rows(i).Item(2) = "1" Then
                    ti.ImageUrl = "images/lightG.gif"
                    tl.Text = getMessage(Me, "lblModuleAct") & objWSsc.doNormalDateFormat(tds.Tables(0).Rows(i).Item(4)) & getMessage(Me, "lblModuleActBy") & tds.Tables(0).Rows(i).Item(3)
                    tb.Text = tds.Tables(0).Rows(i).Item(1)
                Else
                    ti.ImageUrl = "images/lightR.gif"
                    tl.Text = getMessage(Me, "lblModuleDesac") & objWSsc.doNormalDateFormat(tds.Tables(0).Rows(i).Item(4)) & getMessage(Me, "lblModuleActBy") & tds.Tables(0).Rows(i).Item(3)
                    tb.Text = tds.Tables(0).Rows(i).Item(1)
                End If

            Next

        End With

    End Sub


    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then
                .Visible = False
                btnShowMenu.Text = getMessage(Me, "cmdShowMenu")
            Else
                .Visible = True
                btnShowMenu.Text = getMessage(Me, "cmdHideMenu")
            End If

        End With

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand
        Session("language") = e.CommandArgument
        setLabels(Me)
    End Sub


    Private Sub lblActDeact_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles lblActDeact.Click

        If objWSsc.getStatus()(0) = "1" Then
            pnlShutdownInfo.Visible = True
        Else
            objWSsc.ActivateDeactivate(True)
            showServerStatus()
        End If

    End Sub


    Private Sub cmdDoShut_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles cmdDoShut.Click

        If objWSsc.ActivateDeactivate(False) And objWSsc.setValue("systemWillBeBack", txtWhenWBB.Text) Then
            pnlShutdownInfo.Visible = False
            showServerStatus()
        Else
            objWSsc.ActivateDeactivate(True)
        End If

    End Sub


    Private Sub rptModulesStatus_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptModulesStatus.ItemCommand

        If e.CommandName = "showDetails" Then

            Dim tl As Label = rptModulesStatus.Items(e.Item.ItemIndex).FindControl("lblModuleStatusAuthor")

            With rptModulesStatus

                If tl.Visible Then
                    tl.Visible = False
                Else
                    tl.Visible = True
                End If

            End With

        End If

        If e.CommandName = "AD" Then

            objWSsc.switchMStatus(e.CommandArgument, Session("username"))

            rptModulesStatus.DataSource = getModules(Session("language"))
            rptModulesStatus.DataBind()

            fixModulesDataGridDisplay()

        End If

    End Sub


End Class