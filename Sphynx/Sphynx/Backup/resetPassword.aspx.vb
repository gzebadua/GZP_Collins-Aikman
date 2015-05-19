Partial Public Class resetPassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        If Not IsPostBack Then

            setLabels(Me)
            showFlags(rptFlags)

            lblWelcomeDate.Text = Date.Now.ToLongDateString
            lblWelcomeTime.Text = Date.Now.ToShortTimeString()

            If Session("providedUsername") = "" Or verifyIfUserIsReallyLogged(Me) = False Then

                Response.Redirect("login.aspx")

            End If

        End If
        
    End Sub


    Private Sub rptFlags_ItemCommand(ByVal source As System.Object, ByVal e As System.Web.UI.WebControls.RepeaterCommandEventArgs) Handles rptFlags.ItemCommand

        Session("preferredLanguage") = e.CommandArgument

        setLabels(Me)

    End Sub


    Private Sub btnSaveNewPassword_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnSaveNewPassword.Click

        If isSystemOnline() = False Then
            Exit Sub
        End If

        If verifyIfUserIsReallyLogged(Me) = False Then
            Response.Redirect("login.aspx")
        End If

        lblWrongPass.Visible = False

        txtPassword.Text = txtPassword.Text.Trim()
        txtPassword.Text = txtPassword.Text.Replace("'", "")
        txtPassword.Text = txtPassword.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")
        txtRepeatPassword.Text = txtRepeatPassword.Text.Trim()
        txtRepeatPassword.Text = txtRepeatPassword.Text.Replace("'", "")
        txtRepeatPassword.Text = txtRepeatPassword.Text.Trim("'", "@", "´", "¨", "*", "+", "~", "{", "[", "}", "]", "^", "`", ";", ",", "?", "¿", "\", "¡", "|", "°", "#", "$", "%", "&", "&", "/", "(", ")", "<", ">", "!")

        'If a password matches a list of easy passwords...

        Dim dsUser As DataSet = getSQLQueryAsDataset("SELECT * FROM users WHERE susername = '" & Session("username") & "'")
        Dim userFullNamePart1 As String = ""
        Dim userFullNamePart2 As String = ""

        Dim badPasswords(211) As String

        badPasswords(0) = dsUser.Tables(0).Rows(0).Item("susername")
        badPasswords(1) = dsUser.Tables(0).Rows(0).Item("suserdesiredname")
        badPasswords(2) = dsUser.Tables(0).Rows(0).Item("suseremail")

        Try

            userFullNamePart1 = dsUser.Tables(0).Rows(0).Item("suserfullname").ToString.Substring(0, dsUser.Tables(0).Rows(0).Item("suserfullname").ToString.IndexOf(" "))
            userFullNamePart2 = dsUser.Tables(0).Rows(0).Item("suserfullname").ToString.Substring(dsUser.Tables(0).Rows(0).Item("suserfullname").ToString.IndexOf(" ") + 1)

        Catch ex As Exception

        End Try

        badPasswords(3) = userFullNamePart1
        badPasswords(4) = userFullNamePart2
        badPasswords(5) = "sphynx"
        badPasswords(6) = "00000"
        badPasswords(7) = "000000"
        badPasswords(8) = "12345"
        badPasswords(9) = "123456"
        badPasswords(10) = "1234567"
        badPasswords(11) = "12345678"
        badPasswords(12) = "123456789"
        badPasswords(13) = "1234567890"
        badPasswords(14) = "qwerty"
        badPasswords(15) = "qwertyu"
        badPasswords(16) = "qwertyui"
        badPasswords(17) = "qwertyuio"
        badPasswords(18) = "qwertyuiop"
        badPasswords(19) = "123qwe"
        badPasswords(20) = "1234qwer"
        badPasswords(21) = "123abc"
        badPasswords(22) = "1234abc"
        badPasswords(23) = "1234abcd"
        badPasswords(24) = "123asd"
        badPasswords(25) = "1234asd"
        badPasswords(26) = "1234asdf"
        badPasswords(27) = "88888888"
        badPasswords(28) = "abc123"
        badPasswords(29) = "abc1234"
        badPasswords(30) = "abcde"
        badPasswords(31) = "asdfg"
        badPasswords(32) = "computer"
        badPasswords(33) = "database"
        badPasswords(34) = "enable"
        badPasswords(35) = "admin123"
        badPasswords(36) = "administrator"
        badPasswords(37) = "password"
        badPasswords(38) = "secret"
        badPasswords(39) = "bonjour"
        badPasswords(40) = "password"
        badPasswords(41) = "godblessyou"
        badPasswords(42) = "ihavenopass"
        badPasswords(43) = "mypass"
        badPasswords(44) = "mypass123"
        badPasswords(45) = "server"
        badPasswords(46) = "oracle"
        badPasswords(47) = "temp123"
        badPasswords(48) = "test123"
        badPasswords(49) = "yxcvb"
        badPasswords(50) = "zxcvb"
        badPasswords(51) = "iloveyou"
        badPasswords(52) = "princess"
        badPasswords(53) = "princess."
        badPasswords(54) = "rockyou"
        badPasswords(55) = "babygirl"
        badPasswords(56) = "monkey"
        badPasswords(57) = "lovely"
        badPasswords(58) = "654321"
        badPasswords(59) = "54321"
        badPasswords(60) = "098765"
        badPasswords(61) = "09876"
        badPasswords(62) = "111111"
        badPasswords(63) = "11111"
        badPasswords(64) = "tigger"
        badPasswords(65) = "password1"
        badPasswords(66) = "sunshine"
        badPasswords(67) = "chocolate"
        badPasswords(68) = "anthony"
        badPasswords(69) = "FRIENDS"
        badPasswords(70) = "soccer"
        badPasswords(71) = "football"
        badPasswords(72) = "baseball"
        badPasswords(73) = "lifehack"
        badPasswords(74) = "consumer"
        badPasswords(75) = "letmein"
        badPasswords(76) = "trustno1"
        badPasswords(77) = "dragon"
        badPasswords(78) = "superman"
        badPasswords(79) = "starwars"
        badPasswords(80) = "whatever"
        badPasswords(81) = "shadow"
        badPasswords(82) = "cheese"
        badPasswords(83) = "123123"
        badPasswords(84) = "12341234"
        badPasswords(85) = "nintendo"
        badPasswords(86) = "f---you"
        badPasswords(87) = "fuckyou"
        badPasswords(88) = "blahblah"
        badPasswords(89) = "666666"
        badPasswords(90) = "7777777"
        badPasswords(91) = "welcome"
        badPasswords(92) = "pokemon"
        badPasswords(93) = "batman"
        badPasswords(94) = "internet"
        badPasswords(95) = "thisisfun"
        badPasswords(96) = "this is fun"
        badPasswords(97) = "rootkit"
        badPasswords(98) = "this is cool"
        badPasswords(99) = "thisiscool"
        badPasswords(100) = "this is my password"
        badPasswords(101) = "thisismypassword"
        badPasswords(102) = "this is my pass"
        badPasswords(103) = "thisismypass"
        badPasswords(104) = "this is me"
        badPasswords(105) = "thisisme"
        badPasswords(106) = "this is just a test"
        badPasswords(107) = "thisisjustatest"
        badPasswords(108) = "orange"
        badPasswords(109) = "blink182"
        badPasswords(110) = "bingo"
        badPasswords(111) = "porsche"
        badPasswords(112) = "arsenal"
        badPasswords(113) = "ncc1701"
        badPasswords(114) = "thx1138"
        badPasswords(115) = "mustang"
        badPasswords(116) = "696969"
        badPasswords(117) = "iwantu"
        badPasswords(118) = "access"
        badPasswords(119) = "121212"
        badPasswords(120) = "bitch"
        badPasswords(121) = "please"
        badPasswords(122) = "131313"
        badPasswords(123) = "guitar"
        badPasswords(124) = "black"
        badPasswords(125) = "diamond"
        badPasswords(126) = "nascar"
        badPasswords(127) = "wizard"
        badPasswords(128) = "xxxxxx"
        badPasswords(129) = "xxxxxxx"
        badPasswords(130) = "xxxxxxxx"
        badPasswords(131) = "xxxxxxxxx"
        badPasswords(132) = "horney"
        badPasswords(133) = "gandalf"
        badPasswords(134) = "fender"
        badPasswords(135) = "blowme"
        badPasswords(136) = "hardcore"
        badPasswords(137) = "yamaha"
        badPasswords(138) = "banana"
        badPasswords(139) = "fucking"
        badPasswords(140) = "captain"
        badPasswords(141) = "eagles"
        badPasswords(142) = "flower"
        badPasswords(143) = "firebird"
        badPasswords(144) = "bond007"
        badPasswords(145) = "matrix"
        badPasswords(146) = "cumshot"
        badPasswords(147) = "boobs"
        badPasswords(148) = "topgun"
        badPasswords(149) = "222222"
        badPasswords(150) = "2222222"
        badPasswords(151) = "22222222"
        badPasswords(152) = "prince"
        badPasswords(153) = "forever"
        badPasswords(154) = "helpme"
        badPasswords(155) = "444444"
        badPasswords(156) = "555555"
        badPasswords(157) = "erotic"
        badPasswords(158) = "rosebud"
        badPasswords(159) = "jaguar"
        badPasswords(160) = "dolphin"
        badPasswords(161) = "stupid"
        badPasswords(162) = "gemini"
        badPasswords(163) = "apples"
        badPasswords(164) = "rainbow"
        badPasswords(165) = "hentai"
        badPasswords(166) = "newyork"
        badPasswords(167) = "women"
        badPasswords(168) = "dreams"
        badPasswords(169) = "phantom"
        badPasswords(170) = "testing"
        badPasswords(171) = "naked"
        badPasswords(172) = "beavis"
        badPasswords(173) = "butthead"
        badPasswords(174) = "hooters"
        badPasswords(175) = "aaaaaa"
        badPasswords(176) = "bigdaddy"
        badPasswords(177) = "birdie"
        badPasswords(178) = "bitchies"
        badPasswords(179) = "boston"
        badPasswords(180) = "canada"
        badPasswords(181) = "cocacola"
        badPasswords(182) = "cowboy"
        badPasswords(183) = "cowboys"
        badPasswords(184) = "doggie"
        badPasswords(185) = "falcon"
        badPasswords(186) = "fishing"
        badPasswords(187) = "golfer"
        badPasswords(188) = "hotdog"
        badPasswords(189) = "iceman"
        badPasswords(190) = "maddog"
        badPasswords(191) = "magnum"
        badPasswords(192) = "maverick"
        badPasswords(193) = "naughty"
        badPasswords(194) = "nipples"
        badPasswords(195) = "player"
        badPasswords(196) = "pussies"
        badPasswords(197) = "rocket"
        badPasswords(198) = "rush2112"
        badPasswords(199) = "scooby"
        badPasswords(200) = "sexsex"
        badPasswords(201) = "shaved"
        badPasswords(202) = "skippy"
        badPasswords(203) = "steelers"
        badPasswords(204) = "trouble"
        badPasswords(205) = "vagina"
        badPasswords(206) = "winner"
        badPasswords(207) = "zzzzzz"
        badPasswords(208) = "zzzzzzz"
        badPasswords(209) = "zzzzzzzz"


        For i = 0 To badPasswords.Length - 1

            If txtPassword.Text.ToLower() = badPasswords(i) Then
                lblWrongPass.Visible = True
                Exit Sub
            ElseIf txtPassword.Text.Length <= 5 Then
                lblWrongPass.Visible = True
                Exit Sub
            End If

        Next i

        Dim fecha As String = getMySQLDate()

        If executeSQLCommand("UPDATE users SET suserpasswordhash = '" & EncryptText(txtPassword.Text) & "' WHERE susername = '" & Session("username") & "'") = True Then

            If logLogin(Me, Session("username"), findRemoteIP(Me), findRemoteMachineName(), True) Then

                Session("providedUsername") = ""

                Dim iresetid As Integer = 1
                iresetid = getSQLQueryAsInteger("SELECT IF(MAX(ipasswordresetid) + 1 IS NULL, 1, MAX(ipasswordresetid) + 1) AS ipasswordresetid FROM passwordresets ORDER BY resetdate DESC LIMIT 1")

                Dim queries(2) As String

                queries(0) = "DELETE FROM passwordresetrequests WHERE susername = '" & Session("username") & "'"

                queries(1) = "INSERT INTO passwordresets VALUES (" & iresetid & ", '" & Session("username") & "', '" & fecha & "')"

                executeTransactedSQLCommand(queries)

                Dim ilogid As Integer = 1
                ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

                executeSQLCommand("INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & Session("username") & "', '" & Session.SessionID & "', '" & findRemoteIP(Me) & "', '" & findRemoteMachineName() & "', 'Password Change Attempt - Result : True', '1')")

                Response.Redirect("main.aspx")

            Else

                Dim ilogid As Integer = 1
                ilogid = getSQLQueryAsInteger("SELECT IF(MAX(ilogid) + 1 IS NULL, 1, MAX(ilogid) + 1) AS ilogid FROM sqllogs ORDER BY querydate DESC LIMIT 1")

                executeSQLCommand("INSERT INTO sqllogs VALUES(" & ilogid & ", '" & fecha & "', '" & Session("username") & "', '" & Session.SessionID & "', '" & findRemoteIP(Me) & "', '" & findRemoteMachineName() & "', 'Password Change Attempt - Result : False', '0')")

            End If

        End If

    End Sub

End Class