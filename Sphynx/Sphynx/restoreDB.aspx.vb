Public Partial Class restoreDB
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        executeSQLCommand("TRUNCATE TABLE incidents")
        executeSQLCommand("REPLACE INTO incidents VALUES(1, 'Edinburg', 20110704, 'Line stop due to overheat', 0)")
        executeSQLCommand("REPLACE INTO incidents VALUES(2, 'Sinaloa', 20110704, 'Exposure levels over the permissible limits', 1)")
        executeSQLCommand("REPLACE INTO incidents VALUES(3, 'Edinburg', 20110704, 'Line stop due to overheat', 0)")
        executeSQLCommand("REPLACE INTO incidents VALUES(4, 'Imperial Valley', 20110713, 'Exposure levels over the permissible limits', 1)")
        executeSQLCommand("REPLACE INTO incidents VALUES(5, 'Imperial Valley', 20110713, 'Line stop due to overheat', 0)")
        executeSQLCommand("REPLACE INTO incidents VALUES(6, 'Sinaloa', 20110712, 'Line stop due to overheat', 0)")

        Response.Redirect("index.aspx")

    End Sub

End Class