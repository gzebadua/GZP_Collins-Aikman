Public Partial Class querySQL
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        uHaveRight(Me)

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)

        End If

        lblStatus.Text = ""

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


    Private Sub btnQuery_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnQuery.Click

        If txtSql.Text.Trim() = "" Then Return

        'NOTA IMPORTANTE: Las siguientes líneas de para generar una consulta deben ser
        'comentadas al llegar a un ambiente de producción. La función getSQLQueryAsDataset() en el
        'ambiente de desarrollo tiene comentado su bloque try catch. Para dar completa
        'funcionalidad a este módulo se usa este código temporal y al pasar al ambiente
        'de producción debe ser comentado y se debe quitar los comentarios a lo que está
        'después.

        resultados = getSQLQueryAsDataset(txtSql.Text)

        Dim res As Integer = 0 'define el resultado a guardar para sqlLog
        'Dim resultados As DataSet = getSQLQueryAsDataset(txtSql.Text)
        If resultados.Tables.Count <= 0 Then
            lblStatus.Text = getMessage(Me, "ERROR_QUERY")
            res = 0 'indica error
        Else
            lblStatus.Text = getMessage(Me, "SUCCESS_QUERY")
            dgResults.DataSource = resultados
            dgResults.DataBind()
            res = 1 'indica exito
        End If
        'registro de los cambios en sqlLog
        Dim cadena As String = "insert into sqlLog values(" & preventSQLInjection(Session("username")) & ",getdate()," & preventSQLInjection(txtSql.Text) & ",'" & res & "')"
        executeSQLCommand(cadena)

    End Sub


End Class