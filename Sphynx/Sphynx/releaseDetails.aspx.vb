Public Partial Class releaseDetails
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        uHaveRight(Me)

        PageTitle.Text = getMessage(Me, "PageTitle") & " " & Session("realname") & " - " & getMessage(Me, "lblHeader")

        If Not IsPostBack Then

            pnlForecast.Visible = False

            setLabels(Me)
            showFlags(rptFlags)

            Dim thisSessionRelease As New DataSet
            thisSessionRelease = getReleaseInfo(Session("releaseToDisplay"))
            Session("tsr") = thisSessionRelease

            If thisSessionRelease.Tables(0).Rows.Count = 0 Then Response.Redirect("displayReleases.aspx")

            lblReleaseNumber.Text = "Release: " & thisSessionRelease.Tables(0).Rows(0).Item("releaseID")
            hplGetExcelDoc.NavigateUrl = "releaseFiles/" & thisSessionRelease.Tables(0).Rows(0).Item("releaseID") & ".xls"

            With thisSessionRelease.Tables(0).Rows(0)

                lblRequestingPlant.Text = getMessage(Me, "lblFrom") & .Item("name")
                lblRequestedVendor.Text = getMessage(Me, "lblTo") & .Item("name1")
                lblPublisher.Text = "&nbsp;" & getMessage(Me, "lPublished1") & getMyName(.Item("publishingUser")) & getMessage(Me, "lPublished2") & .Item("publishingDT")

                Dim ts() As String = getSetAsViewed(Session("username"), .Item("releaseID"))

                lblViewer.Text = "&nbsp;" & getMessage(Me, "lViewed1") & getMyName(ts(0)) & getMessage(Me, "lViewed2") & ts(1)
                lblViewer.Visible = True

                Dim detailDS As DataSet
                detailDS = getReleaseDetails(.Item("releaseID"))
                dgDetails.DataSource = detailDS

                fixDGHeaders()

                dgDetails.Columns(8).Visible = False
                dgDetails.DataBind()

                If .Item("ackUser") <> "" Then

                    lblACKer.Text = "&nbsp;" & getMessage(Me, "lAck1") & getMyName(.Item("ackUser")) & getMessage(Me, "lAck2") & .Item("ackDT")

                    lblACKer.Visible = True
                    btnACK.Visible = False

                    Dim tc As CheckBox
                    Dim tt As TextBox
                    Dim imagen As ImageButton
                    Dim allA As Boolean = True

                    For i As Integer = 0 To dgDetails.Items.Count - 1

                        tc = dgDetails.Items(i).FindControl("chkAccept")

                        imagen = dgDetails.Items(i).FindControl("ImageButton3")
                        imagen.ToolTip = getMessage(Me, "ToolForecasts")

                        If detailDS.Tables(0).Rows(i).Item("accepted") = "1" Then

                            tc.Checked = True

                        Else

                            If Not detailDS.Tables(0).Rows(i).Item("comments") Is DBNull.Value Then dgDetails.Items(i).Cells(8).Text = detailDS.Tables(0).Rows(i).Item("comments")
                            allA = False
                            tc.Checked = False

                        End If

                        tc.Enabled = False

                        If Not allA Then

                            dgDetails.Columns(8).Visible = True

                        End If

                    Next

                End If

                If Not RightFor(Session("username"), "VEM_RLSACK") Or Session("vendorID") = 0 Then

                    Dim ns As Boolean = False

                    btnACK.Visible = ns
                    btnComment.Visible = ns

                    If lblACKer.Visible Then ns = True

                    dgDetails.Columns(7).Visible = ns
                    dgDetails.Columns(8).Visible = ns

                End If

            End With

        End If

    End Sub


    Sub fixDGHeaders()

        With dgForecasts

            .Columns(0).HeaderText = getMessage(Me, "dgFDate")
            .Columns(1).HeaderText = getMessage(Me, "dgFQty")

        End With

        With dgDetails

            .Columns(0).HeaderText = getMessage(Me, "dgrsPartN")
            .Columns(1).HeaderText = getMessage(Me, "dgrsVPartN")
            .Columns(2).HeaderText = getMessage(Me, "dgrsDescription")
            .Columns(3).HeaderText = getMessage(Me, "dgrsUnits")
            .Columns(4).HeaderText = getMessage(Me, "dgFQty")
            .Columns(6).HeaderText = getMessage(Me, "dgFDate")

        End With

    End Sub

    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then

                .Visible = False
                btnShowMenu.Text = getMessage(Me, "btnShowMenu")

            Else

                .Visible = True
                btnShowMenu.Text = getMessage(Me, "btnHideMenu")

            End If

        End With

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("language") = e.CommandArgument
        Dim path() As String = Me.Request.FilePath.Split("/")
        Me.Response.Redirect(path(path.Length - 1) & "?rid=" & Request.QueryString("rid"))

    End Sub


    Private Sub btnACK_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnACK.Click

        Dim tc As CheckBox
        Dim tt As TextBox
        Dim allAccepted As Boolean = True
        Dim allRejected As Boolean = True
        Dim status(0) As String

        With dgDetails

            For i As Integer = 0 To dgDetails.Items.Count - 1

                tc = .Items(i).FindControl("chkAccept")

                If Not tc.Checked Then

                    tt = .Items(i).FindControl("txtComments")
                    tt.Visible = True
                    allAccepted = False

                Else

                    If status(0) <> "" Then ReDim Preserve status(status.Length)
                    status(status.Length - 1) = .DataKeys(i)
                    allRejected = False

                End If

                tc.Enabled = False

            Next

            Dim ackInfo() As String
            'thisSessionRelease = getReleaseInfo(Request.QueryString("rid"))

            If allRejected Then status(0) = "0"
            ackInfo = ackRelease(Session("tsr").Tables(0).Rows(0).Item(0), Session("username"), status)

            lblACKer.Text = "&nbsp;" & getMessage(Me, "lAck1") & getMyName(ackInfo(0)) & getMessage(Me, "lAck2") & ackInfo(1)
            lblACKer.Visible = True

            If allAccepted Then

                btnACK.Visible = False
                setNewRState(Session("tsr").Tables(0).Rows(0).Item(0), allAccepted, allRejected)
                Response.Redirect("displayReleases.aspx")
                Exit Sub

            Else

                .Columns(8).Visible = True
                btnACK.Visible = False
                btnComment.Visible = True

            End If

        End With

        setNewRState(Session("tsr").Tables(0).Rows(0).Item(0), allAccepted, allRejected)

    End Sub


    Private Sub dgDetails_ItemCommand(ByVal source As Object, ByVal e As System.Web.UI.WebControls.DataGridCommandEventArgs) Handles dgDetails.ItemCommand

        If e.CommandName = "showForecast" Then

            LblNothing.Visible = True

            dgForecasts.DataSource = getForecasts(e.CommandArgument, Session("tsr").Tables(0).Rows(0).Item("pfID"))

            fixDGHeaders()

            dgForecasts.DataBind()
            dgForecasts.Visible = True

            LblNothing.Text = getMessage(Me, "ForecastTitle") & e.CommandArgument

            If dgForecasts.Items.Count = 0 Then
                dgForecasts.Visible = False
                LblNothing.Text = getMessage(Me, "Nothing") & e.CommandArgument
            End If

            pnlForecast.Visible = True

        End If

    End Sub


    Private Sub btnComment_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnComment.Click

        Dim tt As TextBox
        Dim comments(1) As String

        With dgDetails

            For i As Integer = 0 To dgDetails.Items.Count - 1
                tt = .Items(i).FindControl("txtComments")
                If tt.Visible Then
                    If comments(0) <> "" Then ReDim Preserve comments(comments.Length + 1)
                    comments(comments.Length - 2) = .DataKeys(i)
                    comments(comments.Length - 1) = tt.Text
                End If
            Next

        End With

        commentRelease(comments)

        'CÓDIGO PARA ENVIAR LOS COMENTARIOS A CORREO ELECTRÓNICO DE COLLINS. Si se puede
        'enviar más datos como releaseId, usuario actual, vendorname y demás, mucho mejor :)
        'LUEGO VA LA PÁGINA A LA QUE SE REDIRECCIONA :)

        Response.Redirect("displayReleases.aspx")

    End Sub


    Private Sub btnCloseForecast_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnCloseForecast.Click

        pnlForecast.Visible = False

    End Sub


    Private Sub dgDetails_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles dgDetails.SelectedIndexChanged

    End Sub


    Private Sub goBack_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles goBack.Click

        Response.Redirect("main.aspx")

    End Sub

End Class