Imports Microsoft.VisualBasic
Imports System.Web.Services
Imports System.Net.NetworkInformation
Imports MySql.Data.MySqlClient
Imports System.Security.Cryptography
Imports System.Data
Imports System.Net.Mail


Public Module Utilities


    '========================================================================================
    'SQL Connections


    Dim servidor As String = "websphynx.db.7462515.hostedresource.com"
    Dim usuario As String = "websphynx"
    Dim password As String = "MemoZebadua4"
    Dim database As String = "websphynx"

    'Dim servidor As String = "localhost"
    'Dim usuario As String = "root"
    'Dim password As String = "omudes"
    'Dim database As String = "websphynx"


    Public Function StringConnection() As String

        Return "Server=" & servidor & ";Database=" & database & ";Port=3306;" & _
        "Uid=" & usuario & ";Pwd=" & password & ";Connect Timeout=60;"

    End Function


    '========================================================================================
    'Online Checks


    Public Function getSystemStatus() As String

        Dim output As String = ""

        If isMySQLOnline() = False Then
            Return "MySQL Offline"
        Else
            If isSystemOnline() = False Then
                Return "System Offline"
            Else
                Return "System Online"
            End If
        End If

    End Function


    Public Function isMySQLOnline() As Boolean

        Dim result As String = ""

        result = getSQLQueryAsString("SELECT NOW()")

        If result.Equals("") Then
            Return False
        Else
            Return True
        End If

    End Function


    Public Function isSystemOnline() As Boolean

        Dim result As Integer = 0

        result = getSQLQueryAsInteger("SELECT svalue FROM systemvariables WHERE svariable = 'systemOnline'")

        If result = 0 Then
            Return False
        Else
            Return True
        End If

    End Function


    '========================================================================================
    'SQL Helpers


    Public Function getSQLQueryAsDataset(ByVal query As String) As DataSet

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objDA As New MySqlDataAdapter(query, objCon)
        Dim dsDatos As New DataSet

        Try

            objDA.Fill(dsDatos)

        Catch ex As Exception
            'Nothing
        Finally

            objCon.Close()
            objCon.Dispose()
            objDA.Dispose()

        End Try

        Return dsDatos

    End Function


    Public Function getSQLQueryAsImage(ByVal query As String) As Byte()

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objDA As New MySqlDataAdapter(query, objCon)
        Dim dsDatos As New DataSet

        Try

            objDA.Fill(dsDatos)

            Dim buffer As Byte() = DirectCast(dsDatos.Tables(0).Rows(0)("Data"), Byte())
            Return buffer

        Catch ex As Exception

            Return Nothing

        Finally

            objCon.Close()
            objCon.Dispose()
            objDA.Dispose()

        End Try

    End Function


    Public Function get2SQLQueriesInSameDataset(ByVal query As String, ByVal query2 As String, ByVal nivel1PK As String, ByVal nivel2PK As String) As DataSet

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objDA As New MySqlDataAdapter(query, objCon)
        Dim dsDatos As New DataSet

        Try

            objDA.Fill(dsDatos, "Nivel1")
            objDA = New MySqlDataAdapter(query2, objCon)
            objDA.Fill(dsDatos, "Nivel2")
            dsDatos.Relations.Add("Children", dsDatos.Tables(0).Columns(nivel1PK), dsDatos.Tables(1).Columns(nivel2PK))

        Catch ex As Exception

            Dim exa As String
            exa = ex.ToString

        Finally

            objCon.Close()
            objCon.Dispose()
            objDA.Dispose()

        End Try

        Return dsDatos

    End Function


    Public Function getSQLQueryAsString(ByVal query As String) As String

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objCmd As New MySqlCommand(query, objCon)
        Dim objRdr As MySqlDataReader

        Try

            objCon.Open()
            objRdr = objCmd.ExecuteReader
            objRdr.Read()
            If objRdr.HasRows Then
                Return objRdr(0)
            Else
                Return ""
            End If

        Catch ex As Exception

            Return ""

        Finally

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

        End Try

    End Function


    Public Function getSQLQueryAsInteger(ByVal query As String) As Integer

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objCmd As New MySqlCommand(query, objCon)
        Dim objRdr As MySqlDataReader

        Try

            objCon.Open()
            objRdr = objCmd.ExecuteReader
            objRdr.Read()
            If objRdr.HasRows Then
                Return CInt(objRdr(0))
            Else
                Return 0
            End If

        Catch ex As Exception

            Return 0

        Finally

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

        End Try

    End Function


    Public Function getSQLQueryAsDouble(ByVal query As String) As Double

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objCmd As New MySqlCommand(query, objCon)
        Dim objRdr As MySqlDataReader

        Try

            objCon.Open()
            objRdr = objCmd.ExecuteReader
            objRdr.Read()
            If objRdr.HasRows Then
                Return CDbl(objRdr(0))
            Else
                Return 0.0
            End If

        Catch ex As Exception

            Return 0.0

        Finally

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

        End Try

    End Function


    Public Function getSQLQueryAsBoolean(ByVal query As String) As Boolean

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objCmd As New MySqlCommand(query, objCon)
        Dim objRdr As MySqlDataReader

        Try

            objCon.Open()
            objRdr = objCmd.ExecuteReader
            objRdr.Read()
            If objRdr.HasRows Then
                Return CBool(objRdr(0))
            Else
                Return False
            End If

        Catch ex As Exception

            Return False

        Finally

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

        End Try

    End Function


    Public Function getSQLQueryAsPagedDataSet(ByVal query As String, ByVal currentPageIndex As Integer, ByVal pagingSize As Integer) As DataSet

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objCmd As New MySqlDataAdapter(query, objCon)
        Dim dsDatos As New DataSet

        Try

            objCmd.Fill(dsDatos, currentPageIndex, pagingSize, "mirrorforsearch")

        Catch ex As Exception

        Finally

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

        End Try

        Return dsDatos

    End Function


    Public Function getSQLQueryAsDataTable(ByVal query As String) As DataTable

        Dim objCon As MySqlConnection

        objCon = New MySqlConnection(StringConnection())

        Dim objCmd As New MySqlDataAdapter(query, objCon)
        Dim dsDatos As New DataTable

        Try

            objCmd.Fill(dsDatos)

        Catch ex As Exception

        Finally

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

        End Try

        Return dsDatos

    End Function


    Public Function executeSQLCommand(ByVal query As String) As Boolean

        Try

            Dim objCon As MySqlConnection

            objCon = New MySqlConnection(StringConnection())

            Dim objCmd As New MySqlCommand(query, objCon)

            objCon.Open()
            objCmd.CommandText = query
            objCmd.Connection = objCon
            objCmd.ExecuteNonQuery()

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

            Return True

        Catch ex As Exception

            Return False

        End Try

    End Function


    Public Function executeTransactedSQLCommand(ByVal queries As String()) As Boolean

        Dim i As Integer = 0

        Try

            Dim objCon As MySqlConnection

            objCon = New MySqlConnection(StringConnection())

            Dim objCmd As MySqlCommand

            objCmd = New MySqlCommand("START TRANSACTION", objCon)
            objCon.Open()
            objCmd.CommandText = "START TRANSACTION"
            objCmd.Connection = objCon
            objCmd.ExecuteNonQuery()

            For i = 0 To queries.Length - 1

                If queries(i) Is DBNull.Value Or queries(i) = "" Then
                    Continue For
                End If

                objCmd.CommandText = queries(i)
                objCmd.Connection = objCon
                objCmd.ExecuteNonQuery()

            Next i

            objCmd.CommandText = "COMMIT"
            objCmd.Connection = objCon
            objCmd.ExecuteNonQuery()

            objCon.Close()
            objCon.Dispose()
            objCmd.Dispose()

            Return True

        Catch ex As Exception

            If ex.InnerException Is Nothing Then
                executeSQLCommand("INSERT IGNORE INTO errorlogs VALUES ('" & getMySQLDate() & "', 'The following query produced an exception: " & preventSQLInjection(queries(i)) & " : " & ex.ToString.Replace("'", "") & "')")
            Else
                executeSQLCommand("INSERT IGNORE INTO errorlogs VALUES ('" & getMySQLDate() & "', 'The following query produced an exception: " & preventSQLInjection(queries(i)) & " : " & ex.ToString.Replace("'", "") & " Inner Exception: " & ex.InnerException.ToString.Replace("'", "") & "')")
            End If

            'MsgBox(ex.ToString)

            Dim errorAtIteration As Integer = 0
            Dim verQueries As String = queries.Length
            errorAtIteration = i

            Dim objCon As MySqlConnection

            objCon = New MySqlConnection(StringConnection())

            Try

                Dim objCmd As MySqlCommand
                objCmd = New MySqlCommand("ROLLBACK", objCon)
                objCon.Open()
                objCmd.CommandText = "ROLLBACK"
                objCmd.Connection = objCon
                objCmd.ExecuteNonQuery()

            Catch ex2 As Exception

            End Try

            Return False

        End Try

    End Function


    Public Function preventSQLInjection(ByVal value As String) As String

        If value.Contains("'") Then
            value = "'" & value & "'"
        End If

        Return value

    End Function



    '========================================================================================
    'SQL Helpers - Root Access


    Public Function addColumnToTable(ByVal Table As String, ByVal ColumnName As String, ByVal DataType As String) As Boolean

        Return executeSQLCommand("ALTER TABLE " & Table & " ADD " & ColumnName & " " & DataType)

    End Function


    Public Function removeColumnToTable(ByVal Table As String, ByVal ColumnName As String) As Boolean

        Return executeSQLCommand("ALTER TABLE " & Table & " DROP " & ColumnName)

    End Function


    Public Function updateColumnDefinitionOfTable(ByVal Table As String, ByVal ColumnName As String, ByVal DataType As String) As Boolean

        Return executeSQLCommand("ALTER TABLE " & Table & " MODIFY " & ColumnName & " " & DataType)

    End Function


    Public Function updateColumnNameOfTable(ByVal Table As String, ByVal ColumnName As String, ByVal NewColumnName As String, ByVal DataType As String) As Boolean

        Return executeSQLCommand("ALTER TABLE " & Table & " CHANGE " & ColumnName & " " & NewColumnName & " " & DataType)

    End Function


    '========================================================================================
    'Object Fillers - Useful for the lazy programmer


    Public Function fillLabel(ByVal Label As System.Web.UI.WebControls.Label, ByVal query As String) As Boolean

        Label.Text = ""
        Label.Text = getSQLQueryAsString(query)
        Return True

    End Function


    Public Function fillTextBox(ByVal TextBox As System.Web.UI.WebControls.TextBox, ByVal query As String) As Boolean

        TextBox.Text = ""
        TextBox.Text = getSQLQueryAsString(query)
        Return True

    End Function


    Public Function fillRepeater(ByVal rep As System.Web.UI.WebControls.Repeater, ByVal query As String) As Boolean

        Dim objds As DataSet = getSQLQueryAsDataset(query)
        rep.DataSource = objds
        rep.DataBind()
        Return True

    End Function


    Public Function fillList(ByVal List As System.Web.UI.WebControls.ListBox, ByVal query As String) As Boolean

        Dim rs As DataSet = getSQLQueryAsDataset(query)
        List.ClearSelection()
        List.Items.Clear()
        For i As Integer = 0 To rs.Tables(0).Rows.Count - 1
            List.Items.Add(rs.Tables(0).Rows(i).Item(0))
        Next
        Return True

    End Function


    Public Function fillListView(ByVal List As System.Web.UI.WebControls.ListView, ByVal query As String) As Boolean

        Dim objds As DataSet = getSQLQueryAsDataset(query)
        List.DataSource = objds
        List.DataBind()
        Return True

    End Function


    Public Function fillDropDownList(ByRef DDList As System.Web.UI.WebControls.DropDownList, ByVal query As String) As Boolean

        Dim rs As DataSet = getSQLQueryAsDataset(query)
        With rs.Tables(0).Rows
            For i As Integer = 0 To .Count - 1
                DDList.Items.Add(New ListItem(.Item(i).Item(1), .Item(i).Item(0)))
            Next
        End With
        Return True

    End Function


    Public Function fillDatagrid(ByVal dg As DataGrid, ByVal query As String) As Boolean

        Dim objds As DataSet = getSQLQueryAsDataset(query)
        dg.DataSource = objds
        dg.DataBind()
        Return True

    End Function


    Public Function fillDatagridPaged(ByVal dg As DataGrid, ByVal query As String, ByVal currentPageIndex As Integer, ByVal pagingSize As Integer) As Boolean

        Dim objds As DataSet = getSQLQueryAsPagedDataSet(query, currentPageIndex, pagingSize)
        dg.DataSource = objds.Tables(0).DefaultView
        dg.DataBind()
        Return True

    End Function


    Public Function fillDataListPaged(ByVal dl As DataList, ByVal query As String, ByVal currentPageIndex As Integer, ByVal pagingSize As Integer) As Boolean

        Dim objds As DataSet = getSQLQueryAsPagedDataSet(query, currentPageIndex, pagingSize)
        dl.DataSource = objds.Tables(0).DefaultView
        dl.DataBind()
        Return True

    End Function


    Public Function fillDataListNotPaged(ByVal dl As DataList, ByVal query As String) As Boolean

        Dim objds As DataSet = getSQLQueryAsDataset(query)
        dl.DataSource = objds.Tables(0).DefaultView
        dl.DataBind()
        Return True

    End Function


    '========================================================================================
    'Functions


    Sub showFlags(ByRef rpt As Repeater)

        Dim sql As String = "SELECT slanguagecode AS 'col' FROM languages WHERE blive = 1"

        rpt.DataSource = getSQLQueryAsDataset(sql)
        rpt.DataBind()

    End Sub


    Sub loadMenu(ByVal origen As System.Web.UI.Page, ByRef rpt As Repeater)

        Dim sql As String = "SELECT m.smoduleid, IF(m.bstatus = '0', '#', m.surl) AS surl, m.bshowInMenu, m.bStatus, m.spermissiongrantingusername, m.permissiongrantingdate, m." & origen.Session("preferredLanguage") & "_title, m." & origen.Session("preferredLanguage") & "_description, (SELECT " & origen.Session("preferredLanguage") & " FROM labels WHERE spage = 'main.aspx' AND slabel = 'moduleNotActive') AS " & origen.Session("preferredLanguage") & " FROM modules m JOIN userpermissions up ON m.smoduleid = up.smoduleid WHERE up.susername = '" & origen.Session("username") & "' AND bshowinmenu = '1'"

        rpt.DataSource = getSQLQueryAsDataset(sql)
        rpt.DataBind()

    End Sub


    '========================================================================================
    'Encryption Functions


    Dim dicc() As Integer = New Integer() {97, 98, 99, 100, 101, 102, 103, 104, 105, 106, 107, 108, 109, 110, 111, 112, 113, 114, 115, 116, 117, 118, 119, 120, 121, 122, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57}


    Public Function SHA512Protect(ByVal plainText As String) As String

        Dim data(plainText.Length - 1) As Byte
        Dim result() As Byte
        Dim shaM As New SHA512Managed()
        result = shaM.ComputeHash(data)

        Return Convert.ToBase64String(result)

    End Function


    Public Function MD5Protect(ByVal plainText As String) As String

        Dim hash As HashAlgorithm
        hash = New MD5CryptoServiceProvider

        Dim plainTextBytes As Byte()
        plainTextBytes = Encoding.UTF8.GetBytes(plainText)
        Dim plainTextWithSaltBytes() As Byte = New Byte(plainTextBytes.Length - 1) {}

        Dim I As Integer
        For I = 0 To plainTextBytes.Length - 1
            plainTextWithSaltBytes(I) = plainTextBytes(I)
        Next I

        Dim hashBytes As Byte()
        hashBytes = hash.ComputeHash(plainTextWithSaltBytes)
        Dim hashWithSaltBytes() As Byte = New Byte(hashBytes.Length - 1) {}

        For I = 0 To hashBytes.Length - 1
            hashWithSaltBytes(I) = hashBytes(I)
        Next I

        Dim hashValue As String
        hashValue = Convert.ToBase64String(hashWithSaltBytes)

        Return hashValue

    End Function


    Public Function VignereProtect(ByVal mensaje As String) As String

        Dim i As Integer
        Dim cSal As String
        Dim cMsg As Integer
        Dim cCla As Integer
        Dim pCla As Integer

        Dim palabraClave As String = "To see a world in a grain of sand and a heaven in a wild flower. Hold infinity in the palm of your hand and Eternity in an hour"

        pCla = 1
        cSal = ""

        For i = 1 To Len(mensaje)

            cMsg = getPositionInDictionary(Mid(mensaje, i, 1))
            cCla = getPositionInDictionary(Mid(palabraClave, pCla, 1))
            cSal = cSal + getCharacterFromDictionary((adjustNumberToEncrypt(cCla + cMsg)))
            pCla = pCla + 1

            If pCla > Len(palabraClave) Then
                pCla = 1
            End If

        Next i

        Return cSal

    End Function


    Function getPositionInDictionary(ByVal car As Char) As Integer

        Dim i, salida As Integer

        salida = -1
        For i = 0 To dicc.Length - 1
            If dicc(i) = Asc(car) Then
                Return i
            End If
        Next i

        Return salida

    End Function


    Function getCharacterFromDictionary(ByVal pos As Integer) As String

        Return Chr(dicc(pos))

    End Function


    Public Function adjustNumberToEncrypt(ByVal numero As Integer) As Integer

        If numero > (dicc.Length - 1) Then
            adjustNumberToEncrypt = numero - dicc.Length
        Else
            adjustNumberToEncrypt = numero
        End If

    End Function


    Public Function Encrypt(ByVal plainText As String, ByVal hashAlgorithm As String, ByVal saltBytes() As Byte) As String

        ' If salt is not specified, generate it on the fly.
        If (saltBytes Is Nothing) Then

            ' Define min and max salt sizes.
            Dim minSaltSize As Integer
            Dim maxSaltSize As Integer

            minSaltSize = 4
            maxSaltSize = 8

            ' Generate a random number for the size of the salt.
            Dim random As Random
            random = New Random()

            Dim saltSize As Integer
            saltSize = random.Next(minSaltSize, maxSaltSize)

            ' Allocate a byte array, which will hold the salt.
            saltBytes = New Byte(saltSize - 1) {}

            ' Initialize a random number generator.
            Dim rng As RNGCryptoServiceProvider
            rng = New RNGCryptoServiceProvider()

            ' Fill the salt with cryptographically strong byte values.
            rng.GetNonZeroBytes(saltBytes)

        End If

        ' Convert plain text into a byte array.
        Dim plainTextBytes As Byte()
        plainTextBytes = Encoding.UTF8.GetBytes(plainText)

        ' Allocate array, which will hold plain text and salt.
        Dim plainTextWithSaltBytes() As Byte = _
            New Byte(plainTextBytes.Length + saltBytes.Length - 1) {}

        ' Copy plain text bytes into resulting array.
        Dim I As Integer

        For I = 0 To plainTextBytes.Length - 1
            plainTextWithSaltBytes(I) = plainTextBytes(I)
        Next I

        ' Append salt bytes to the resulting array.
        For I = 0 To saltBytes.Length - 1
            plainTextWithSaltBytes(plainTextBytes.Length + I) = saltBytes(I)
        Next I

        ' Because we support multiple hashing algorithms, we must define
        ' hash object as a common (abstract) base class. We will specify the
        ' actual hashing algorithm class later during object creation.
        Dim hash As HashAlgorithm

        ' Make sure hashing algorithm name is specified.
        If (hashAlgorithm Is Nothing) Then
            hashAlgorithm = ""
        End If

        ' Initialize appropriate hashing algorithm class.
        Select Case hashAlgorithm.ToUpper()

            Case "SHA1"
                hash = New SHA1Managed()

            Case "SHA256"
                hash = New SHA256Managed()

            Case "SHA384"
                hash = New SHA384Managed()

            Case "SHA512"
                hash = New SHA512Managed()

            Case Else
                hash = New MD5CryptoServiceProvider()

        End Select

        ' Compute hash value of our plain text with appended salt.
        Dim hashBytes As Byte()
        hashBytes = hash.ComputeHash(plainTextWithSaltBytes)

        ' Create array which will hold hash and original salt bytes.
        Dim hashWithSaltBytes() As Byte = New Byte(hashBytes.Length + saltBytes.Length - 1) {}

        ' Copy hash bytes into resulting array.
        For I = 0 To hashBytes.Length - 1
            hashWithSaltBytes(I) = hashBytes(I)
        Next I

        ' Append salt bytes to the result.
        For I = 0 To saltBytes.Length - 1
            hashWithSaltBytes(hashBytes.Length + I) = saltBytes(I)
        Next I

        ' Convert result into a base64-encoded string.
        Dim hashValue As String

        hashValue = Convert.ToBase64String(hashWithSaltBytes)

        ' Return the result.
        Encrypt = hashValue

    End Function


    Public Function EncryptText(ByVal what As String) As String

        Dim encryptSalt As String = "To see a world in a grain of sand and a heaven in a wild flower. Hold infinity in the palm of your hand and Eternity in an hour"

        Dim encoding As New System.Text.ASCIIEncoding()

        Return Encrypt(what, "SHA512", encoding.GetBytes(encryptSalt))

    End Function


    '========================================================================================
    ' Time Functions


    Public Function getAppTime() As String

        'Get time HH:mm:SS style FROM the application

        Dim tempStr1 As String
        Dim tempStr2 As String

        tempStr1 = ""

        With Date.Now

            tempStr2 = .Hour
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 = tempStr1 & tempStr2 & ":"
            tempStr2 = .Minute
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 = tempStr1 & tempStr2 & ":"
            tempStr2 = .Second
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 &= tempStr2

        End With

        Return tempStr1.Trim

    End Function


    Public Function getAppDate() As String

        'Get date YYYYMMDD style FROM the application

        Dim tempStr1 As String
        Dim tempStr2 As String

        Dim output As String

        tempStr1 = ""

        With Date.Now

            tempStr1 &= .Year
            tempStr2 = .Month
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 &= tempStr2
            tempStr2 = .Day
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 = tempStr1 & tempStr2 & " "
            tempStr2 = .Hour
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 = tempStr1 & tempStr2 & ":"
            tempStr2 = .Minute
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 = tempStr1 & tempStr2 & ":"
            tempStr2 = .Second
            If Len(tempStr2) = 1 Then tempStr2 = "0" & tempStr2
            tempStr1 &= tempStr2

        End With

        output = Left(tempStr1, 4) & "-" & Right(Left(tempStr1, 6), 2) & "-" & Right(Left(tempStr1, 8), 2) & " "

        Return output.Trim.Replace("-", "").Replace("/", "").Replace("\", "")

    End Function


    Public Function getMySQLDate() As String

        'Return getSQLQueryAsString("SELECT DATE_FORMAT(now(),'%Y%m%d')")
        Return getSQLQueryAsString("SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 3 HOUR),'%Y-%m-%d %H:%i:%s')")

    End Function


    Public Function getMySQLTime() As String

        Return getSQLQueryAsString("SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 3 HOUR),'%H:%i:%s')")

    End Function


    Public Function getYYYYMMDDMySQLDate() As String

        Return getSQLQueryAsString("SELECT DATE_FORMAT(DATE_ADD(NOW(), INTERVAL 3 HOUR),'%Y%m%d')")

    End Function


    Public Function convertDDdashMMdashYYYYtoYYYYMMDDHHMMSS(ByVal giventext As String) As String

        Dim output As String = ""
        Dim tempYear As String = ""
        Dim tempMonth As String = ""
        Dim tempDay As String = ""

        With giventext

            tempYear &= Right(giventext, 4)
            giventext = giventext.Replace(tempYear, "")
            tempMonth = Right(giventext, 3)
            tempMonth = tempMonth.Replace("-", "").Replace("/", "")
            giventext = giventext.Replace(Right(giventext, 3), "")
            tempDay = giventext.Replace("-", "").Replace("/", "")

            If Len(tempMonth) = 1 Then tempMonth = "0" & tempMonth

            If Len(tempDay) = 1 Then tempDay = "0" & tempDay

        End With

        output = tempYear & "-" & tempMonth & "-" & tempDay & " " & "00:00:00"

        Return output

    End Function


    Public Function convertDDdashMMdashYYYYtoYYYYMMDD(ByVal giventext As String) As String

        Dim output As String = ""
        Dim tempYear As String = ""
        Dim tempMonth As String = ""
        Dim tempDay As String = ""

        With giventext

            tempYear &= Right(giventext, 4)
            giventext = giventext.Replace(tempYear, "")
            tempMonth = Right(giventext, 3)
            tempMonth = tempMonth.Replace("-", "").Replace("/", "")
            giventext = giventext.Replace(Right(giventext, 3), "")
            tempDay = giventext.Replace("-", "").Replace("/", "")

            If Len(tempMonth) = 1 Then tempMonth = "0" & tempMonth

            If Len(tempDay) = 1 Then tempDay = "0" & tempDay

        End With

        output = tempYear & tempMonth & tempDay

        Return output

    End Function


    Public Function convertYYYYMMDDtoDDhyphenMMhyphenYYYY(ByVal giventext As String) As String

        Dim output As String = ""
        Dim tempYear As String = ""
        Dim tempMonth As String = ""
        Dim tempDay As String = ""

        With giventext

            tempYear &= Left(giventext, 4)
            giventext = giventext.Replace(tempYear, "")
            tempMonth = Left(giventext, 2)
            giventext = giventext.Replace(tempMonth, "")
            tempDay = giventext

            If Len(tempMonth) = 1 Then tempMonth = "0" & tempMonth

            If Len(tempDay) = 1 Then tempDay = "0" & tempDay

        End With

        output = tempDay & "-" & tempMonth & "-" & tempYear

        Return output

    End Function


    Public Function howManyDaysBetween(ByVal date1 As Date, ByVal date2 As Date) As Integer

        Dim days As Long

        days = DateDiff(DateInterval.Day, date1, date2)

        Return days

    End Function


    Public Function howManyDaysInMonth(ByVal date1 As Integer) As Integer

        Dim tmp1 As String
        tmp1 = date1

        Return System.DateTime.DaysInMonth(tmp1.Substring(0, 4), tmp1.Substring(4, 2))

    End Function


    '========================================================================================
    ' Security Functions


    Sub randomizeGhostImage(ByVal imglock As System.Web.UI.WebControls.Image)

        Randomize()

        Dim luckyNumber As Integer = Int(10 * Rnd())

        If luckyNumber = 4 Then

            imglock.ImageUrl = "images/GhostInTheMachinery.jpg"
            imglock.ToolTip = ""

        End If

    End Sub


    Private Function TryPing(ByVal Host As String) As Boolean

        Dim pingSender As New Ping
        Dim reply As PingReply

        Try

            reply = pingSender.Send(Host)

            If reply.Status = IPStatus.Success Then
                Return True
            Else
                Return False
            End If

        Catch ex As Exception

            Return False

        End Try

    End Function


    Public Function detectBrowserVersion(ByVal page As System.Web.UI.Page, ByVal browser As String) As String

        Dim version As String = ""
        version = page.Request.UserAgent.Substring(page.Request.UserAgent.IndexOf(browser))
        Try
            version = version.Substring(0, version.IndexOf(" "))
        Catch ex As Exception

        End Try
        version = version.Replace(browser, "")
        version = version.Replace("/", "").Trim
        Return version

    End Function


    Public Function detectComplaintBrowserCapabilities(ByVal page As System.Web.UI.Page) As String

        If page.Request.Browser.EcmaScriptVersion.ToString() < 1 Then
            'lnkLogin.Enabled = False
            Return getMessage(page, "Javascripts")
        End If

        If page.Request.Browser.Cookies = False Then
            'lnkLogin.Enabled = False
            Return getMessage(page, "Cookies")
        End If

        Return ""

    End Function


    Public Function detectBrowserUsed(ByVal page As System.Web.UI.Page) As String

        If page.Request.UserAgent.Contains("MSIE 8.0") Then

            Return getMessage(page, "IE8")

        ElseIf page.Request.UserAgent.Contains("MSIE 7.0") Then

            Return getMessage(page, "IE7")

        ElseIf page.Request.UserAgent.Contains("MSIE 6.0") Then

            Return getMessage(page, "IE6")

        ElseIf page.Request.UserAgent.Contains("Firefox") Then

            Return getMessage(page, "Firefox") & detectBrowserVersion(page, "Firefox")

        ElseIf page.Request.UserAgent.Contains("Chrome") Then

            Return getMessage(page, "Chrome") & detectBrowserVersion(page, "Chrome")

        ElseIf page.Request.UserAgent.Contains("Safari") Then

            Return getMessage(page, "Safari") & detectBrowserVersion(page, "Safari")

        End If

        Return getMessage(page, "IE7")

    End Function


    Public Function detectBrowserLanguage(ByVal page As System.Web.UI.Page) As String

        Return page.Request.ServerVariables("HTTP_ACCEPT_LANGUAGE").Substring(0, 5).Replace("-", "").ToLower

    End Function


    Public Function findRemoteIP(ByVal page As System.Web.UI.Page) As String

        Dim ip As String = "0.0.0.0"

        ip = page.Request.ServerVariables("HTTP_X_FORWARDED_FOR")

        If Not String.IsNullOrEmpty(ip) Then

            Dim ipRange() As String = ip.Split(",")
            Dim le As Integer = ipRange.Length - 1
            Dim TrueIP As String = ipRange(le)
            'Dim TrueIP As String =  ipRange(0) 

        Else

            ip = page.Request.ServerVariables("REMOTE_ADDR")

        End If

        Return ip

    End Function


    Public Function findRemoteMachineName() As String

        Return Environ$("ComputerName")

    End Function


    Public Sub clearanceCheck(ByVal page As System.Web.UI.Page)

        If page.Session("username") = "" Then
            page.Response.Redirect("sessionEnd.aspx")
        End If

        Dim path() As String = page.Request.FilePath.Split("/")
        Dim nombrepagina As String = path(path.Length - 1)

        If permissionCheck(page.Session("username"), nombrepagina) = False Then
            page.Response.Redirect("noRight.aspx?from=" & nombrepagina)
        End If

    End Sub


    Public Function permissionCheck(ByVal who As String, Optional ByVal url As String = "", Optional ByVal moduleID As String = "") As Boolean

        Dim query As String = "" & _
        "SELECT p.* FROM userpermissions p " & _
        "JOIN modules m ON p.smoduleid = m.smoduleID " & _
        "WHERE p.susername = '" & who & "' "

        If url <> "" Then
            query &= "AND m.surl = '" & url & "' "
        End If

        If moduleID <> "" Then
            query &= "AND m.smoduleid = '" & moduleID & "' "
        End If

        If getSQLQueryAsString(query).Equals("") Then
            Return False
        Else
            Return True
        End If

    End Function


    Public Function verifyIfUserResetHashIsCorrect(ByVal usernameANDdatehash As String) As String

        Dim dsUsers As DataSet = getSQLQueryAsDataset("SELECT susername, CONCAT(susername, DATE_FORMAT(requestdate,'%Y%m%d')) as tohash FROM passwordresetrequests WHERE TIMEDIFF(requestdate, DATE_ADD(NOW(), INTERVAL 3 HOUR)) < '-23:59:59'")

        For i = 0 To dsUsers.Tables(0).Rows.Count - 1

            Dim test As String = dsUsers.Tables(0).Rows(i).Item(1)
            Dim test2 As String = EncryptText(dsUsers.Tables(0).Rows(i).Item(1))

            If EncryptText(dsUsers.Tables(0).Rows(i).Item(1)) = usernameANDdatehash Then
                Return dsUsers.Tables(0).Rows(i).Item(0)
            End If

        Next i

        Return ""

    End Function


    Public Function verifyIfUserIsReallyLogged(ByVal page As System.Web.UI.Page) As Boolean

        Dim dsUserData As DataSet

        If page.Session("username") = "" Then

            Return False

        ElseIf page.Session("username") <> "" And (page.Session("fullName") = "" Or page.Session("desiredName") = "" Or page.Session("email") = "" Or page.Session("preferredLanguage") = "" Or CStr(page.Session("online?")) = "" Or CStr(page.Session("active?")) = "" Or CStr(page.Session("approved?")) = "" Or CStr(page.Session("lockedout?")) = "" Or CStr(page.Session("userlevel")) = "" Or CStr(page.Session("IT?")) = "" Or CStr(page.Session("admin?")) = "") Then

            cleanSession(page)
            Return False

        Else

            'Verify if someone has been messing with the variables...
            dsUserData = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, u.suseremail, u.spreferredlanguage, u.bactive, u.bonline, u.bapproved, u.blockedout, u.icompanyid, u.iuserlevel, u.sparentusername, IF(up.bIT IS NULL, 0, up.bIT) AS bIT, IF(up.bAdmin IS NULL, 0, up.bAdmin) AS bAdmin FROM users u LEFT JOIN userprofiles up ON u.susername = up.susername WHERE u.susername = '" & page.Session("username") & "' LIMIT 1")

            If page.Session("username") <> "" And (page.Session("fullName") <> dsUserData.Tables(0).Rows(0).Item("suserfullname") Or page.Session("desiredName") <> dsUserData.Tables(0).Rows(0).Item("suserdesiredname") Or page.Session("email") <> dsUserData.Tables(0).Rows(0).Item("suseremail") Or CStr(page.Session("online?")) <> dsUserData.Tables(0).Rows(0).Item("bonline") Or CStr(page.Session("active?")) <> dsUserData.Tables(0).Rows(0).Item("bactive") Or CStr(page.Session("approved?")) <> dsUserData.Tables(0).Rows(0).Item("bapproved") Or CStr(page.Session("lockedout?")) <> dsUserData.Tables(0).Rows(0).Item("blockedout") Or CStr(page.Session("userlevel")) <> dsUserData.Tables(0).Rows(0).Item("iuserlevel") Or CStr(page.Session("IT?")) <> dsUserData.Tables(0).Rows(0).Item("bIT") Or CStr(page.Session("admin?")) <> dsUserData.Tables(0).Rows(0).Item("bAdmin") Or page.Session("parentlogin") <> dsUserData.Tables(0).Rows(0).Item("sparentusername")) Then

                cleanSession(page)
                Return False

            Else
                Return True
            End If

        End If


    End Function


    Public Function createUserSessionVariables(ByVal page As System.Web.UI.Page, ByVal who As String) As Boolean

        Dim dsUserData As DataSet

        dsUserData = getSQLQueryAsDataset("SELECT u.susername, u.suserfullname, u.suserdesiredname, u.suseremail, u.spreferredlanguage, u.bactive, u.bonline, u.bapproved, u.blockedout, c.scompanyname, u.iuserlevel, u.sparentusername, IF(up.bIT IS NULL, 0, up.bIT) AS bIT, IF(up.bAdmin IS NULL, 0, up.bAdmin) AS bAdmin FROM users u JOIN companies c ON c.icompanyid = u.icompanyid LEFT JOIN userprofiles up ON u.susername = up.susername WHERE u.susername = '" & who & "' LIMIT 1")

        page.Session("username") = dsUserData.Tables(0).Rows(0).Item("susername")
        page.Session("fullName") = dsUserData.Tables(0).Rows(0).Item("suserfullname")
        page.Session("desiredName") = dsUserData.Tables(0).Rows(0).Item("suserdesiredname")
        page.Session("email") = dsUserData.Tables(0).Rows(0).Item("suseremail")
        page.Session("preferredLanguage") = dsUserData.Tables(0).Rows(0).Item("spreferredlanguage")
        page.Session("active?") = dsUserData.Tables(0).Rows(0).Item("bactive")
        page.Session("online?") = dsUserData.Tables(0).Rows(0).Item("bonline")
        page.Session("approved?") = dsUserData.Tables(0).Rows(0).Item("bapproved")
        page.Session("lockedout?") = dsUserData.Tables(0).Rows(0).Item("blockedout")
        page.Session("userlevel") = dsUserData.Tables(0).Rows(0).Item("iuserlevel")
        page.Session("IT?") = dsUserData.Tables(0).Rows(0).Item("bIT")
        page.Session("admin?") = dsUserData.Tables(0).Rows(0).Item("bAdmin")
        page.Session("parentlogin") = dsUserData.Tables(0).Rows(0).Item("sparentusername")
        page.Session("companyName") = dsUserData.Tables(0).Rows(0).Item("scompanyname")

        Return True

    End Function


    Public Sub cleanSession(ByVal page As System.Web.UI.Page)

        page.Session("username") = ""
        page.Session("fullName") = ""
        page.Session("desiredName") = ""
        page.Session("email") = ""
        page.Session("preferredLanguage") = detectBrowserLanguage(page)
        page.Session("active?") = ""
        page.Session("online?") = ""
        page.Session("approved?") = ""
        page.Session("lockedout?") = ""
        page.Session("userlevel") = ""
        page.Session("IT?") = ""
        page.Session("admin?") = ""
        page.Session("parentlogin") = ""
        page.Session("companyName") = ""

    End Sub


    Public Function createNewSessionID() As Boolean

        Try

            Dim Manager As New SessionState.SessionIDManager()
            Dim NewID As String = Manager.CreateSessionID(HttpContext.Current)
            Dim OldID As String = HttpContext.Current.Session.SessionID
            Dim IsAdded As Boolean = True
            Manager.SaveSessionID(HttpContext.Current, NewID, False, IsAdded)
            Return True

        Catch ex As Exception

            Return False

        End Try

    End Function


    Public Function removeLockOutFromUsers(ByVal origen As System.Web.UI.Page)

        Dim fecha As String = ""

        fecha = getMySQLDate()

        Dim dsLockedUsers As DataSet
        dsLockedUsers = getSQLQueryAsDataset("SELECT l.susername FROM sqllogs l JOIN users u ON l.susername = u.susername WHERE sactiondone = 'Locked out preventively - We believe this account was being hacked.' AND TIMEDIFF(querydate, DATE_ADD(NOW(), INTERVAL 3 HOUR)) > '-00:10:00' AND u.blockedout = 1")

        For i As Integer = 0 To dsLockedUsers.Tables(0).Rows.Count - 1

            Dim ilogid As Integer = 1
            ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

            Dim queries(2) As String

            queries(0) = "UPDATE users SET blockedout = 0 WHERE susername = '" & dsLockedUsers.Tables(0).Rows(i).Item(0) & "'"
            queries(1) = "INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & dsLockedUsers.Tables(0).Rows(i).Item(0) & "', '', '127.0.0.1', 'SPHYNX', 'Login Permises granted again after Lock Out', '1')"

            executeTransactedSQLCommand(queries)

        Next

        Return True

    End Function


    Public Function logoutIdleUsers(ByVal origen As System.Web.UI.Page) As Boolean

        Dim fecha As String = getMySQLDate()

        Dim timeToTimeout As Integer = 0

        timeToTimeout = getMinutesOfInactivityToLogout()

        If getSQLQueryAsString("SELECT squeryname FROM longquerieslogs") = "" Then
            executeSQLCommand("INSERT IGNORE INTO longquerieslogs VALUES ('" & fecha & "', 'Timeout Query') ")
        End If

        Dim MinutesSinceLastRun As Integer = getSQLQueryAsInteger("" & _
        "SELECT " & _
        "MINUTE(TIMEDIFF('" & fecha & "', l.querydate)) " & _
        "FROM ( " & _
        "SELECT * FROM (SELECT * FROM longquerieslogs WHERE squeryname = 'Timeout Query' ORDER BY querydate DESC) l GROUP BY squeryname) l ")

        If MinutesSinceLastRun < timeToTimeout Then
            Exit Function
        End If

        Dim queryTimedOutConnections As String = ""

        queryTimedOutConnections = "" & _
        "SELECT l.susername, l.susersession, l.querydate, s.logindate, s.suserip, s.susermachinename " & _
        "FROM sessions s " & _
        "JOIN ( " & _
        "        SELECT querydate, susername, susersession, " & _
        "        MINUTE(TIMEDIFF('" & fecha & "', l.querydate)) " & _
        "        FROM ( " & _
        "              SELECT * FROM ( " & _
        "                              SELECT * FROM sqllogs ORDER BY querydate DESC " & _
        "              ) l " & _
        "              GROUP BY susername, susersession " & _
        "              ORDER BY querydate DESC " & _
        "        ) l " & _
        "        WHERE " & _
        "        MINUTE(TIMEDIFF('" & fecha & "', l.querydate)) > " & timeToTimeout & " " & _
        "        ORDER BY querydate DESC, susername ASC " & _
        ") l " & _
        "ON s.susername = l.susername AND s.susersession = l.susersession " & _
        "AND s.bloggedinsuccesfully = 1 " & _
        "AND s.logoutdate IS NULL " & _
        "AND l.susername <> 'SYSTEM' " & _
        "GROUP BY s.susername, s.susersession " & _
        "ORDER BY l.querydate DESC "

        Dim dsTimedOutConnections As DataSet

        dsTimedOutConnections = getSQLQueryAsDataset(queryTimedOutConnections)

        If dsTimedOutConnections.Tables(0).Rows.Count > 0 Then

            Dim queriesLogout(4) As String

            For i = 0 To dsTimedOutConnections.Tables(0).Rows.Count - 1

                Dim ilogid As Integer = 1
                ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

                If getSQLQueryAsInteger("SELECT COUNT(*) FROM sessions WHERE susername = '" & dsTimedOutConnections.Tables(0).Rows(i).Item("susername") & "' AND logoutdate IS NULL") = 1 Then
                    queriesLogout(0) = "UPDATE users SET bonline = 0 WHERE susername = '" & dsTimedOutConnections.Tables(0).Rows(i).Item("susername") & "'"
                End If

                queriesLogout(1) = "UPDATE sessions SET btimedout = 1, logoutdate = '" & fecha & "' WHERE susername = '" & dsTimedOutConnections.Tables(0).Rows(i).Item("susername") & "' AND susersession = '" & dsTimedOutConnections.Tables(0).Rows(i).Item("susersession") & "'  AND logindate = '" & dsTimedOutConnections.Tables(0).Rows(i).Item("logindate") & "'"

                queriesLogout(2) = "INSERT IGNORE INTO longquerieslogs VALUES ('" & fecha & "', 'Timeout Query') "

                queriesLogout(3) = "INSERT IGNORE INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & dsTimedOutConnections.Tables(0).Rows(i).Item("susername") & "', '" & dsTimedOutConnections.Tables(0).Rows(i).Item("susersession") & "', '" & dsTimedOutConnections.Tables(0).Rows(i).Item("suserip") & "', '" & dsTimedOutConnections.Tables(0).Rows(i).Item("susermachinename") & "', 'Logout from Timeout', '1')"

                executeTransactedSQLCommand(queriesLogout)

            Next i

            Return True

        Else

            executeSQLCommand("INSERT IGNORE INTO longquerieslogs VALUES ('" & fecha & "', 'Timeout Query') ")

            Return False

        End If

    End Function


    Public Function verifyIfItIsHackingAttempts(ByVal origen As System.Web.UI.Page, ByVal ip As String, ByVal machineName As String) As Boolean

        Dim fecha As String = ""

        fecha = getMySQLDate()

        Dim dsCountUsersBeingHacked As DataSet
        dsCountUsersBeingHacked = getSQLQueryAsDataset("SELECT susername, susersession, COUNT(susername) as conteo FROM sqllogs WHERE TIMEDIFF(querydate, DATE_ADD(NOW(), INTERVAL 3 HOUR)) < '-00:10:00' AND (sactiondone = 'Login Attempt from page login.aspx with a false result' OR sactiondone = 'Login Attempt from page reopen.aspx with a false result') GROUP BY susername;")

        Dim dsITEmployees As DataSet
        dsITEmployees = getSQLQueryAsDataset("SELECT DISTINCT u.susername FROM users u JOIN userprofiles up ON u.susername = up.susername WHERE up.bIT = 1")

        For i As Integer = 0 To dsCountUsersBeingHacked.Tables(0).Rows.Count - 1

            If getSQLQueryAsInteger("SELECT blockedout FROM users WHERE susername = '" & dsCountUsersBeingHacked.Tables(0).Rows(i).Item(0) & "'") > 0 Then
                Continue For
            End If

            If getSQLQueryAsString("SELECT susername FROM users WHERE susername = '" & dsCountUsersBeingHacked.Tables(0).Rows(i).Item(0) & "'") = "" Then
                Continue For
            End If

            If CInt(dsCountUsersBeingHacked.Tables(0).Rows(i).Item(2)) >= 4 Then

                executeSQLCommand("UPDATE users SET blockedout = 1 WHERE susername = '" & dsCountUsersBeingHacked.Tables(0).Rows(i).Item(0) & "'")

                Dim inoticeid As Integer = 1
                inoticeid = getSQLQueryAsInteger("SELECT IF(MAX(inoticeid) + 1 IS NULL, 1, MAX(inoticeid) + 1) AS inoticeid FROM usernotices ORDER BY noticingdate DESC LIMIT 1")

                executeSQLCommand("INSERT INTO usernotices VALUES(" & inoticeid & ", '" & dsCountUsersBeingHacked.Tables(0).Rows(i).Item(0) & "', '', 'We have detected several unsuccessful login attempts going on " & fecha & ". We disabled your login for 10 minutes at that time to prevent unauthorized access. If this wasnt you or you think your account may be compromised, we suggest you change your password. If it was you, please disregard this message.', 'SPHYNX', '" & fecha & "', 0, NULL)")

                Dim ilogid As Integer = 1
                ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

                executeSQLCommand("INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & dsCountUsersBeingHacked.Tables(0).Rows(i).Item(0) & "', '" & origen.Session.SessionID & "', '" & ip & "', '" & machineName & "', 'Locked out preventively - We believe this account was being hacked.', '0')")

                If dsITEmployees.Tables(0).Rows.Count > 0 Then

                    For k As Integer = 0 To dsITEmployees.Tables(0).Rows.Count - 1

                        Dim i2ndnoticeid As Integer = 1
                        i2ndnoticeid = getSQLQueryAsInteger("SELECT IF(MAX(inoticeid) + 1 IS NULL, 1, MAX(inoticeid) + 1) AS inoticeid FROM usernotices ORDER BY noticingdate DESC LIMIT 1")
                        executeSQLCommand("INSERT INTO usernotices VALUES(" & i2ndnoticeid & ", '" & dsITEmployees.Tables(0).Rows(k).Item(0) & "', '', 'User account is allegedly being hacked!', 'SPHYNX', '" & fecha & "', 0, NULL)")

                    Next

                End If

            End If

        Next i

    End Function


    Public Function switchOnOffSystem(ByVal who As String) As Boolean

        Dim status As Integer

        Dim fecha As Integer = getYYYYMMDDMySQLDate()

        status = getSQLQueryAsInteger("SELECT svalue FROM systemvariables WHERE svariable = 'systemOnline'")

        If status = 1 Then
            status = 0
        Else
            status = 1
        End If

        Dim queries(3) As String

        queries(0) = "UPDATE systemvariables SET svalue = '" & status & "' WHERE svariable = 'systemOnline'"
        queries(1) = "UPDATE systemvariables SET svalue = '" & getMySQLDate() & "' WHERE svariable = 'systemStatusSince'"

        If executeTransactedSQLCommand(queries) = True Then
            Return True
        Else
            Return False
        End If

    End Function


    Public Function switchOnOffModule(ByVal who As String, ByVal smoduleid As String) As Boolean

        Dim status As Integer

        Dim fecha As Integer = getYYYYMMDDMySQLDate()

        status = getSQLQueryAsInteger("SELECT bstatus FROM modules WHERE smoduleid = '" & smoduleid & "'")

        If status = 1 Then
            status = 0
        Else
            status = 1
        End If

        If executeSQLCommand("UPDATE modules SET bstatus = " & status & ", spermissiongrantingusername = '" & who & "', permissiongrantingdate = '" & fecha & "' WHERE smoduleid = '" & smoduleid & "'") = True Then
            Return True
        Else
            Return False
        End If

    End Function


    Public Function getMinutesOfInactivityToLogout() As Integer

        Return getSQLQueryAsInteger("SELECT svalue FROM systemvariables WHERE svariable = 'minutesToTimeoutLessThan59'")

    End Function


    '========================================================================================
    ' Logger Functions


    Public Function checkLogin(ByVal username As String, ByVal password As String) As String

        '-5 = User not existent
        '-4 = Incorrect Password
        '-3 = Inactive
        '-2 = Not approved
        '-1 = Locked out
        '0 = Already Logged In
        'Else = Username

        Dim dbUsername As String = ""

        dbUsername = getSQLQueryAsString("SELECT susername FROM users WHERE susername = '" & username & "' AND suserpasswordhash = '" & EncryptText(password) & "'")

        If dbUsername.Equals("") Then

            'Verify if username entered is the email
            dbUsername = getSQLQueryAsString("SELECT susername FROM users WHERE suseremail = '" & username & "' AND suserpasswordhash = '" & EncryptText(password) & "'")

            If dbUsername.Equals("") Then

                If getSQLQueryAsString("SELECT susername FROM users WHERE susername = '" & username & "'") = "" Then
                    Return "-5"
                Else

                    Dim userStatus As DataSet
                    userStatus = getSQLQueryAsDataset("SELECT blockedout FROM users WHERE susername = '" & username & "'")

                    If userStatus.Tables(0).Rows(0).Item("blockedout") = "1" Then
                        Return "-1"
                    Else
                        Return "-4"
                    End If

                End If

            Else

                If getSQLQueryAsInteger("SELECT svalue FROM systemvariables WHERE svariable = 'multipleLogins'") = 0 Then

                    Dim userStatus As DataSet
                    userStatus = getSQLQueryAsDataset("SELECT bactive, bapproved, blockedout FROM users WHERE susername = '" & username & "'")

                    'Verify if its active
                    If userStatus.Tables(0).Rows(0).Item("bactive") = "0" Then
                        Return "-3"
                    End If

                    'Verify if its approved
                    If userStatus.Tables(0).Rows(0).Item("bapproved") = "0" Then
                        Return "-2"
                    End If

                    'Verify if its Locked Out
                    If userStatus.Tables(0).Rows(0).Item("blockedout") = "1" Then
                        Return "-1"
                    End If

                    'Verify if its already logged in
                    Dim timeToTimeout As Integer = 0
                    timeToTimeout = getSQLQueryAsInteger("SELECT svalue FROM systemvariables WHERE svariable = 'minutesToTimeoutLessThan59'")

                    Dim alreadyLoggedIn As String = ""
                    alreadyLoggedIn = getSQLQueryAsString("SELECT susername FROM sessions WHERE susername = '" & username & "' AND logoutdate IS NULL AND TIMEDIFF(logindate, NOW()) < '-00:" & timeToTimeout & ":00'")

                    If alreadyLoggedIn <> "" Then
                        Return "0"
                    Else
                        Return dbUsername
                    End If

                Else  ' MultipleLogins

                    Dim userStatus As DataSet
                    userStatus = getSQLQueryAsDataset("SELECT bactive, bapproved, blockedout FROM users WHERE susername = '" & username & "'")

                    'Verify if its active
                    If userStatus.Tables(0).Rows(0).Item("bactive") = "0" Then
                        Return "-3"
                    End If

                    'Verify if its approved
                    If userStatus.Tables(0).Rows(0).Item("bapproved") = "0" Then
                        Return "-2"
                    End If

                    'Verify if its Locked Out
                    If userStatus.Tables(0).Rows(0).Item("blockedout") = "1" Then
                        Return "-1"
                    End If

                    Return dbUsername

                End If

            End If

        Else    'Username & password correct

            If getSQLQueryAsInteger("SELECT svalue FROM systemvariables WHERE svariable = 'multipleLogins'") = 0 Then

                Dim userStatus As DataSet
                userStatus = getSQLQueryAsDataset("SELECT bactive, bapproved, blockedout FROM users WHERE susername = '" & username & "'")

                'Verify if its active
                If userStatus.Tables(0).Rows(0).Item("bactive") = "0" Then
                    Return "-3"
                End If

                'Verify if its approved
                If userStatus.Tables(0).Rows(0).Item("bapproved") = "0" Then
                    Return "-2"
                End If

                'Verify if its Locked Out
                If userStatus.Tables(0).Rows(0).Item("blockedout") = "1" Then
                    Return "-1"
                End If

                'Verify if its already logged in
                Dim timeToTimeout As Integer = 0
                timeToTimeout = getSQLQueryAsInteger("SELECT svalue FROM systemvariables WHERE svariable = 'minutesToTimeoutLessThan59'")

                Dim alreadyLoggedIn As String = ""
                alreadyLoggedIn = getSQLQueryAsString("SELECT susername FROM sessions WHERE susername = '" & username & "' AND logoutdate IS NULL AND TIMEDIFF(logindate, NOW()) < '-00:" & timeToTimeout & ":00'")

                If alreadyLoggedIn <> "" Then
                    Return "0"
                Else
                    Return dbUsername
                End If

            Else

                Dim userStatus As DataSet
                userStatus = getSQLQueryAsDataset("SELECT bactive, bapproved, blockedout FROM users WHERE susername = '" & username & "'")

                'Verify if its active
                If userStatus.Tables(0).Rows(0).Item("bactive") = "0" Then
                    Return "-3"
                End If

                'Verify if its approved
                If userStatus.Tables(0).Rows(0).Item("bapproved") = "0" Then
                    Return "-2"
                End If

                'Verify if its Locked Out
                If userStatus.Tables(0).Rows(0).Item("blockedout") = "1" Then
                    Return "-1"
                End If

                Return dbUsername

            End If

        End If

    End Function


    Public Function logLogin(ByVal origen As System.Web.UI.Page, ByVal username As String, ByVal ip As String, ByVal machineName As String, ByVal resultOK As Boolean) As Boolean


        Dim lok As String = "0"

        If resultOK = True Then
            lok = "1"
        Else
            lok = "0"
        End If

        Dim pedazos() As String = origen.Request.FilePath.Split("/")
        Dim page As String = pedazos(pedazos.Length - 1)

        Dim fecha As String = ""
        Dim hora As String = ""

        fecha = getMySQLDate()
        hora = getAppTime()

        'Log the Login Attempt

        Dim ilogid As Integer = 1
        ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

        If getSQLQueryAsInteger("SELECT blockedout FROM users WHERE susername = '" & username & "'") = 0 Then
            executeSQLCommand("INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & username & "', '" & origen.Session.SessionID & "', '" & ip & "', '" & machineName & "', 'Login Attempt from Page " & page & " with a " & resultOK & " result', '" & lok & "')")
        End If

        If resultOK Then

            'Succesful Login
            Dim queries(2) As String

            queries(0) = "UPDATE users SET bonline = '1' WHERE susername = '" & username & "'"
            queries(1) = "INSERT INTO sessions VALUES('" & username & "', '" & origen.Session.SessionID & "', 1, 0, 0, 0, '" & ip & "', '" & machineName & "', '" & fecha & "', NULL)"

            If executeTransactedSQLCommand(queries) Then
                createUserSessionVariables(origen, username)
            End If

            'Logout idle users
            logoutIdleUsers(origen)

            'Verify if there are any user locked out that need their permises granted again
            removeLockOutFromUsers(origen)

            Return True

        Else

            'Check if someone is trying to hack the account
            verifyIfItIsHackingAttempts(origen, ip, machineName)

            'Logout idle users
            logoutIdleUsers(origen)

            'Verify if there are any user locked out that need their permises granted again
            removeLockOutFromUsers(origen)

            Return False

        End If

    End Function


    Public Function logLogout(ByVal origen As System.Web.UI.Page, ByVal username As String, ByVal ip As String, ByVal machinename As String) As Boolean

        'Logout current user

        Dim pedazos() As String = origen.Request.FilePath.Split("/")
        Dim page As String = pedazos(pedazos.Length - 1)

        Dim fecha As String = ""

        fecha = getMySQLDate()

        Dim ilogid As Integer = 1
        ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

        Dim queries(3) As String

        queries(0) = "INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & username & "', '" & origen.Session.SessionID & "', '" & ip & "', '" & machinename & "', 'Logout from Page " & page & "', '1')"
        queries(1) = "UPDATE sessions SET logoutdate = '" & fecha & "' WHERE susername = '" & username & "' AND susersession = '" & origen.Session.SessionID & "'"
        queries(2) = "UPDATE users SET bonline = '0' WHERE susername = '" & username & "'"

        If executeTransactedSQLCommand(queries) = False Then
            Return False
        End If

        'Logout idle users
        logoutIdleUsers(origen)

        'Verify if there are any user locked out that need their permises granted again
        removeLockOutFromUsers(origen)

        Return True

    End Function


    '========================================================================================
    ' Labels Functions


    Public Function setLabels(ByRef origen As System.Web.UI.Page) As Boolean

        Dim dsDatos As DataSet
        Dim dsLang As DataSet
        Dim Lang As String

        Dim langFound As Integer = 0
        Dim pedazos() As String = origen.Request.FilePath.Split("/")
        Dim page As String = pedazos(pedazos.Length - 1)

        Lang = origen.Session("preferredLanguage")

        dsLang = getSQLQueryAsDataset("SELECT ilanguageid, slanguagecode FROM languages ORDER BY 2")

        If Lang = "" Then Lang = detectBrowserLanguage(origen)

        For i As Integer = 0 To dsLang.Tables(0).Rows.Count - 1

            Try

                If dsLang.Tables(0).Rows(i).Item("slanguagecode") = Lang Then
                    langFound = langFound + 1
                End If

            Catch ex As Exception

            End Try

        Next

        If langFound = 0 Then
            Lang = "enus"
            origen.Session("preferredLanguage") = "enus"
        End If

        Dim consulta As String = "SELECT spage, slabel, " & Lang & " FROM labels WHERE spage = '" & page & "' OR spage = 'menu' OR spage = 'datagrid'"
        dsDatos = getSQLQueryAsDataset(consulta)

        For i As Integer = 0 To dsDatos.Tables(0).Rows.Count - 1

            'se puede no usar este if, pero así, nos evitamos buscar las
            'etiquetas genéricas en el formulario innecesariamente
            'If CStr(Datos.Tables(0).Rows(i).Item(0)).EndsWith(".aspx") Then

            Try
                Dim objeto As System.Web.UI.Control
                objeto = origen.FindControl(dsDatos.Tables(0).Rows(i).Item(1))
                Dim mutator As System.Reflection.MethodInfo
                mutator = objeto.GetType.GetProperty("Text").GetSetMethod()
                Dim parametros() As String = {dsDatos.Tables(0).Rows(i).Item(Lang)}
                mutator.Invoke(objeto, parametros)
            Catch
                'Return False
            End Try


            'FAILSAFE TO ENSURE THAT NEWBIES DON'T MESS UP WITH USERS' NAMES
            If dsDatos.Tables(0).Rows(i).Item(1) = "lblUserDesiredName" And origen.Session("username") <> "" Then

                Try
                    Dim objeto As System.Web.UI.Control
                    objeto = origen.FindControl(dsDatos.Tables(0).Rows(i).Item(1))
                    Dim mutator As System.Reflection.MethodInfo
                    mutator = objeto.GetType.GetProperty("Text").GetSetMethod()
                    Dim parametros() As String = {origen.Session("desiredName")}
                    mutator.Invoke(objeto, parametros)
                Catch
                    'Return False
                End Try

            End If


            Try
                Dim objeto As System.Web.UI.WebControls.Image
                objeto = origen.FindControl(dsDatos.Tables(0).Rows(i).Item(1))
                Dim mutator As System.Reflection.MethodInfo
                mutator = objeto.GetType.GetProperty("AlternateText").GetSetMethod()
                Dim parametros() As String = {dsDatos.Tables(0).Rows(i).Item(Lang)}
                mutator.Invoke(objeto, parametros)
                mutator = objeto.GetType.GetProperty("ToolTip").GetSetMethod()
                mutator.Invoke(objeto, parametros)
            Catch
                'Return False
            End Try


            Try
                Dim objeto As System.Web.UI.WebControls.RequiredFieldValidator
                objeto = origen.FindControl(dsDatos.Tables(0).Rows(i).Item(1))
                Dim mutator As System.Reflection.MethodInfo
                mutator = objeto.GetType.GetProperty("ErrorMessage").GetSetMethod()
                Dim parametros() As String = {dsDatos.Tables(0).Rows(i).Item(Lang)}
                mutator.Invoke(objeto, parametros)
                mutator = objeto.GetType.GetProperty("Text").GetSetMethod()
                Dim parametros2() As String = {"*"}
                mutator.Invoke(objeto, parametros2)
            Catch
                'Return False
            End Try


            Try
                Dim objeto As System.Web.UI.Control
                objeto = origen.FindControl(dsDatos.Tables(0).Rows(i).Item(1))
                Dim mutator As System.Reflection.MethodInfo
                mutator = objeto.GetType.GetProperty("WatermarkText").GetSetMethod()
                Dim parametros() As String = {dsDatos.Tables(0).Rows(i).Item(Lang)}
                mutator.Invoke(objeto, parametros)
            Catch
                'Return False
            End Try


            'End If

        Next

        Return True

    End Function


    Public Function getMessage(ByRef origen As System.Web.UI.Page, ByVal labelid As String) As String

        Dim pedazos() As String = origen.Request.FilePath.Split("/")
        Dim pagina As String = pedazos(pedazos.Length - 1)

        Dim dsLang As DataSet
        Dim Lang As String

        Dim langFound As Integer = 0

        Lang = origen.Session("preferredLanguage")

        dsLang = getSQLQueryAsDataset("SELECT ilanguageid, slanguagecode FROM languages ORDER BY 2")

        If Lang = "" Then Lang = detectBrowserLanguage(origen)

        For i As Integer = 0 To dsLang.Tables(0).Rows.Count - 1

            Try

                If dsLang.Tables(0).Rows(i).Item("slanguagecode") = Lang Then
                    langFound = langFound + 1
                End If

            Catch ex As Exception

            End Try

        Next

        If langFound = 0 Then
            Lang = "enus"
            origen.Session("preferredLanguage") = "enus"
        End If

        Dim labels As New DataSet
        labels = getSQLQueryAsDataset("SELECT spage, slabel, " & Lang & " FROM labels WHERE spage = '" & pagina & "' AND slabel = '" & labelid & "'")

        If labels.Tables(0).Rows.Count <= 0 Then
            'Return "Mensaje no encontrado"
            Return labelid
        Else
            Dim mensaje As String = labels.Tables(0).Rows(0).Item(2)
            Return mensaje
        End If

    End Function

    'Public Function getMessage(ByVal id As String) As String

    '    Dim filtro As String = "labelid='" & id & "'"
    '    Dim filas() As DataRow = Datos.Tables(0).Select(filtro)

    '    If filas.Length <= 0 Then
    '        Return "Mensaje no encontrado"
    '    Else
    '        Return filas(0).Item(Lang)
    '    End If

    'End Function


    '========================================================================================
    ' Mail Functions


    Public Function sendPlainMail(ByVal toEmail As String, ByVal subject As String, ByVal body As String) As Boolean

        Try

            Dim email As New MailMessage()
            Dim maFrom As New MailAddress("gzebadua@gmail.com", "Sphynx Team")

            email.[To].Add(toEmail)
            email.From = maFrom
            email.Subject = subject
            email.Body = body


            Dim smtp As SmtpClient = New SmtpClient("smtp.gmail.com", 587) 'or 587 or 25
            smtp.Timeout = 30000
            smtp.Credentials = New System.Net.NetworkCredential(maFrom.Address, "DLF1594G")

            smtp.DeliveryMethod = SmtpDeliveryMethod.Network
            smtp.EnableSsl = True

            smtp.Send(email)

            Return True

        Catch ex As Exception

            Try

                SendMailAlt("smtp.gmail.com", 465, "gzebadua@gmail.com", "DLF1594G", "Sphynx Team", "gzebadua@gmail.com", "", toEmail, subject, body, True)
                Return True
            Catch ex2 As Exception
                executeSQLCommand("INSERT INTO errorlogs VALUES ('" & getMySQLDate() & "', '" & ex.ToString & "')")
                Return False
            End Try

        End Try

    End Function


    Public Function sendHTMLMail(ByVal toEmail As String, ByVal subject As String, ByVal body As String) As Boolean

        Try

            Dim email As New MailMessage()
            Dim maFrom As New MailAddress("gzebadua@gmail.com", "Sphynx Team")

            email.[To].Add(toEmail)
            email.From = maFrom
            email.Subject = subject
            email.Body = body
            email.IsBodyHtml = True


            Dim smtp As SmtpClient = New SmtpClient("smtp.gmail.com", 587) 'or 587 or 25
            smtp.Timeout = 30000
            smtp.Credentials = New System.Net.NetworkCredential(maFrom.Address, "DLF1594G")

            smtp.DeliveryMethod = SmtpDeliveryMethod.Network
            smtp.EnableSsl = True

            smtp.Send(email)

            Return True

        Catch ex As Exception

            Try

                SendMailAlt("smtp.gmail.com", 465, "gzebadua@gmail.com", "DLF1594G", "Sphynx Team", "gzebadua@gmail.com", "", toEmail, subject, body, True)
                Return True
            Catch ex2 As Exception
                executeSQLCommand("INSERT INTO errorlogs VALUES ('" & getMySQLDate() & "', '" & ex.ToString & "')")
                Return False
            End Try

        End Try

    End Function


    Public Sub SendMailAlt(ByVal sHost As String, ByVal nPort As Integer, ByVal sUserName As String, ByVal sPassword As String, ByVal sFromName As String, ByVal sFromEmail As String, ByVal sToName As String, ByVal sToEmail As String, ByVal sHeader As String, ByVal sMessage As String, ByVal fSSL As Boolean)

        If sToName.Length = 0 Then
            sToName = sToEmail
        End If
        If sFromName.Length = 0 Then
            sFromName = sFromEmail
        End If

        Dim Mail As New System.Web.Mail.MailMessage()
        Mail.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver") = sHost
        Mail.Fields("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2

        Mail.Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = nPort.ToString()
        If fSSL Then
            Mail.Fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = "true"
        End If

        'Ingen auth 
        If sUserName.Length = 0 Then
        Else
            Mail.Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
            Mail.Fields("http://schemas.microsoft.com/cdo/configuration/sendusername") = sUserName
            Mail.Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword") = sPassword
        End If

        Mail.[To] = sToEmail
        Mail.From = sFromEmail
        Mail.Subject = sHeader
        Mail.Body = sMessage
        Mail.BodyFormat = System.Web.Mail.MailFormat.Html

        System.Web.Mail.SmtpMail.SmtpServer = sHost
        System.Web.Mail.SmtpMail.Send(Mail)

    End Sub


End Module
