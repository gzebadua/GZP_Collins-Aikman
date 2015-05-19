Partial Public Class ActiveUsers
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        'uHaveRight(Me)

        Session("language") = "es"

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)

            rblCompanias_SelectedIndexChanged(Me, Nothing)

        End If

    End Sub


    Private Sub btnShowMenu_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnShowMenu.Click

        With pnlMenu

            If .Visible Then

                .Visible = False

            Else

                .Visible = True

            End If

        End With

    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("language") = e.CommandArgument
        setLabels(Me)

    End Sub


    Private Sub rblCompanias_SelectedIndexChanged(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles rblCompanias.SelectedIndexChanged

        Dim sql As String

        sql = "SELECT cfID,rtrim(REalName) AS Usuario FROM Users WHERE Active="

        Select Case rblCompanias.SelectedValue

            Case "1"

                sql = sql & "1"
                btnActualizar.Text = "DESACTIVAR"

            Case "0"

                sql = sql & "0"
                btnActualizar.Text = "ACTIVAR"

        End Select

        If getSQLQueryAsBoolean(sql) > 0 Then

            fillDatagrid(dgCompanies, sql)

            lblError.Visible = False
            dgCompanies.Visible = True
            btnActualizar.Visible = True

        Else

            Select Case rblCompanias.SelectedValue

                Case "1"

                    lblError.Text = "NO EXISTEN COMPAÑÎAS ACTIVAS"

                Case "0"

                    lblError.Text = "NO EXISTEN COMPAÑÎAS DESACTIVADAS"

            End Select

            lblError.Visible = True
            dgCompanies.Visible = False
            btnActualizar.Visible = False

        End If

    End Sub


    Private Sub btnActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnActualizar.Click

        Dim i As Integer
        Dim sql As String
        Dim tchk As CheckBox

        For i = 0 To dgCompanies.Items.Count - 1

            tchk = dgCompanies.Items(i).FindControl("chkAD")

            If tchk.Checked Then

                If rblCompanias.SelectedValue = "1" Then

                    sql = "UPDATE dgCompanies SET Active='0' WHERE cfID='" & dgCompanies.DataKeys(i) & "'"

                Else

                    sql = "UPDATE dgCompanies SET Active='1' WHERE username='" & dgCompanies.DataKeys(i) & "'"

                End If

                executeSQLCommand(sql)

                lblError.Visible = True
                lblError.Text = "SE HAN ACTUALIZADO LOS DATOS"

            End If

        Next i

        tchk = Nothing
        i = Nothing
        sql = Nothing

        rblCompanias_SelectedIndexChanged(Me, Nothing)

    End Sub

End Class